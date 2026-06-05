# Welever Product Kit — Construis des Produits Digitaux avec l'IA

Un pipeline 10-phases qui construit des produits digitaux complets dans Notion — de la définition de l'idée à la génération de contenu en passant par la livraison soignée.

Ce répertoire est **autonome et exportable** — il contient tout ce qui est nécessaire pour exécuter l'ensemble du pipeline.

## Pipeline Phases

| Phase | Agent | Ce Qu'elle Fait |
|-------|-------|-------------|
| 0 | construire-produit | Orchestre toutes les phases, gère l'état |
| 1 | idee-produit | Définis le type de produit, la niche, l'ICP, les variables |
| 2 | creer-base | Crée une base de données Notion avec propriétés et vues |
| 3 | profil-expert | Construit une persona d'expert de domaine pour la voix du contenu |
| 4 | structure-contenu | Définis la structure de page, sections, longueurs |
| 5 | ecrire-prompt | Combine profil + structure dans un prompt de génération |
| 6 | tester-contenu | Génère 2-3 pages d'exemple pour révision |
| 7 | generer-contenu | Traite en batch toutes les entrées avec des agents parallèles |
| 7.5 | generer-images | *(Optionnel)* Génère des images IA pour les entrées/page d'accueil et les télécharge dans Notion |
| 8 | designer-produit | Crée page d'accueil, navigation, icônes |
| 9 | qa-produit | Analyse les problèmes de qualité, les signale pour régénération |
| 10 | etendre-produit | Suggère des produits complémentaires |

## Agents de Support

- **page-accueil** — Crée des pages d'accueil Notion avec navigation structurée
- **vues-sous-pages** — Configure les vues de base de données liées sur les sous-pages
- **generateur-prompt** — Génère des prompts de création de base de données pour les idées de produits
- **welever-aide** — FAQ, dépannage, et statut du projet pour le pipeline
- **welever-onboard** — Guide de configuration première utilisation et vérification de préparation

## Skills

### construire-produit
**Commande slash :** `/construire-produit`
**Déclencheurs :** "construis un produit digital", "crée un produit", "démarre une construction",
"nouveau produit", "construis un produit Notion", "crée un produit de zéro"
**Description :** Orchestre 10 agents spécialisés pour construire un produit digital complet
dans Notion — de la définition de l'idée à la génération de contenu en passant par la livraison soignée.

### idee-produit
**Commande slash :** `/idee-produit`
**Déclencheurs :** "définis une idée de produit", "planifie un produit", "choisis un type de produit",
"identifie les variables", "démarre un nouveau produit"
**Description :** Définis le type de produit, la niche, l'ICP, et identifie la structure fixe
vs variables pour la génération automatique de contenu.

### creer-base
**Commande slash :** `/creer-base`
**Déclencheurs :** "crée une base de données Notion", "construis une base de produit", "configure la base",
"configure la base de contenu"
**Description :** Crée une base de données Notion via l'API REST avec propriétés, vues,
workflow de statut (Brouillon → Publié), et entrées d'exemple.

### profil-expert
**Commande slash :** `/profil-expert`
**Déclencheurs :** "construis un profil expert", "crée une persona d'expert", "définis la voix",
"configure le ton d'écriture"
**Description :** Recherche le domaine du produit et construit une persona d'expert détaillée
avec voix, ton, vocabulaire, perspective, et limites de connaissance.

### structure-contenu
**Commande slash :** `/structure-contenu`
**Déclencheurs :** "définis la structure du contenu", "crée un template de page", "planifie la structure",
"conçois la mise en page"
**Description :** Définis la structure exacte de chaque page — sections, ordre, niveau de détail,
longueurs, règles de formatage, et dépendances de variables.

### ecrire-prompt
**Commande slash :** `/ecrire-prompt`
**Déclencheurs :** "crée un prompt de génération", "écris un prompt", "construis le prompt",
"assemble le prompt IA"
**Description :** Combine profil expert + structure contenu + variables de base dans un
prompt de génération optimisé et paramétrisé.

### tester-contenu
**Commande slash :** `/tester-contenu`
**Déclencheurs :** "teste la génération", "génère des échantillons", "prévisualise le contenu",
"essai du pipeline"
**Description :** Génère 2-3 pages d'exemple pour révision et itération avant la production complète.
Trace les problèmes de qualité jusqu'aux artefacts en amont.

### generer-contenu
**Commande slash :** `/generer-contenu`
**Déclencheurs :** "génère tout le contenu", "lance la production", "génère en batch",
"remplit la base", "publie les brouillons"
**Description :** Traite en batch toutes les entrées Brouillon en utilisant des sous-agents parallèles,
écrit le contenu dans les pages Notion via l'API, et marque les entrées comme Publiées.

### generer-images
**Commande slash :** `/generer-images`
**Déclencheurs :** "génère des images", "ajoute des couvertures", "illustre avec l'IA",
"crée les images de la page d'accueil", "génère en batch", "images IA pour Notion"
**Description :** *(Phase 7.5 optionnelle)* Génère des images IA pour le produit en utilisant OpenAI
(`gpt-image-2`) ou kie.ai (`gpt-image-2-text-to-image`). Trois modes : couverture seule (une
image par entrée comme couverture de page), multi-section (couverture + N images inline après
les titres cibles — mise en page magazine pour recettes, tutoriels, cas d'études), ou
style-batch (N images partageant un style, pour la page d'accueil). Transparent sur les coûts — affiche
toujours les dépenses estimées avec approbation explicite avant tout appel API.

### designer-produit
**Commande slash :** `/designer-produit`
**Déclencheurs :** "conçois le produit", "crée la page d'accueil", "configure la navigation",
"publie le produit", "rends-le professionnel"
**Description :** Crée une page d'accueil soignée avec sections de navigation, vues filtrées,
icônes emoji, et lien Notion partageable.

### qa-produit
**Commande slash :** `/qa-produit`
**Déclencheurs :** "lance la QA", "vérifie la qualité", "analyse les problèmes", "audite le contenu",
"révise la qualité"
**Description :** Analyse toutes les pages publiées contre le profil expert et la structure contenu.
Signale les formulations répétitives, sections manquantes, dérives de ton, et contenu mince.

### etendre-produit
**Commande slash :** `/etendre-produit`
**Déclencheurs :** "suggère les prochains produits", "étends la gamme", "produits complémentaires",
"grandir dans les produits digitaux"
**Description :** Analyse le produit complété et suggère 3-5 produits complémentaires
servant le même public.

### page-accueil
**Commande slash :** `/page-accueil`
**Déclencheurs :** "crée une page d'accueil", "construis une page d'accueil", "édite la mise en page",
"restructure la page", "configure la page de navigation", "organise les sous-pages"
**Description :** Crée ou édite les pages d'accueil Notion avec navigation structurée —
intro callout, toggles collapsibles, en-têtes de section avec mises en page à 2 colonnes.

### vues-sous-pages
**Commande slash :** `/vues-sous-pages`
**Déclencheurs :** "crée des vues de liste filtrées", "configure les vues de base liées", "supprime les anciennes",
"masque les titres", "configure les affichages de base sur les sous-pages", "setup en bulk"
**Description :** Configure les vues de base de données liées sur les sous-pages à l'échelle — crée des
vues de liste filtrées, supprime les anciennes vues, et masque les titres sources.

### generateur-prompt
**Commande slash :** `/generateur-prompt`
**Déclencheurs :** "génère les prompts de base", "crée les prompts Notion", "construis les prompts",
"génère un prompt", "génère en batch"
**Description :** Génère des prompts de création de base de données Notion prêts à coller pour les idées de produits digitaux.

### welever-aide
**Commande slash :** `/welever-aide`
**Déclencheurs :** "comment marche le constructeur", "que fait cette phase", "pourquoi ça a échoué",
"qu'est-ce qui vient après", "aide Welever", "question sur le constructeur", "ce qui s'est mal passé",
"dépanne cette erreur", "explique ce résultat", "où j'en suis"
**Description :** Répond aux questions sur le pipeline Welever Product Kit — comment marche chaque phase, ce que signifient les résultats,
pourquoi ça a échoué, et quoi faire ensuite. Consciente du contexte des projets actifs. Trois modes :
Demander (FAQ générale), Diagnostiquer (dépanne les problèmes), Statut (tableau de bord de projet).

### welever-onboard
**Commande slash :** `/welever-onboard`
**Déclencheurs :** "configure Welever", "première fois avec le constructeur", "configure Notion",
"prérequis Welever", "onboard à Welever", "comment je commence",
"vérifie mon setup", "check ma configuration"
**Description :** Guide les utilisateurs pour la première fois à travers le setup complet de Welever — installation de Node.js,
création de l'intégration Notion, configuration de NOTION_TOKEN, partage de pages, vérification du serveur MCP,
et walkthrough du pipeline avec conseils pour les meilleurs résultats.

## Références Partagées

- `shared/notion-api-reference.md` — Motifs et aides API Notion
- `shared/product-types-reference.md` — Définitions et variables de type de produit

## Scripts

Les scripts Node.js spécifiques à Welever Product Kit se trouvent dans `scripts/` dans ce répertoire.

## Résultat

Tout le résultat de la construction de produit va dans `output/{slug-projet}/`.

## Prérequis

- Serveur MCP Notion connecté (`.mcp.json` → `notion`)
- Node.js 18+ installé

## Démarrer

- **Première fois ?** Exécute `/welever-onboard` pour configurer les prérequis et apprendre le pipeline.
- **Prêt à construire ?** Exécute `/construire-produit` pour démarrer une nouvelle construction de produit.
- **Besoin d'aide ?** Exécute `/welever-aide` pour les FAQ, dépannage, ou statut du projet.
