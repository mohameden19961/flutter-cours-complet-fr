# 🚀 Workspace — Cours Flutter Complet

Ce dossier est ton **espace de travail Flutter prêt à l'emploi**.
Pas d'erreurs, pas de configuration — tu codes directement.

---

## ▶️ Démarrer en 3 étapes

### Étape 1 — Installer les packages
```bash
cd workspace
flutter pub get
```

### Étape 2 — Lancer l'application
```bash
flutter run                 # Sur émulateur Android
flutter run -d chrome       # Dans le navigateur
flutter run -d linux        # Sur Linux Desktop
flutter run -d macos        # Sur macOS
flutter run -d windows      # Sur Windows
```

### Étape 3 — Copier une leçon dans lib/main.dart

```
1. Ouvre cours/Chapitre_XX.../lecon_XX.dart
2. Ctrl+A → Ctrl+C  (tout copier)
3. Ouvre workspace/lib/main.dart
4. Ctrl+A → Ctrl+V  (tout remplacer)
5. Ctrl+S           (sauvegarder → Hot Reload 🔥)
```

---

## 📁 Structure du workspace

```
workspace/
├── lib/
│   ├── main.dart          ← COLLE TES LEÇONS ICI
│   ├── screens/           ← Tes écrans (quand tu construis tes propres apps)
│   ├── widgets/           ← Tes widgets réutilisables
│   ├── models/            ← Tes classes de données
│   └── services/          ← Tes services API
├── assets/
│   ├── images/            ← Tes images locales
│   └── fonts/             ← Tes polices personnalisées
├── pubspec.yaml           ← Packages déjà configurés
└── analysis_options.yaml  ← Règles de qualité
```

---

## 📦 Packages déjà inclus

| Package | Version | Usage |
|---------|---------|-------|
| `http` | ^1.1.0 | Chapitre 08 — API REST |
| `shared_preferences` | ^2.2.2 | Chapitre 10 — Stockage |
| `provider` | ^6.1.1 | Chapitre 07 — State Management |

---

## ✅ Vérifier que tout fonctionne

```bash
flutter doctor        # Vérifier l'installation Flutter
flutter pub get       # Télécharger les packages
flutter run           # Lancer → tu dois voir l'écran d'accueil
```
