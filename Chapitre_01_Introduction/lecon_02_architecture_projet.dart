// ============================================================
// 📘 CHAPITRE 01 — LEÇON 2
// Architecture Flutter & Structure d'un Projet
// Niveau : Débutant Flutter
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS DE CETTE LEÇON                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre la structure d'un projet Flutter            ║
║   ✅ Connaître le rôle de chaque dossier/fichier            ║
║   ✅ Comprendre pubspec.yaml                                 ║
║   ✅ Lire et comprendre main.dart                           ║
║   ✅ Savoir ajouter des packages (dépendances)              ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : STRUCTURE D'UN PROJET FLUTTER
// ============================================================

/*
Quand tu crées un nouveau projet Flutter avec :
  flutter create mon_application

Tu obtiens cette structure :

mon_application/
│
├── 📄 pubspec.yaml          ← ⭐ FICHIER CLÉ (config + dépendances)
├── 📄 pubspec.lock          ← Versions exactes des packages (auto)
├── 📄 README.md             ← Documentation du projet
├── 📄 analysis_options.yaml ← Règles de qualité du code
│
├── 📁 lib/                  ← ⭐ TON CODE EST ICI
│   └── 📄 main.dart         ← Point d'entrée de l'application
│
├── 📁 test/                 ← Tests automatisés
│   └── 📄 widget_test.dart
│
├── 📁 android/              ← Code natif Android (rarement modifié)
├── 📁 ios/                  ← Code natif iOS (rarement modifié)
├── 📁 web/                  ← Fichiers web (index.html...)
├── 📁 linux/                ← Support Linux Desktop
├── 📁 macos/                ← Support macOS
├── 📁 windows/              ← Support Windows Desktop
│
└── 📁 assets/               ← Images, fonts, fichiers locaux
    ├── images/
    └── fonts/

RÈGLE D'OR : 95% de ton travail se passe dans lib/ !
*/

// ============================================================
// 📖 PARTIE 2 : LE FICHIER pubspec.yaml
// ============================================================

/*
pubspec.yaml est le CŒUR de ton projet Flutter.
C'est comme la "carte d'identité" de ton application.

Voici un exemple commenté :

─────────────────────────────────────────────────────────────
name: mon_application          # Nom du projet (snake_case)
description: Mon app Flutter   # Description courte
version: 1.0.0+1               # Version: majeure.mineure.patch+build

environment:
  sdk: '>=3.0.0 <4.0.0'        # Version de Dart requise

dependencies:                  # PACKAGES dont ton app a BESOIN
  flutter:
    sdk: flutter               # Le SDK Flutter (toujours présent)
  
  # Packages populaires (exemples) :
  http: ^1.1.0                 # Pour faire des requêtes HTTP
  shared_preferences: ^2.2.0   # Pour stocker des données localement
  provider: ^6.1.1             # Pour la gestion d'état
  cached_network_image: ^3.3.0 # Pour les images depuis internet

dev_dependencies:              # Packages pour le DÉVELOPPEMENT seulement
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0        # Règles de qualité de code

flutter:                       # Configuration Flutter spécifique
  uses-material-design: true   # Active Material Design
  
  assets:                      # Déclarer les fichiers locaux
    - assets/images/
    - assets/images/logo.png
  
  fonts:                       # Polices personnalisées
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
─────────────────────────────────────────────────────────────

📌 APRÈS AVOIR MODIFIÉ pubspec.yaml :
   Lance toujours : flutter pub get
   (Télécharge les nouveaux packages)
*/

// ============================================================
// 📖 PARTIE 3 : ANALYSER main.dart EN DÉTAIL
// ============================================================

/*
Voici main.dart décortiqué ligne par ligne :
*/

// ─── Exemple de main.dart typique ────────────────────────────

/*
// ① Import du package Material Design de Flutter
//   Material = le système de design de Google (boutons, couleurs, etc.)
import 'package:flutter/material.dart';

// ② Le point d'entrée — comme en Dart pur
//   void main() → runApp() démarre tout
void main() {
  // WidgetsFlutterBinding initialise Flutter avant l'app
  WidgetsFlutterBinding.ensureInitialized();
  
  // runApp() prend le widget RACINE et l'affiche
  runApp(const MyApp());
}

// ③ MyApp = le widget RACINE de toute l'application
//   Il est StatelessWidget car la config de l'app ne change pas
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // {super.key} → bonne pratique Flutter

  // ④ build() = la méthode obligatoire qui DÉCRIT l'UI
  //   Elle est appelée à chaque fois que le widget doit se redessiner
  @override
  Widget build(BuildContext context) {
    
    // ⑤ MaterialApp = le conteneur de toute l'application
    //   Il configure : thème, langue, routes de navigation...
    return MaterialApp(
      
      // Titre de l'app (visible dans le gestionnaire de tâches)
      title: 'Mon Application',
      
      // Cache le bandeau rouge "DEBUG" en haut à droite
      debugShowCheckedModeBanner: false,
      
      // ⑥ ThemeData = le style global de l'application
      theme: ThemeData(
        // Génère une palette de couleurs à partir d'une couleur de base
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light, // Thème clair
        ),
        
        // Active les animations Material 3 (plus modernes)
        useMaterial3: true,
        
        // Police par défaut de toute l'app
        fontFamily: 'Poppins',
      ),
      
      // ⑦ Thème sombre (optionnel mais recommandé)
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Thème sombre
        ),
        useMaterial3: true,
      ),
      
      // Suivre la préférence système (clair/sombre)
      themeMode: ThemeMode.system,
      
      // ⑧ L'écran affiché en premier (page d'accueil)
      home: const HomePage(),
    );
  }
}

// ⑨ Le premier écran de l'application
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        // backgroundColor utilise la couleur du thème automatiquement
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Hello Flutter ! 👋'),
      ),
    );
  }
}
*/

// ============================================================
// 📖 PARTIE 4 : ORGANISATION PROFESSIONNELLE DE lib/
// ============================================================

/*
Pour un projet sérieux, lib/ doit être bien organisé.
Voici la structure recommandée (architecture feature-first) :

lib/
│
├── main.dart                    ← Point d'entrée
│
├── app/
│   ├── app.dart                 ← Configuration MaterialApp
│   └── routes.dart              ← Toutes les routes de navigation
│
├── features/                    ← Fonctionnalités de l'app
│   ├── auth/                    ← Authentification
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── widgets/
│   │   └── controllers/
│   │
│   ├── home/                    ← Écran principal
│   │   ├── screens/
│   │   └── widgets/
│   │
│   └── profile/                 ← Profil utilisateur
│       ├── screens/
│       └── widgets/
│
├── shared/                      ← Éléments partagés
│   ├── widgets/                 ← Widgets réutilisables
│   │   ├── custom_button.dart
│   │   └── loading_spinner.dart
│   ├── theme/                   ← Couleurs, polices
│   │   └── app_theme.dart
│   └── utils/                   ← Fonctions utilitaires
│       └── validators.dart
│
└── data/                        ← Données (API, BDD locale)
    ├── models/                  ← Classes de données
    ├── repositories/            ← Sources de données
    └── services/                ← Services API

⚠️ POUR LES DÉBUTANTS : commence simplement !
   lib/
   ├── main.dart
   ├── screens/      ← Tes écrans
   ├── widgets/      ← Tes widgets réutilisables
   └── models/       ← Tes classes de données
*/

// ============================================================
// 📖 PARTIE 5 : COMMANDES FLUTTER ESSENTIELLES
// ============================================================

/*
Dans ton terminal, ces commandes sont indispensables :

CRÉER UN PROJET
───────────────
flutter create nom_projet                    # Créer un nouveau projet
flutter create --org com.tonnom projet       # Avec organisation
flutter create -t app --platforms=android,ios,web projet  # Plateformes spécifiques

EXÉCUTER L'APPLICATION
───────────────────────
flutter run                    # Lancer l'app (choisit un device)
flutter run -d chrome          # Lancer dans Chrome (Web)
flutter run -d emulator-5554   # Lancer sur un émulateur spécifique
flutter run --release          # Mode release (optimisé)

PACKAGES
─────────
flutter pub get                # Télécharger les packages déclarés
flutter pub add http           # Ajouter un package
flutter pub remove http        # Retirer un package
flutter pub upgrade            # Mettre à jour les packages

BUILD
──────
flutter build apk              # Générer un APK Android
flutter build appbundle        # Générer un AAB (Google Play)
flutter build ios              # Construire pour iOS (Mac requis)
flutter build web              # Construire pour le Web

DIAGNOSTICS
────────────
flutter doctor                 # Vérifier l'installation
flutter devices                # Lister les appareils connectés
flutter emulators              # Lister les émulateurs disponibles
flutter clean                  # Nettoyer le cache de build
flutter analyze                # Analyser le code (erreurs)
flutter test                   # Lancer les tests
*/

// ============================================================
// ✅ RÉSUMÉ
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║  ✅ CE QUE TU AS APPRIS                                      ║
╠══════════════════════════════════════════════════════════════╣
║  • lib/ = tout ton code Flutter                             ║
║  • pubspec.yaml = config + dépendances                      ║
║  • main.dart → main() → runApp() → MaterialApp             ║
║  • MaterialApp configure le thème, les routes, l'accueil   ║
║  • Scaffold = la structure d'un écran (appBar + body)       ║
║  • flutter pub get = télécharger les packages               ║
║  • flutter run = lancer l'application                       ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 🏋️ EXERCICES
// ============================================================

/*
🟢 FACILE :
  Explique le rôle de ces fichiers dans un projet Flutter :
  a) pubspec.yaml
  b) main.dart
  c) Le dossier lib/

🟡 MOYEN :
  Dessine (sur papier ou en ASCII) la structure de dossiers
  que tu utiliserais pour une app de to-do list avec :
  - Un écran liste des tâches
  - Un écran ajout de tâche
  - Des modèles de données
  - Des widgets réutilisables

🔴 DIFFICILE :
  Dans pubspec.yaml, que signifie "^1.1.0" pour un package ?
  Quelle est la différence entre "dependencies" et
  "dev_dependencies" ? Pourquoi cette séparation existe-t-elle ?

══════════════════════════════════════════════════
SOLUTIONS
══════════════════════════════════════════════════

🟢 SOLUTION :
  a) pubspec.yaml → configuration du projet : nom, version, 
     packages nécessaires, assets (images, polices)
  b) main.dart → point d'entrée de l'app, contient main() 
     et le widget racine MaterialApp
  c) lib/ → tout le code source Dart de l'application

🟡 SOLUTION :
  lib/
  ├── main.dart
  ├── screens/
  │   ├── todo_list_screen.dart
  │   └── add_todo_screen.dart
  ├── widgets/
  │   ├── todo_item_card.dart
  │   └── custom_text_field.dart
  └── models/
      └── todo.dart

🔴 SOLUTION :
  "^1.1.0" signifie "version >=1.1.0 ET <2.0.0"
  Le ^ autorise les mises à jour mineure (1.1.0 → 1.5.0)
  mais pas les majeures (pas 2.0.0).
  
  dependencies → packages nécessaires en PRODUCTION
  dev_dependencies → packages utiles seulement au 
  DÉVELOPPEMENT (tests, linting) → ne sont pas inclus
  dans l'app finale, ce qui réduit sa taille.
*/

void main() {
  print('╔══════════════════════════════════════════════════╗');
  print('║  LEÇON 2 : ARCHITECTURE & STRUCTURE D\'UN PROJET  ║');
  print('╚══════════════════════════════════════════════════╝');
  print('');
  print('Structure clé d\'un projet Flutter :');
  print('  lib/         → Ton code (95% du travail ici)');
  print('  pubspec.yaml → Configuration + Packages');
  print('  main.dart    → Point d\'entrée');
  print('  assets/      → Images, polices, fichiers');
  print('');
  print('Commandes essentielles :');
  print('  flutter create → Créer un projet');
  print('  flutter run    → Lancer l\'app');
  print('  flutter pub get → Installer les packages');
  print('  flutter build  → Compiler pour production');
}
