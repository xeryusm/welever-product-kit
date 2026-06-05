#!/bin/bash
# Welever Product Kit — Updater
# Pulls the latest version, registers any new slash commands, preserves your data.
# Run from inside welever-product-kit/:  bash update.sh
# Compatible with bash 3.2+ (macOS default)

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Move to script directory so it works regardless of where it's called from
cd "$(dirname "$0")"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Welever Product Kit — Mise à jour vers la dernière version${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── 1. Sanity checks ────────────────────────────────────────────────────────

if [ ! -d ".git" ]; then
  echo -e "${RED}[err]${NC} Ceci ne ressemble pas à un clone de welever-product-kit (aucun répertoire .git trouvé)."
  echo "       Exécute ce script depuis le dossier welever-product-kit/."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo -e "${RED}[err]${NC} git n'est pas installé. Installe git d'abord, puis réexécute ce script."
  exit 1
fi

# ── 2. Capture current state for the summary ────────────────────────────────

CURRENT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
CURRENT_MSG=$(git log -1 --pretty=format:'%s' 2>/dev/null || echo "unknown")

# ── 3. Stash any local tracked-file changes automatically ──────────────────

HAS_LOCAL_CHANGES=0
STASH_REF=""
if ! git diff --quiet HEAD 2>/dev/null || ! git diff --quiet --cached 2>/dev/null; then
  HAS_LOCAL_CHANGES=1
  STASH_REF="welever-product-kit-update-$(date +%Y%m%d-%H%M%S)"
  echo -e "${YELLOW}[!]${NC}  Modifications locales détectées — sauvegarde sécurisée en cours"
  git stash push -m "$STASH_REF" --quiet
  echo -e "${GREEN}[ok]${NC} Changements locaux sauvegardés comme : $STASH_REF"
  echo ""
fi

# ── 4. Fetch + pull ─────────────────────────────────────────────────────────

echo -e "${BLUE}[..]${NC} Récupération de la dernière version depuis GitHub..."
if ! git fetch --quiet 2>&1; then
  echo -e "${RED}[err]${NC} La récupération a échoué. Vérifie ta connexion Internet ou l'accès au repo."
  if [ "$HAS_LOCAL_CHANGES" -eq 1 ]; then
    echo "       Tes changements sont sécurisés dans : git stash list (cherche '$STASH_REF')"
  fi
  exit 1
fi

# Check if there's anything new
LOCAL_HEAD=$(git rev-parse HEAD)
REMOTE_HEAD=$(git rev-parse @{u} 2>/dev/null || echo "$LOCAL_HEAD")

if [ "$LOCAL_HEAD" = "$REMOTE_HEAD" ]; then
  echo -e "${GREEN}[ok]${NC} Tu es déjà sur la dernière version."
  ALREADY_LATEST=1
else
  ALREADY_LATEST=0
  echo -e "${BLUE}[..]${NC} Récupération des nouveaux commits..."
  if ! PULL_OUTPUT=$(git pull --ff-only 2>&1); then
    echo -e "${RED}[err]${NC} Impossible de fusionner proprement. Raison :"
    echo "$PULL_OUTPUT" | sed 's/^/       /'
    echo ""
    echo "       Causes courantes :"
    echo "         - Tu as des commits locaux qui ne sont pas sur GitHub  →  git pull --rebase"
    echo "         - Des fichiers non suivis seraient écrasés              →  supprime ou renomme-les"
    if [ "$HAS_LOCAL_CHANGES" -eq 1 ]; then
      echo ""
      echo "       Tes modifications sont sécurisées dans : git stash list (cherche '$STASH_REF')"
    fi
    exit 1
  fi
  NEW_COMMIT=$(git rev-parse --short HEAD)
  echo -e "${GREEN}[ok]${NC} Mis à jour vers $NEW_COMMIT"
fi

# ── 5. Register any new slash commands via install.sh ──────────────────────

echo -e "${BLUE}[..]${NC} Enregistrement de nouvelles commandes slash..."
INSTALL_LOG="/tmp/welever-product-kit-update-install-$$.log"
if bash install.sh > "$INSTALL_LOG" 2>&1; then
  # Extract the slash-commands line from install.sh output (strip ANSI escapes)
  SKILL_LINE=$(grep -oE "(Enregistré|déjà enregistrées)[A-Za-z0-9 ./-]+" "$INSTALL_LOG" | tail -1)
  echo -e "${GREEN}[ok]${NC} ${SKILL_LINE:-Commandes slash enregistrées}"
  rm -f "$INSTALL_LOG"
else
  echo -e "${RED}[err]${NC} install.sh a échoué. Voir le log : $INSTALL_LOG"
  if [ "$HAS_LOCAL_CHANGES" -eq 1 ]; then
    echo "       Tes modifications sont sécurisées dans : git stash list (cherche '$STASH_REF')"
  fi
  exit 1
fi

# ── 6. Restore local changes (if any) ──────────────────────────────────────

STASH_RESTORED=0
STASH_CONFLICT=0
if [ "$HAS_LOCAL_CHANGES" -eq 1 ]; then
  echo -e "${BLUE}[..]${NC} Restauration de tes modifications locales..."
  if git stash pop --quiet 2>/dev/null; then
    STASH_RESTORED=1
    echo -e "${GREEN}[ok]${NC} Modifications locales restaurées proprement"
  else
    STASH_CONFLICT=1
    echo -e "${YELLOW}[!]${NC}  Tes modifications entrent en conflit avec la nouvelle version (rare)"
    echo "       Tes modifications sont toujours sécurisées — conservées comme stash : $STASH_REF"
    echo "       Pour restaurer manuellement : git stash pop  (puis résous le conflit)"
    echo "       Pour les supprimer :         git stash drop"
  fi
fi

# ── 7. Summary ──────────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Mise à jour terminée !${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [ "$ALREADY_LATEST" -eq 1 ]; then
  echo "  Tu étais déjà sur la dernière version : $CURRENT_COMMIT"
  echo "  ($CURRENT_MSG)"
else
  NEW_COMMIT=$(git rev-parse --short HEAD)
  NEW_MSG=$(git log -1 --pretty=format:'%s')
  echo "  Avant :  $CURRENT_COMMIT  ($CURRENT_MSG)"
  echo "  Après :  $NEW_COMMIT  ($NEW_MSG)"
  echo ""
  echo "  Quoi de neuf :"
  git log "$CURRENT_COMMIT..HEAD" --pretty=format:'    • %s' --reverse 2>/dev/null || echo "    (détails des commits indisponibles)"
  echo ""
fi

if [ "$STASH_CONFLICT" -eq 1 ]; then
  echo ""
  echo -e "${YELLOW}  Attention :${NC} Tes modifications précédentes sont sauvegardées comme stash."
  echo "  Exécute \`git stash list\` pour les voir, ou \`git stash pop\` pour les restaurer (et résoudre)."
fi

echo ""
echo "  Tes produits dans output/ et tes commandes slash dans .claude/skills/ sont intacts."
echo "  Exécute /welever-aide dans Claude Code si tu as des questions."
echo ""
