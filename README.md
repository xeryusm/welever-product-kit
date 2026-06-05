# Welever Product Kit — Construis des Produits Digitaux avec l'IA

Construis des produits digitaux complets dans Notion en utilisant l'IA. Décris ton idée de produit, et le Welever Product Kit gère tout — création de base de données, voix d'écriture, structure de contenu, génération de contenu alimentée par l'IA, design de page d'accueil, et assurance qualité.

**10 phases. Une commande. Un produit fini.**

---

## What It Builds

Le Welever Product Kit crée des produits digitaux basés sur Notion avec des dizaines à des centaines de pages générées par l'IA. Chaque page est rédigée par un profil d'expert personnalisé, structurée selon un blueprint de contenu, et vérifiée pour la qualité avant livraison.

**Types de produits supportés :**

| Type | Exemple |
|------|---------|
| Ebook | "Le Guide Nutrition Hyrox" — 20 chapitres sur l'alimentation en course |
| SOP | "SOPs Onboarding Agence" — 50 procédures détaillées |
| Workbook | "Le Workbook Stratégie de Marque" — 30 exercices interactifs |
| Template | "100 Templates d'Email pour Agents Immobiliers" |
| Checklist | "Librairie Checklists Lancement Produit" — 40 listes de contrôle |
| Guide / Playbook | "Playbooks Croissance par Canal" — 25 guides marketing |
| Prompt Pack | "200 Prompts ChatGPT pour Créateurs de Contenu" |
| Swipe File | "Swipe File Landing Pages Convertissantes" — 75 exemples |
| Scripts | "50 Scripts Appels de Vente pour Coachs" |
| Online Course | "Cours Complet Marketing Pinterest" — 30 leçons |

---

## Installation Rapide

**Une commande** — exécute ceci dans ton répertoire de projet Claude Code :

```bash
git clone https://github.com/xeryusm/welever-product-kit.git welever-product-kit && bash welever-product-kit/install.sh
```

---

## Rester à Jour

Quand une nouvelle version sort, exécute ceci pour mettre à jour :

```bash
cd welever-product-kit && bash update.sh
```

Voilà tout le processus de mise à jour. Le script :

- Sauvegarde tes modifications locales (stashées automatiquement)
- Tire la dernière version depuis GitHub
- Enregistre les nouvelles commandes slash
- Restaure tes modifications locales
- Affiche un résumé des nouvelles fonctionnalités

Tes produits dans `output/` et tes commandes slash existantes ne sont jamais touchés.

Tu peux aussi coller ceci dans la discussion Claude Code et il le fera pour toi :

```
Mets à jour Welever Product Kit à la dernière version.
```

---

## Prérequis

| Prérequis | Pourquoi |
|---|---|
| **Claude Code** | L'assistant IA qui exécute Welever Product Kit |
| **Node.js 18+** | Exécute les scripts qui interagissent avec l'API Notion |
| **Compte Notion** | Où tes produits sont créés et livrés |
| **Intégration Notion** | Donne au Welever Product Kit la permission de lire/écrire dans ton espace Notion |

Ne t'inquiète pas pour la configuration manuelle — exécute `/welever-onboard` après l'installation et il te guide à travers chaque étape.

---

## Démarrer

1. **Installe** en utilisant la commande ci-dessus
2. **Exécute `/welever-onboard`** — configuration guidée des prérequis (Node.js, intégration Notion, token API)
3. **Exécute `/construire-produit`** — commence à construire ton premier produit digital

C'est tout. Le pipeline te guide à travers chaque décision avec des approbations à chaque phase.

---

## Comment Ça Marche

Le Welever Product Kit exécute 10 phases séquentielles, chacune gérée par un agent IA spécialisé :

| Phase | Ce Qui Se Passe |
|-------|-------------|
| 1. **Idée de Produit** | Définis ce à construire — type de produit, niche, audience, variables |
| 2. **Créer la Base** | Crée une base de données Notion avec propriétés et entrées d'exemple |
| 3. **Profil Expert** | Construis une persona d'écriture — voix, ton, vocabulaire, expertise |
| 4. **Structure Contenu** | Définis la structure de page — sections, longueurs, formatage |
| 5. **Écrire Prompt** | Combine expert + structure dans un prompt de génération |
| 6. **Tester Contenu** | Génère 2-3 pages d'exemple pour révision (quality gate) |
| 7. **Générer Contenu** | Génère tout le contenu en parallèle, écrit dans Notion |
| 7.5. **Générer Images** *(optionnel)* | Génère des images de couverture IA pour les entrées — ou des mises en page magazine complètes avec couverture + images inline — via OpenAI ou kie.ai. Ta clé API, ta dépense. Vois [IMAGES-QUICKSTART.md](IMAGES-QUICKSTART.md) pour le guide complet. |
| 8. **Designer Produit** | Crée page d'accueil avec navigation, icônes, lien partageable |
| 9. **QA Produit** | Analyse chaque page pour les problèmes de qualité |
| 10. **Étendre Produit** | Suggère les produits complémentaires à construire ensuite |

**Temps de construction :** 45-120 minutes selon la taille du produit.

Chaque phase fait une pause pour ton approbation. Tu peux revenir en arrière, réviser, ou sauter en avant. Si tu fermes en cours de construction, exécute `/construire-produit {nom-projet}` pour reprendre exactement où tu t'es arrêté.

---

## Toutes les Commandes

| Commande | Ce Qu'elle Fait |
|---------|-------------|
| `/construire-produit` | Démarre ou reprend une construction de produit complète |
| `/idee-produit` | Définis une idée de produit (standalone) |
| `/creer-base` | Crée une base de données Notion |
| `/profil-expert` | Construis une persona d'écriture expert |
| `/structure-contenu` | Définis la structure du contenu de page |
| `/ecrire-prompt` | Assemble le prompt de génération |
| `/tester-contenu` | Génère des échantillons de test |
| `/generer-contenu` | Génère tout le contenu en batch |
| `/generer-images` | *(Optionnel)* Génère des images de couverture IA via OpenAI ou kie.ai |
| `/designer-produit` | Crée page d'accueil et navigation |
| `/qa-produit` | Exécute un scan d'assurance qualité |
| `/etendre-produit` | Suggère les produits complémentaires |
| `/welever-aide` | Pose des questions, dépanne, vérifie le statut |
| `/welever-onboard` | Guide de configuration première utilisation |

---

## Conseils pour les Meilleurs Résultats

1. **Sois précis sur ta niche.** "Fitness" c'est trop large. "Nutrition pour course Hyrox pour athlètes débutants" c'est parfait.
2. **Le profil expert compte le plus.** La phase 3 définit la voix d'écriture — prends du temps pour réviser l'échantillon de voix.
3. **La phase 6 est ton filet de sécurité.** Révise les échantillons de test attentivement avant de t'engager dans la génération complète.
4. **Commence petit.** 30-50 entrées pour ta première construction. Tu peux toujours étendre plus tard.
5. **Exécute `/welever-aide` à tout moment.** Elle lit l'état de ton projet et donne des réponses conscientes du contexte.

---

## Support

Exécute `/welever-aide` dans Claude Code pour des réponses instantanées sur n'importe quelle phase, erreur, ou question.

---

Construit avec Claude Code. Créé par Welever.
