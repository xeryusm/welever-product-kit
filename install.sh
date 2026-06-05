#!/bin/bash
# Welever Product Kit — Installation Script
# Installs the Welever Product Kit into your Claude Code project.
# Compatible with bash 3.2+ (macOS default)

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Welever Product Kit${NC}"
echo -e "${BLUE}  Installation dans ton projet Claude Code...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect project root (go up from the cloned directory)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
INSTALL_DIR="$PROJECT_ROOT/welever-product-kit"

# Check if already in the right place
if [ "$(basename "$SCRIPT_DIR")" = "welever-product-kit" ]; then
  echo -e "${GREEN}[ok]${NC} Déjà installé à $SCRIPT_DIR"
else
  # Move the cloned repo to welever-product-kit/ in the parent directory
  if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}[!]${NC} welever-product-kit/ existe déjà à $INSTALL_DIR"
    echo "    Supprime-le d'abord ou installe manuellement."
    exit 1
  fi
  mv "$SCRIPT_DIR" "$INSTALL_DIR"
  SCRIPT_DIR="$INSTALL_DIR"
  echo -e "${GREEN}[ok]${NC} Déplacé vers $INSTALL_DIR"
fi

# Create output and scripts directories (gitignored, needed at runtime)
mkdir -p "$INSTALL_DIR/output"
mkdir -p "$INSTALL_DIR/scripts"
echo -e "${GREEN}[ok]${NC} Répertoires output/ et scripts/ créés"

# Register all slash commands in .claude/skills/
SKILLS_DIR="$PROJECT_ROOT/.claude/skills"
SKILL_COUNT=0

# Helper function: create a skill stub if it doesn't exist
create_skill() {
  local name="$1"
  local desc="$2"
  local arg_hint="$3"
  local body="$4"

  local skill_dir="$SKILLS_DIR/$name"
  local skill_file="$skill_dir/SKILL.md"

  if [ -f "$skill_file" ]; then
    return
  fi

  mkdir -p "$skill_dir"

  if [ -n "$arg_hint" ]; then
    printf "%s\n" "---" "name: $name" "description: $desc" "$arg_hint" "---" "" > "$skill_file"
  else
    printf "%s\n" "---" "name: $name" "description: $desc" "---" "" > "$skill_file"
  fi

  printf "%b\n" "$body" >> "$skill_file"
  SKILL_COUNT=$((SKILL_COUNT + 1))
}

create_skill "construire-produit" \
  "Construis un produit digital complet dans Notion — orchestre 10 phases de l'idée à la livraison." \
  "argument-hint: [nom-projet]" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/construire-produit/SKILL.md\`.\n\nAvant de commencer, lis aussi :\n- \`welever-product-kit/construire-produit/reference.md\`\n- \`welever-product-kit/shared/notion-api-reference.md\`\n- \`welever-product-kit/shared/product-types-reference.md\`"

create_skill "idee-produit" \
  "Définis une idée de produit — type, niche, ICP, variables, et mode de livraison." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/idee-produit/SKILL.md\`."

create_skill "creer-base" \
  "Crée une base de données Notion avec propriétés, vues, workflow de statut, et entrées d'exemple." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/creer-base/SKILL.md\`.\n\nLis aussi \`welever-product-kit/shared/notion-api-reference.md\` pour les motifs API."

create_skill "profil-expert" \
  "Construis une persona d'expert — voix, ton, vocabulaire, et perspective pour la génération de contenu." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/profil-expert/SKILL.md\`."

create_skill "structure-contenu" \
  "Définis la structure de page — sections, longueurs, règles de formatage, et dépendances de variables." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/structure-contenu/SKILL.md\`."

create_skill "ecrire-prompt" \
  "Assemble profil expert + structure contenu dans un prompt de génération optimisé." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/ecrire-prompt/SKILL.md\`."

create_skill "tester-contenu" \
  "Génère 2-3 pages d'exemple pour révision — le quality gate avant la production complète." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/tester-contenu/SKILL.md\`."

create_skill "generer-contenu" \
  "Génère tout le contenu en batch en utilisant des agents parallèles et publie dans Notion." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/generer-contenu/SKILL.md\`.\n\nLis aussi \`welever-product-kit/shared/notion-api-reference.md\` pour les motifs API."

create_skill "generer-images" \
  "Génère des images IA pour les entrées ou la page d'accueil via OpenAI ou kie.ai. Trois modes : couverture seule, multi-section, style-batch. Phase 7.5 optionnelle." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/generer-images/SKILL.md\`.\n\nLis aussi :\n- \`welever-product-kit/generer-images/reference.md\`\n- \`welever-product-kit/shared/notion-api-reference.md\`"

create_skill "designer-produit" \
  "Crée une page d'accueil soignée avec sections de navigation, vues filtrées, icônes, et lien partageable." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/designer-produit/SKILL.md\`.\n\nLis aussi :\n- \`welever-product-kit/designer-produit/reference.md\`\n- \`welever-product-kit/shared/notion-api-reference.md\`"

create_skill "qa-produit" \
  "Analyse toutes les pages publiées pour les problèmes de qualité — répétitions, sections manquantes, dérives de ton." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/qa-produit/SKILL.md\`."

create_skill "etendre-produit" \
  "Suggère 3-5 produits complémentaires à construire ensuite pour le même audience." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/etendre-produit/SKILL.md\`."

create_skill "page-accueil" \
  "Crée ou édite les pages d'accueil Notion avec navigation structurée et mises en page à 2 colonnes." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/page-accueil/SKILL.md\`.\n\nLis aussi \`welever-product-kit/page-accueil/reference.md\`."

create_skill "vues-sous-pages" \
  "Configure les vues de base de données liées sur les sous-pages — crée des vues filtrées, supprime les anciennes, masque les titres." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/vues-sous-pages/SKILL.md\`.\n\nLis aussi \`welever-product-kit/vues-sous-pages/reference.md\`."

create_skill "generateur-prompt" \
  "Génère des prompts de création de base de données Notion prêts à coller pour les idées de produits digitaux." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/generateur-prompt/SKILL.md\`."

create_skill "welever-aide" \
  "Pose des questions sur le pipeline Welever Product Kit, dépanne les erreurs, ou vérifie le statut du projet." \
  "argument-hint: [question]" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/welever-aide/SKILL.md\`.\n\nLis aussi \`welever-product-kit/welever-aide/reference.md\` pour les FAQ, catalogue d'erreurs, et résumés de phases."

create_skill "welever-onboard" \
  "Guide de configuration première utilisation — Node.js, intégration Notion, NOTION_TOKEN, et walkthrough du pipeline." \
  "" \
  "Lis et suis les instructions complètes dans \`welever-product-kit/welever-onboard/SKILL.md\`.\n\nLis aussi \`welever-product-kit/welever-onboard/reference.md\` pour les guides de configuration et dépannage."

if [ "$SKILL_COUNT" -gt 0 ]; then
  echo -e "${GREEN}[ok]${NC} Enregistré $SKILL_COUNT nouvelles commandes slash dans .claude/skills/"
else
  echo -e "${GREEN}[ok]${NC} Les 17 commandes slash sont déjà enregistrées dans .claude/skills/"
fi

# Add Welever Product Kit registration to root CLAUDE.md if not already present
CLAUDE_MD="$PROJECT_ROOT/CLAUDE.md"
if [ -f "$CLAUDE_MD" ]; then
  if grep -q "welever-product-kit" "$CLAUDE_MD" 2>/dev/null; then
    echo -e "${GREEN}[ok]${NC} CLAUDE.md a déjà l'enregistrement Welever Product Kit"
  else
    cat >> "$CLAUDE_MD" << 'REGISTRATION'

---

### Welever Product Kit (`welever-product-kit/`)

Vois `welever-product-kit/CLAUDE.md` pour la documentation complète du pipeline.

**Démarrage rapide :**
- `/welever-onboard` — Guide de configuration première utilisation
- `/construire-produit` — Construis un nouveau produit digital
- `/welever-aide` — FAQ et dépannage

**Toutes les commandes :** `/construire-produit`, `/idee-produit`, `/creer-base`, `/profil-expert`,
`/structure-contenu`, `/ecrire-prompt`, `/tester-contenu`, `/generer-contenu`,
`/generer-images`, `/designer-produit`, `/qa-produit`, `/etendre-produit`, `/page-accueil`,
`/vues-sous-pages`, `/generateur-prompt`, `/welever-aide`, `/welever-onboard`
REGISTRATION
    echo -e "${GREEN}[ok]${NC} Enregistrement Welever Product Kit ajouté à CLAUDE.md"
  fi
else
  cat > "$CLAUDE_MD" << 'NEWCLAUDE'
# Instructions du Projet

## Welever Product Kit (`welever-product-kit/`)

Vois `welever-product-kit/CLAUDE.md` pour la documentation complète du pipeline.

**Démarrage rapide :**
- `/welever-onboard` — Guide de configuration première utilisation
- `/construire-produit` — Construis un nouveau produit digital
- `/welever-aide` — FAQ et dépannage

**Toutes les commandes :** `/construire-produit`, `/idee-produit`, `/creer-base`, `/profil-expert`,
`/structure-contenu`, `/ecrire-prompt`, `/tester-contenu`, `/generer-contenu`,
`/generer-images`, `/designer-produit`, `/qa-produit`, `/etendre-produit`, `/page-accueil`,
`/vues-sous-pages`, `/generateur-prompt`, `/welever-aide`, `/welever-onboard`
NEWCLAUDE
  echo -e "${GREEN}[ok]${NC} CLAUDE.md créé avec l'enregistrement Welever Product Kit"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation terminée !${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  Prochaines étapes :"
echo ""
echo "  1. Ouvre Claude Code dans ce répertoire de projet"
echo "  2. Exécute /welever-onboard pour configurer les prérequis"
echo "     (Intégration Notion, NOTION_TOKEN, Node.js)"
echo "  3. Exécute /construire-produit pour créer ton premier produit digital"
echo ""
echo "  Besoin d'aide ? Exécute /welever-aide à tout moment."
echo ""
