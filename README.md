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
├── 📁 cours/                        ← 📖 LES LEÇONS (lecture + référence)
│   ├── Chapitre_01_Introduction/
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
│   ├── projets/                     ← 5 apps complètes
│   └── resources/                   ← Cheat sheet
│
└── 📁 workspace/                    ← ✏️ TON ESPACE DE TRAVAIL (tu codes ici)
    ├── lib/
    │   └── main.dart                ← COLLE LES LEÇONS ICI
    ├── pubspec.yaml                 ← Packages déjà configurés
    └── README.md                    ← Instructions du workspace
```

> **`cours/`** = tu lis les leçons, tu ne modifies rien
> **`workspace/`** = tu colles les leçons ici et tu codes

---

<br/>

## ⚡ Démarrer maintenant

### 1️⃣ Cloner le projet

```bash
git clone https://github.com/mohameden19961/flutter-cours-complet-fr.git
cd flutter-cours-complet-fr
```

### 2️⃣ Ouvrir dans VS Code

```bash
code .
```

Tu verras les deux dossiers `cours/` et `workspace/` dans l'explorateur VS Code.

### 3️⃣ Installer les packages du workspace

```bash
cd workspace
flutter pub get
```

### 4️⃣ Lancer le workspace

```bash
# Toujours dans workspace/
flutter run                  # Sur émulateur Android
flutter run -d chrome        # Dans le navigateur ← recommandé pour débuter
flutter run -d linux         # Linux Desktop
```

✅ Tu dois voir l'**écran d'accueil du workspace** — c'est bon signe !

### 5️⃣ Commencer la première leçon

```
1. Dans VS Code, ouvre :
   cours/Chapitre_01_Introduction/lecon_01_cest_quoi_flutter.dart

2. Lis la leçon

3. Quand tu veux tester le code :
   → Ctrl+A (tout sélectionner)
   → Ctrl+C (copier)

4. Ouvre workspace/lib/main.dart
   → Ctrl+A (tout sélectionner)
   → Ctrl+V (coller)
   → Ctrl+S (sauvegarder)

5. L'app se met à jour automatiquement 🔥 (Hot Reload)
```

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

> Tous dans `cours/projets/` — à reproduire de zéro dans `workspace/`

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

---

<br/>

## 📏 Méthode d'Apprentissage

### 🟢 Ce qu'il FAUT faire

```
✅ Taper le code à la main (jamais copier-coller les exercices)
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
```

### 🔄 Méthode pour chaque chapitre

```
① Lire la leçon complète             (10 min)
② Copier dans workspace et tester    (15 min)
③ Modifier, expérimenter, casser     (15 min)
④ Faire les exercices seul           (20 min)
⑤ Comparer avec la solution          (10 min)
⑥ Mini-projet du chapitre            (45 min)
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
