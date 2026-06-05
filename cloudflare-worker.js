// Welever Product Kit — Install Worker
// Déploie sur Cloudflare Workers
// URL : https://install.welever.fr/install?key=wk-xxxxx

// ✅ KV Store pour les clés (à configurer dans Cloudflare)
// Exemple clé : wk-demo-access-2024-01
// Valeur : { "active": true, "created": "2026-06-05", "email": "user@example.com" }

export default {
  async fetch(request) {
    const url = new URL(request.url);
    const path = url.pathname;
    const key = url.searchParams.get('key');

    // Route: GET /install?key=wk-xxxxx
    if (path === '/install' && request.method === 'GET') {
      if (!key) {
        return new Response('❌ Clé manquante. Usage: ?key=wk-xxxxxxxx', {
          status: 400,
          headers: { 'Content-Type': 'text/plain; charset=utf-8' }
        });
      }

      // Valider la clé dans KV Store
      const KV = WELEVER_KEYS; // Lié dans wrangler.toml
      const keyData = await KV.get(key);

      if (!keyData) {
        return new Response('❌ Clé invalide ou expirée.', {
          status: 403,
          headers: { 'Content-Type': 'text/plain; charset=utf-8' }
        });
      }

      const data = JSON.parse(keyData);
      if (!data.active) {
        return new Response('❌ Clé désactivée.', {
          status: 403,
          headers: { 'Content-Type': 'text/plain; charset=utf-8' }
        });
      }

      // ✅ Clé valide — retourner le script d'installation
      const installScript = getInstallScript(key);
      return new Response(installScript, {
        status: 200,
        headers: { 'Content-Type': 'text/plain; charset=utf-8' }
      });
    }

    // Route: GET /status (pour vérifier que le worker fonctionne)
    if (path === '/status') {
      return new Response('✅ Welever Install Worker actif', {
        headers: { 'Content-Type': 'text/plain; charset=utf-8' }
      });
    }

    // Route non trouvée
    return new Response('❌ Route non trouvée', {
      status: 404,
      headers: { 'Content-Type': 'text/plain; charset=utf-8' }
    });
  }
};

function getInstallScript(key) {
  return `#!/bin/bash
# Welever Product Kit — Installation Script
# Key: ${key}

set -e

BLUE='\\033[0;34m'
GREEN='\\033[0;32m'
YELLOW='\\033[1;33m'
RED='\\033[0;31m'
NC='\\033[0m'

echo ""
echo -e "\${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\${NC}"
echo -e "\${BLUE}  Welever Product Kit\${NC}"
echo -e "\${BLUE}  Installation en cours...\${NC}"
echo -e "\${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\${NC}"
echo ""

# Télécharger le kit depuis le serveur privé
echo -e "\${BLUE}[..]  Téléchargement du kit...\${NC}"
TEMP_DIR=\$(mktemp -d)
TEMP_ZIP="\$TEMP_DIR/welever-product-kit.zip"

# URL du téléchargement (à adapter selon ton serveur)
DOWNLOAD_URL="https://download.welever.fr/kit?key=${key}"

if ! curl -f -L "\$DOWNLOAD_URL" -o "\$TEMP_ZIP" 2>/dev/null; then
  echo -e "\${RED}[err]  Téléchargement échoué. Clé invalide ?\${NC}"
  rm -rf "\$TEMP_DIR"
  exit 1
fi

echo -e "\${GREEN}[ok]  Kit téléchargé\${NC}"

# Extraire dans le répertoire courant
echo -e "\${BLUE}[..]  Extraction en cours...\${NC}"
unzip -q "\$TEMP_ZIP" -d .
rm -rf "\$TEMP_DIR"

# Lancer install.sh
if [ -f "welever-product-kit/install.sh" ]; then
  echo -e "\${GREEN}[ok]  Extraction complète\${NC}"
  echo ""
  echo -e "\${BLUE}[..]  Exécution du setup...\${NC}"
  bash welever-product-kit/install.sh
else
  echo -e "\${RED}[err]  Fichier install.sh non trouvé\${NC}"
  exit 1
fi

echo ""
echo -e "\${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\${NC}"
echo -e "\${GREEN}  ✅ Installation complète !\${NC}"
echo -e "\${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\${NC}"
echo ""
echo "  Prochaines étapes :"
echo "  1. Ouvre Claude Code"
echo "  2. Exécute : /welever-onboard"
echo "  3. Puis : /construire-produit"
echo ""
`;
}
