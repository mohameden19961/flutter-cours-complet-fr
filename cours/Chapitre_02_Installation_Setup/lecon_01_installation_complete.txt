// ============================================================
// 📘 CHAPITRE 02 — GUIDE D'INSTALLATION COMPLET
// Installation Flutter SDK + Android Studio + VS Code
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS DE CE GUIDE                                  ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Installer Flutter SDK sur Windows/macOS/Linux          ║
║   ✅ Configurer les variables d'environnement               ║
║   ✅ Installer Android Studio et créer un émulateur         ║
║   ✅ Configurer VS Code pour Flutter                        ║
║   ✅ Créer et lancer ta première app Flutter                ║
║   ✅ Résoudre les erreurs courantes d'installation          ║
╚══════════════════════════════════════════════════════════════╝

⚠️  IMPORTANT : Ce fichier est un GUIDE D'INSTALLATION.
    Lis-le étape par étape et exécute chaque commande
    dans ton terminal (et non dans Dart).
*/

// ============================================================
// 🖥️ PARTIE 1 : INSTALLATION SUR WINDOWS
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ÉTAPE 1 — Prérequis Windows
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  → Windows 10 ou supérieur (64-bit)
  → 10 Go d'espace disque libre
  → Git installé (https://git-scm.com)
  → PowerShell 5.0+ ou Windows Terminal

ÉTAPE 2 — Télécharger Flutter SDK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. Va sur : https://docs.flutter.dev/get-started/install/windows
  2. Télécharge le fichier .zip (ex: flutter_windows_3.x.x-stable.zip)
  3. Extrais dans C:\flutter (pas dans C:\Program Files — pas d'espaces !)
  
  Résultat : C:\flutter\bin\flutter.exe

ÉTAPE 3 — Configurer les Variables d'Environnement
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. Panneau de config → Système → Variables d'environnement
  2. Dans "Variables système" → "Path" → "Modifier"
  3. Ajouter : C:\flutter\bin
  4. OK → OK → OK
  5. Fermer et rouvrir le terminal

  OU avec PowerShell (administrateur) :
  $env:Path += ";C:\flutter\bin"
  [System.Environment]::SetEnvironmentVariable("Path",
    $env:Path, [System.EnvironmentVariableTarget]::Machine)

ÉTAPE 4 — Vérifier l'installation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Dans un nouveau terminal :
  flutter --version
  
  Résultat attendu :
  Flutter 3.x.x • channel stable
  Framework • revision xxxxx
  Dart 3.x.x
*/

// ============================================================
// 🍎 PARTIE 2 : INSTALLATION SUR macOS
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MÉTHODE 1 — Avec Homebrew (RECOMMANDÉ)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Installer Homebrew si pas encore installé :
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installer Flutter :
brew install --cask flutter

# Vérifier :
flutter --version

MÉTHODE 2 — Téléchargement manuel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 1. Télécharger depuis flutter.dev
# 2. Extraire dans ~/development/flutter

# 3. Ajouter au PATH (dans ~/.zshrc ou ~/.bash_profile) :
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Vérifier :
flutter --version

ÉTAPE SUPPLÉMENTAIRE macOS — Pour iOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Installer Xcode depuis l'App Store

# Accepter la licence Xcode :
sudo xcodebuild -license accept

# Installer les outils supplémentaires :
sudo xcode-select --install

# Installer CocoaPods (gestionnaire de dépendances iOS) :
sudo gem install cocoapods
*/

// ============================================================
// 🐧 PARTIE 3 : INSTALLATION SUR LINUX
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
UBUNTU / DEBIAN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Méthode 1 — Avec snap (la plus simple) :
sudo snap install flutter --classic
flutter --version

# Méthode 2 — Manuelle :
# Télécharger le .tar.xz depuis flutter.dev
cd ~
tar xf ~/Downloads/flutter_linux_x.x.x-stable.tar.xz
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
source ~/.bashrc

# Dépendances nécessaires :
sudo apt-get update
sudo apt-get install -y curl git wget unzip libglu1-mesa
*/

// ============================================================
// 📱 PARTIE 4 : INSTALLER ANDROID STUDIO + ÉMULATEUR
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ÉTAPE 1 — Télécharger Android Studio
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  https://developer.android.com/studio

ÉTAPE 2 — Installer Android Studio
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Windows : Double-cliquer l'installeur .exe
  macOS   : Glisser dans Applications
  Linux   : Extraire et lancer studio.sh

ÉTAPE 3 — Configuration d'Android Studio
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. Lancer Android Studio
  2. "More Actions" → "SDK Manager"
  3. Dans SDK Platforms → cocher "Android 14.0 (API 34)" minimum
  4. Dans SDK Tools → cocher :
      ✅ Android SDK Build-Tools
      ✅ Android SDK Command-line Tools
      ✅ Android Emulator
      ✅ Android SDK Platform-Tools
  5. Cliquer "Apply" → "OK"

ÉTAPE 4 — Créer un Émulateur Android
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. "More Actions" → "Virtual Device Manager"
  2. "+ Create Device"
  3. Choisir : Pixel 7 Pro (ou équivalent récent)
  4. System Image : API 34 (Tiramisu ou plus récent)
  5. "Finish"
  6. Appuyer sur ▶ pour lancer l'émulateur

ÉTAPE 5 — Accepter les licences Android
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Dans le terminal :
  flutter doctor --android-licenses
  
  Répondre "y" (oui) à toutes les questions

ÉTAPE 6 — Variable d'environnement Android SDK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Windows : Ajouter ANDROID_HOME dans variables système
    Valeur : C:\Users\[toi]\AppData\Local\Android\Sdk

  macOS/Linux : Ajouter dans ~/.zshrc ou ~/.bashrc :
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/platform-tools
*/

// ============================================================
// 💻 PARTIE 5 : CONFIGURER VS CODE POUR FLUTTER
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ÉTAPE 1 — Installer VS Code
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  https://code.visualstudio.com

ÉTAPE 2 — Installer les Extensions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Ouvrir VS Code → Ctrl+Shift+X

  Extensions OBLIGATOIRES :
  ┌──────────────────────────────────────────────────────┐
  │ Flutter (par Dart Code) — ID: dart-code.flutter      │
  │ Dart (par Dart Code)    — ID: dart-code.dart-code    │
  └──────────────────────────────────────────────────────┘

  Extensions RECOMMANDÉES :
  ┌──────────────────────────────────────────────────────┐
  │ Error Lens          → Erreurs inline dans le code    │
  │ Bracket Pair Color  → Coloration des parenthèses     │
  │ Flutter Snippets    → Raccourcis de code             │
  │ Pubspec Assist      → Aide pour pubspec.yaml         │
  │ GitLens             → Historique Git avancé          │
  └──────────────────────────────────────────────────────┘

ÉTAPE 3 — Paramètres VS Code recommandés
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Ctrl+Shift+P → "Open User Settings (JSON)"
  
  Ajouter ces paramètres :
  {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "Dart-Code.dart-code",
    "dart.flutterSdkPath": "/chemin/vers/flutter",
    "dart.lineLength": 80,
    "[dart]": {
      "editor.rulers": [80],
      "editor.tabSize": 2
    }
  }

RACCOURCIS VS CODE FLUTTER INDISPENSABLES :
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Ctrl+S                → Sauvegarder (déclenche Hot Reload)
  Ctrl+Shift+P → Flutter: Run → Lancer l'app
  F5                    → Démarrer en mode debug
  Ctrl+.                → Suggestions rapides (Quick Fix)
  Alt+Shift+F           → Formater le fichier
  Ctrl+Shift+R          → Rename refactor
*/

// ============================================================
// 🚀 PARTIE 6 : CRÉER ET LANCER TA PREMIÈRE APP
// ============================================================

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ÉTAPE 1 — Vérifier que tout est OK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Dans le terminal :
  flutter doctor
  
  Résultat idéal (tous les ✓ verts) :
  ✓ Flutter (Channel stable, 3.x.x)
  ✓ Android toolchain
  ✓ Chrome - develop for the web
  ✓ VS Code (version x.x)
  ✓ Connected device (émulateur)

ÉTAPE 2 — Créer le projet
━━━━━━━━━━━━━━━━━━━━━━━━━━
  # Dans le dossier où tu veux créer l'app :
  flutter create ma_premiere_app
  cd ma_premiere_app

ÉTAPE 3 — Lancer l'émulateur
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  flutter emulators --launch Pixel_7_Pro_API_34
  # OU ouvrir l'émulateur depuis Android Studio

ÉTAPE 4 — Lancer l'application
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  flutter run
  # OU dans VS Code : F5

  Tu devrais voir le compteur Flutter par défaut !

ÉTAPE 5 — Tester le Hot Reload
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  1. Ouvre lib/main.dart
  2. Trouve : 'You have pushed the button this many times:'
  3. Change en : 'Tu as appuyé le bouton :'
  4. Sauvegarde (Ctrl+S)
  
  → Le changement apparaît IMMÉDIATEMENT sur l'émulateur ! 🔥
  C'est ça, le Hot Reload !
*/

// ============================================================
// 🚨 PARTIE 7 : ERREURS COURANTES ET SOLUTIONS
// ============================================================

/*
ERREUR 1 : "flutter: command not found"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Flutter n'est pas dans le PATH
  SOLUTION: Vérifier et ajouter flutter/bin au PATH
  
  Test : which flutter (macOS/Linux) | where flutter (Windows)

ERREUR 2 : "Android SDK not found"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Android Studio non installé ou SDK non configuré
  SOLUTION:
    1. Installer Android Studio
    2. flutter config --android-sdk /chemin/vers/sdk
    3. flutter doctor --android-licenses

ERREUR 3 : "No devices connected"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Aucun émulateur lancé ou appareil branché
  SOLUTION:
    flutter emulators          # Voir les émulateurs disponibles
    flutter emulators --launch [nom]  # Lancer un émulateur
    flutter run -d chrome      # OU lancer dans le navigateur

ERREUR 4 : "Gradle task assembleDebug failed"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Problème de build Android
  SOLUTION:
    flutter clean
    flutter pub get
    flutter run

ERREUR 5 : "Null safety" ou "Sound null safety"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Package ancien non compatible null safety
  SOLUTION: Mettre à jour le package dans pubspec.yaml
    flutter pub upgrade

ERREUR 6 : "Exception in thread 'main'" (macOS)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : Java non installé
  SOLUTION: brew install --cask temurin

ERREUR 7 : "CocoaPods not installed" (iOS/macOS)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CAUSE   : CocoaPods manquant
  SOLUTION: sudo gem install cocoapods

CONSEIL GÉNÉRAL : Toujours commencer par :
  flutter clean && flutter pub get && flutter run
*/

// ============================================================
// ✅ RÉSUMÉ
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║  ✅ CE QUE TU AS FAIT                                        ║
╠══════════════════════════════════════════════════════════════╣
║  ✅ Installé Flutter SDK                                     ║
║  ✅ Configuré les variables d'environnement                  ║
║  ✅ Installé Android Studio + créé un émulateur             ║
║  ✅ Configuré VS Code avec les bonnes extensions             ║
║  ✅ Créé et lancé ta première app Flutter                    ║
║  ✅ Testé le Hot Reload                                      ║
║  ✅ Connu les erreurs courantes et leurs solutions           ║
╚══════════════════════════════════════════════════════════════╝

🎉 FÉLICITATIONS ! Ton environnement Flutter est prêt !
   Direction : Chapitre 03 → Les Widgets !
*/

void main() {
  print('╔══════════════════════════════════════════════════════╗');
  print('║  GUIDE D\'INSTALLATION FLUTTER                        ║');
  print('╚══════════════════════════════════════════════════════╝');
  print('');
  print('Checklist d\'installation :');
  print('  [ ] Flutter SDK installé');
  print('  [ ] PATH configuré (flutter --version ✓)');
  print('  [ ] Android Studio installé');
  print('  [ ] SDK Android téléchargé');
  print('  [ ] Licences Android acceptées');
  print('  [ ] Émulateur créé et fonctionnel');
  print('  [ ] VS Code + extensions Dart/Flutter');
  print('  [ ] flutter doctor → tous verts ✓');
  print('  [ ] Première app lancée !');
  print('');
  print('Commande de vérification : flutter doctor');
}
