<div align="center">

<img src="https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png" alt="Flutter Logo" width="200"/>

<br/><br/>

# 🚀 COURS FLUTTER COMPLET — Du Dart à l'Expert Mobile

### *La formation Flutter la plus complète en langue française*

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Niveau](https://img.shields.io/badge/Niveau-Dart%20→%20Expert%20Flutter-success?style=for-the-badge)](.)
[![Langue](https://img.shields.io/badge/Langue-Français%20🇫🇷-blue?style=for-the-badge)](.)
[![Licence](https://img.shields.io/badge/Licence-MIT-yellow?style=for-the-badge)](.)
[![Chapitres](https://img.shields.io/badge/Chapitres-12-orange?style=for-the-badge)](.)
[![Projets](https://img.shields.io/badge/Projets%20Complets-5-red?style=for-the-badge)](.)

<br/>

> ⚠️ **PRÉREQUIS : Terminer d'abord le cours Dart**
> 👉 **[dart-zero-to-expert-fr](https://github.com/mohameden19961/dart-zero-to-expert-fr)**

<br/>

---

</div>

## 📋 TABLE DES MATIÈRES

| # | Section | Description |
|---|---------|-------------|
| 1 | [🗂️ Structure du projet](#️-structure-du-projet) | cours/ + workspace/ |
| 2 | [⚡ Démarrer maintenant](#-démarrer-maintenant) | Clone + Lance en 3 min |
| 3 | [📚 Contenu du cours](#-contenu-du-cours) | Les 12 chapitres |
| 4 | [📱 Les 5 Projets](#-les-5-projets-complets) | Applications réelles |
| 5 | [🤖 Utiliser l'IA](#-utiliser-lia-avec-ce-cours) | Apprendre 3× plus vite |
| 6 | [📏 Méthode](#-méthode-dapprentissage) | Comment étudier |
| 7 | [⏱ Durée](#-durée-estimée) | Planning hebdomadaire |
| 8 | [🚀 Après ce Cours](#-après-ce-cours) | Carrière & prochaines étapes |
| 9 | [💡 Motivation](#-section-motivation) | Ne jamais abandonner |

---

<br/>

## 🗂️ Structure du projet

```
flutter-cours-complet-fr/
│
├── 📄 README.md
│
├── 📁 cours/                            ← 📖 LES LEÇONS (fichiers .txt — lecture seule)
│   ├── Chapitre_01_Introduction/
│   │   ├── lecon_01_cest_quoi_flutter.txt
│   │   └── lecon_02_architecture_projet.txt
│   ├── Chapitre_02_Installation_Setup/
│   ├── Chapitre_03_Widgets_Basics/
│   ├── Chapitre_04_Layouts/
│   ├── Chapitre_05_Navigation/
│   ├── Chapitre_06_Forms_Inputs/
│   ├── Chapitre_07_State_Management/
│   ├── Chapitre_08_API_HTTP/
│   ├── Chapitre_09_JSON_Parsing/
│   ├── Chapitre_10_Local_Storage/
│   ├── Chapitre_11_UI_UX/
│   ├── Chapitre_12_Performance/
│   ├── projets/                         ← 5 apps complètes (.txt)
│   └── resources/                       ← Cheat sheet (.txt)
│
└── 📁 workspace/                        ← ✏️ TON ESPACE DE TRAVAIL (projet Flutter réel)
    ├── lib/
    │   ├── main.dart                    ← COLLE LES LEÇONS ICI
    │   ├── screens/
    │   ├── widgets/
    │   ├── models/
    │   └── services/
    ├── assets/
    ├── pubspec.yaml                     ← Packages déjà configurés
    └── README.md
```

> 📖 **`cours/`** → fichiers `.txt` à lire — **zéro erreur VS Code**
> ✏️ **`workspace/`** → vrai projet Flutter — **tu codes ici uniquement**

---

<br/>

## ⚡ Démarrer maintenant

### 1️⃣ Cloner le projet

```bash
git clone https://github.com/mohameden19961/flutter-cours-complet-fr.git
cd flutter-cours-complet-fr
```

---

### 2️⃣ Ouvrir workspace/ dans VS Code

> ⚠️ **TRÈS IMPORTANT** : Il faut ouvrir **uniquement le dossier `workspace/`**
> et **jamais** le dossier principal `flutter-cours-complet-fr/`

```bash
# ✅ CORRECT — ouvre uniquement le projet Flutter
code flutter-cours-complet-fr/workspace
```

```
# OU depuis VS Code :
File → Open Folder → choisir le dossier workspace/
```

> ❌ **Ne pas faire** : `code flutter-cours-complet-fr` → erreurs partout
> ✅ **Toujours** : `code flutter-cours-complet-fr/workspace` → zéro erreur

---

### 3️⃣ Installer les packages

```bash
# Dans workspace/
cd flutter-cours-complet-fr/workspace
flutter pub get
```

---

### 4️⃣ Lancer le workspace

```bash
flutter run                  # Sur émulateur Android
flutter run -d chrome        # Dans le navigateur ← recommandé pour débuter
flutter run -d linux         # Linux Desktop
flutter run -d macos         # macOS
flutter run -d windows       # Windows
```

✅ Tu dois voir l'**écran d'accueil du workspace** — tout fonctionne !

---

### 5️⃣ Utiliser les leçons

Les leçons sont dans `cours/` en format **`.txt`** — elles s'ouvrent sans aucune erreur.

```
1. Ouvre un fichier leçon depuis cours/
   ex: cours/Chapitre_03_Widgets_Basics/lecon_01_stateless_widget.txt

2. Lis la leçon entièrement

3. Quand tu veux tester le code :
   → Ctrl+A  (tout sélectionner)
   → Ctrl+C  (copier)

4. Ouvre workspace/lib/main.dart
   → Ctrl+A  (tout sélectionner)
   → Ctrl+V  (coller)
   → Ctrl+S  (sauvegarder)

5. L'app se met à jour automatiquement 🔥 (Hot Reload)
```

---

### ✅ Vérification — Tout fonctionne si :

```
✅ VS Code est ouvert sur workspace/ uniquement
✅ Aucune erreur rouge dans workspace/lib/main.dart
✅ flutter pub get exécuté avec succès
✅ flutter run fonctionne
✅ Ctrl+S déclenche le Hot Reload (app se met à jour)
```

---

### ❓ Problèmes courants

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Target of URI doesn't exist: 'package:flutter/material.dart'` | Mauvais dossier ouvert dans VS Code | Ouvrir `workspace/` et non la racine |
| `Undefined class 'Widget'` | Même raison | Même solution |
| `flutter: command not found` | Flutter pas installé | Voir [flutter.dev/install](https://flutter.dev/get-started/install) |
| `flutter pub get` échoue | Pas de connexion internet | Vérifier la connexion |

---

<br/>

## 📚 Contenu du cours

| # | Chapitre | Ce que tu apprends |
|---|----------|--------------------|
| 01 | Introduction | Flutter vs les autres, architecture, pubspec.yaml |
| 02 | Installation | Guide complet Windows / macOS / Linux |
| 03 | Widgets Basics | StatelessWidget, StatefulWidget, cycle de vie |
| 04 | Layouts | Row, Column, Stack, Expanded, GridView, ListView |
| 05 | Navigation | Navigator, routes nommées, BottomNavigationBar |
| 06 | Forms & Inputs | TextFormField, validation, DropdownButton |
| 07 | State Management | setState → ChangeNotifier → Provider |
| 08 | API HTTP | GET, POST, PUT, DELETE, états loading/error |
| 09 | JSON Parsing | fromJson, toJson, modèles imbriqués |
| 10 | Local Storage | SharedPreferences, SQLite, Hive |
| 11 | UI/UX | Thème Material 3, animations, responsive |
| 12 | Performance | const, rebuilds, pagination, debounce |

---

<br/>

## 📱 Les 5 Projets Complets

> Tous dans `cours/projets/` en `.txt` — à reproduire de zéro dans `workspace/`

### 🔵 To-Do App
```
✅ CRUD + Priorités + Filtres + Animations + Swipe to delete
```

### 🟡 Notes App
```
✅ Style Google Keep + Couleurs + Épingles + Éditeur plein écran
```

### 🌤️ Weather App
```
✅ API météo + Fond dynamique + Prévisions 7 jours + SliverAppBar
```

### 🛒 E-commerce UI
```
✅ Catalogue + Panier + Favoris + Badges + Material 3 premium
```

### 💬 Chat App
```
✅ Style WhatsApp + Bulles animées + Typing indicator + Statuts
```

---

<br/>

## 🤖 Utiliser l'IA avec ce Cours

### ✅ Bons usages

```
"Explique-moi le widget AnimatedContainer avec un exemple simple"

"J'ai cette erreur dans mon code Flutter : [coller l'erreur]
Qu'est-ce qui ne va pas ?"

"Mon layout dépasse l'écran (RenderFlex overflowed).
Voici mon code : [coller] Comment corriger ?"

"Quel widget Flutter utiliser pour une liste horizontale
avec des cartes scrollables ?"
```

### ❌ À éviter

```
❌ "Code la leçon pour moi"
❌ Copier sans comprendre
❌ Sauter les exercices
```

### 🧠 Prompts spéciaux Flutter

```bash
# Déboguer un layout
"Mon layout ne ressemble pas à ce que je veux.
Voici mon code [coller] et voici ce que j'attends [description].
Qu'est-ce qui ne va pas ?"

# Comprendre les rebuilds
"Mon widget se rebuild trop souvent.
Comment savoir lequel et comment l'optimiser ?"

# State management
"J'ai besoin de partager des données entre 2 écrans.
Quelle solution recommandes-tu : setState, ChangeNotifier ou Provider ?"
```

---

<br/>

## 📏 Méthode d'Apprentissage

### 🟢 Ce qu'il FAUT faire

```
✅ Lire la leçon .txt entièrement avant de coder
✅ Taper le code à la main dans workspace/ (jamais copier-coller les exercices)
✅ Faire TOUS les exercices avant de voir les solutions
✅ Lancer l'app à chaque modification (Hot Reload)
✅ Reproduire chaque projet de ZÉRO après l'avoir étudié
✅ Coder 1h / jour minimum
```

### 🔴 Ce qu'il NE FAUT PAS faire

```
❌ Juste lire sans coder
❌ Passer au chapitre suivant si le précédent n'est pas clair
❌ Regarder les solutions sans avoir essayé 20 minutes
❌ Commencer ce cours sans avoir fait le cours Dart
❌ Ouvrir le dossier racine dans VS Code (erreurs partout)
```

### 🔄 Méthode pour chaque chapitre

```
① Lire la leçon .txt complète            (10 min)
② Copier dans workspace/lib/main.dart    (15 min)
③ Modifier, expérimenter, casser         (15 min)
④ Faire les exercices seul               (20 min)
⑤ Comparer avec la solution              (10 min)
⑥ Mini-projet du chapitre                (45 min)
```

---

<br/>

## ⏱ Durée Estimée

```
⏱ Durée totale : 6 à 10 semaines
📅 Rythme idéal : 1h / jour, 5 jours / semaine
```

| Semaine | Chapitres | Focus |
|---------|-----------|-------|
| 1 | 01 + 02 | Comprendre Flutter + Installation |
| 2 | 03 + 04 | Widgets + Layouts |
| 3 | 05 + 06 | Navigation + Formulaires |
| 4 | 07 + 08 + 09 | State + API + JSON |
| 5 | 10 + 11 | Storage + UI/UX |
| 6 | 12 + Projets 1 & 2 | Performance + To-Do + Notes |
| 7-8 | Projets 3, 4, 5 | Weather + E-commerce + Chat |

---

<br/>

## 🚀 Après ce Cours

```
           ✅ CE COURS FLUTTER TERMINÉ
                      │
         ┌────────────┼────────────┐
         ▼            ▼            ▼
    🔥 FIREBASE    📐 RIVERPOD   🏗️ CLEAN ARCH
    Auth, Firestore  State avancé  Repository
    Storage, Cloud   Providers     TDD Flutter
         │            │            │
         └────────────┼────────────┘
                      ▼
              💼 EMPLOI / FREELANCE
```

| Rôle | Salaire moyen |
|------|---------------|
| Dev Flutter Junior | 35-45k€ |
| Dev Flutter Mid | 50-65k€ |
| Dev Flutter Senior | 70-90k€ |
| Freelance Flutter | 400-700€/jour |

### 🛤️ Prochaines technologies à apprendre

```dart
final parcoursSuite = [
  'Firebase (Auth + Firestore)',      // 2-3 semaines
  'Riverpod (State Management)',      // 1-2 semaines
  'GoRouter (Navigation avancée)',    // 3-5 jours
  'Clean Architecture Flutter',       // 2-3 semaines
  'Flutter Testing (unit + widget)',  // 1-2 semaines
  'CI/CD + Déploiement App Store',    // 1 semaine
];
```

---

<br/>

## 💡 Section Motivation

> **Apprendre Flutter est inconfortable. Et c'est exactement ça qui te fait progresser.**

```
Semaine 1  : "C'est fun !"
Semaine 2  : "Les layouts sont compliqués..."
Semaine 3  : "Je comprends rien au State"  ← LE CREUX NORMAL
Semaine 4  : "Ah, ça commence à cliquer !"
Semaine 5  : "Je construis de vraies apps !"
Semaine 6+ : "Je me sens développeur Flutter"
```

Chaque développeur Flutter que tu admires est passé par exactement les mêmes blocages. La différence ? **Ils ont continué.**

### 🎯 Ton Engagement

```
┌─────────────────────────────────────────────┐
│                                             │
│  Je m'engage à :                            │
│                                             │
│  ✊ Coder 1h minimum par jour              │
│  ✊ Finir chaque chapitre avant d'avancer  │
│  ✊ Construire les 5 projets               │
│  ✊ Continuer même quand c'est difficile   │
│  ✊ Partager ce cours si il m'aide         │
│                                             │
│  Signé : ___________________               │
│  Date  : ___________________               │
│                                             │
└─────────────────────────────────────────────┘
```

---

<br/>

## 🤝 Licence

**MIT** — Utilise, partage et modifie librement.

---

<div align="center">

<br/>

**Cours Flutter Complet · Du Dart à l'Expert · Entièrement en Français**

*Créé avec ❤️ pour la communauté francophone*

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)

</div>