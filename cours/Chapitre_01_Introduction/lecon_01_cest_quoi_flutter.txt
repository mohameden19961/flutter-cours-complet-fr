// ============================================================
// 📘 CHAPITRE 01 — LEÇON 1
// Qu'est-ce que Flutter ?
// Niveau : Débutant absolu Flutter (connaît Dart)
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS DE CETTE LEÇON                               ║
╠══════════════════════════════════════════════════════════════╣
║   À la fin, tu sauras :                                     ║
║   ✅ Expliquer ce qu'est Flutter avec tes propres mots       ║
║   ✅ Comprendre pourquoi Flutter est révolutionnaire         ║
║   ✅ Distinguer Flutter des autres frameworks mobiles        ║
║   ✅ Connaître les plateformes supportées                    ║
║   ✅ Comprendre la relation Flutter ↔ Dart                   ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : QU'EST-CE QUE FLUTTER ?
// ============================================================

/*
🏗️ DÉFINITION SIMPLE
═════════════════════
Flutter est un FRAMEWORK open-source créé par Google.
Il permet de créer des applications BELLES et RAPIDES
pour PLUSIEURS plateformes avec un SEUL code source.

📖 ANALOGIE DU QUOTIDIEN
══════════════════════════
Imagine que tu veux construire une maison.
Normalement, tu aurais besoin :
  → D'un architecte différent pour chaque pays
  → De matériaux différents selon les régions
  → D'un constructeur spécialisé par style

Flutter, c'est comme avoir :
  → UN seul plan d'architecte universel
  → UNE seule boîte d'outils pour tout construire
  → LE MÊME résultat final sur toutes les plateformes

En programmation :
  SANS Flutter → Un code pour iOS, un autre pour Android,
                 un autre pour Web, un autre pour Desktop...
  AVEC Flutter → UN seul code → iOS + Android + Web + Desktop !
*/

// ============================================================
// 📖 PARTIE 2 : L'HISTOIRE DE FLUTTER
// ============================================================

/*
📅 CHRONOLOGIE
═══════════════
  2015 → Google commence le projet "Sky" (prototype)
  2017 → Annonce officielle de Flutter à Google I/O
  2018 → Flutter 1.0 lancé (version stable)
  2019 → Flutter pour le Web (beta)
  2020 → Flutter 1.17 — support macOS, Windows, Linux
  2021 → Flutter 2.0 — support stable Web + Desktop
  2022 → Flutter 3.0 — support de TOUTES les plateformes
  2023 → Flutter 3.x — améliorations majeures de perf
  2024 → Flutter continue d'évoluer rapidement...

🌍 CHIFFRES CLÉS (2024)
═════════════════════════
  → +1 million d'apps Flutter sur les stores
  → +700 000 développeurs Flutter actifs
  → 3ème framework mobile le plus populaire au monde
  → Utilisé par : Google, BMW, Alibaba, eBay...
*/

// ============================================================
// 📖 PARTIE 3 : FLUTTER VS LES AUTRES
// ============================================================

/*
COMPARAISON DES APPROCHES DE DÉVELOPPEMENT MOBILE

┌─────────────────┬──────────────┬────────────┬────────────┐
│ Critère         │ Flutter      │ React Native│ Swift/Kotlin│
├─────────────────┼──────────────┼────────────┼────────────┤
│ Langage         │ Dart         │ JavaScript │ Swift/Kotlin│
│ Performance     │ 🔥 Excellent  │ ⚡ Bon      │ ✅ Natif   │
│ Code partagé    │ 100%         │ ~85%       │ 0%         │
│ Plateformes     │ 6            │ 2          │ 1-2        │
│ UI Personnalisée│ Totale       │ Limitée    │ Totale     │
│ Courbe apprent. │ Modérée      │ Modérée    │ Raide      │
│ Communauté      │ Grande       │ Très grande│ Grande     │
└─────────────────┴──────────────┴────────────┴────────────┘

🏆 AVANTAGES DE FLUTTER
════════════════════════

1. ⚡ HAUTE PERFORMANCE
   → Compilé en code natif ARM (pas de pont JavaScript)
   → 60 fps (ou 120 fps sur appareils compatibles)
   → Rendu propre sur TOUS les appareils

2. 🎨 CONTRÔLE TOTAL DE L'UI
   → Flutter dessine TOUS ses widgets lui-même
   → Pixel perfect sur toutes les plateformes
   → Animations fluides incluses

3. 📱 MULTI-PLATEFORME RÉEL
   → iOS, Android, Web, macOS, Windows, Linux
   → UN seul code pour tout

4. 🔥 HOT RELOAD
   → Voir les changements de code EN TEMPS RÉEL
   → Sans redémarrer l'application
   → Productivité ×3

5. 📦 RICHE ÉCOSYSTÈME
   → 30 000+ packages sur pub.dev
   → Communauté active et grandissante

⚠️ LIMITES DE FLUTTER
══════════════════════
→ Taille d'application légèrement plus grande (~5MB de plus)
→ Moins d'accès direct aux APIs natives
→ Dart moins connu que JavaScript
→ Certaines fonctionnalités très spécifiques demandent du code natif
*/

// ============================================================
// 📖 PARTIE 4 : COMMENT FONCTIONNE FLUTTER ?
// ============================================================

/*
🏗️ ARCHITECTURE DE FLUTTER
════════════════════════════

    ┌─────────────────────────────────────┐
    │         TON APPLICATION DART        │  ← Tu codes ici
    ├─────────────────────────────────────┤
    │         FRAMEWORK FLUTTER           │  ← Widgets, Animations...
    ├─────────────────────────────────────┤
    │            MOTEUR FLUTTER           │  ← Skia/Impeller (C++)
    ├─────────────────────────────────────┤
    │  iOS  │ Android │  Web  │ Desktop   │  ← Plateformes
    └───────┴─────────┴───────┴───────────┘

EXPLICATION :
  1. Tu écris ton code en Dart
  2. Flutter Framework fournit les Widgets
  3. Le moteur Flutter (en C++) dessine les pixels
  4. Résultat identique sur toutes les plateformes !

💡 LA CLÉ : Flutter ne traduit pas en composants natifs.
   Il DESSINE lui-même chaque pixel sur un "canvas" !
   C'est pourquoi il est si performant et cohérent.

🖼️ LE CONCEPT DE WIDGETS
═════════════════════════
En Flutter, TOUT est un Widget.
Un widget, c'est comme une pièce de LEGO :
  → Chaque pièce a une forme et une couleur
  → On assemble les pièces pour construire quelque chose
  → On peut imbriquer les pièces à l'infini

Exemples de widgets :
  Text("Bonjour")          → Affiche du texte
  Image(...)               → Affiche une image
  Button(...)              → Un bouton cliquable
  Column([...])            → Arrange verticalement
  Row([...])               → Arrange horizontalement
  Scaffold(...)            → La structure d'une page
*/

// ============================================================
// 📖 PARTIE 5 : LA RELATION FLUTTER ↔ DART
// ============================================================

/*
🔗 DART EST LE LANGAGE, FLUTTER EST LE FRAMEWORK
═══════════════════════════════════════════════════

C'est comme :
  → JavaScript est au langage ce que React est au framework
  → Python est au langage ce que Django est au framework
  → Dart est au langage ce que Flutter est au framework

TU AS DÉJÀ APPRIS DART → Tu connais :
  ✅ Variables et types
  ✅ Conditions et boucles
  ✅ Fonctions
  ✅ Classes et POO
  ✅ async/await
  ✅ Collections

EN FLUTTER, tu vas utiliser TOUT ça + apprendre :
  🆕 Les Widgets (les briques de l'UI)
  🆕 Le State (la gestion des données qui changent)
  🆕 La Navigation (passer d'un écran à l'autre)
  🆕 Les APIs et la gestion de données
  🆕 L'animation et l'UX
*/

// ============================================================
// 📖 PARTIE 6 : TON PREMIER COUP D'ŒIL SUR FLUTTER
// ============================================================

/*
Voici à quoi ressemble une application Flutter MINIMALISTE.
Ne t'inquiète pas si tu ne comprends pas tout maintenant —
chaque partie sera expliquée en détail dans les prochaines leçons.
*/

// Voici le code d'une app Flutter "Hello World" commenté :

// ─────────────────────────────────────────────────────────────
// Ce code est ILLUSTRATIF — il ne s'exécute pas tel quel
// dans DartPad standard. Il faut un projet Flutter complet.
// ─────────────────────────────────────────────────────────────

/*
// IMPORT OBLIGATOIRE — le package principal de Flutter
import 'package:flutter/material.dart';

// POINT D'ENTRÉE — comme main() en Dart pur
void main() {
  // runApp() démarre l'application Flutter
  // Elle prend un Widget comme argument
  runApp(const MonApplication());
}

// STATELESSWIDGET = un widget qui ne change PAS
// (on expliquera ça en détail au Chapitre 03)
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  // build() est la méthode qui DESSINE le widget
  // Elle retourne toujours un Widget
  @override
  Widget build(BuildContext context) {
    // MaterialApp = la structure de base d'une app Material Design
    return MaterialApp(
      title: 'Ma Première App',        // Titre de l'app
      debugShowCheckedModeBanner: false, // Cache le bandeau "DEBUG"

      // theme = le style global de l'app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),

      // home = l'écran d'accueil
      home: const EcranAccueil(),
    );
  }
}

class EcranAccueil extends StatelessWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = la "coquille" d'un écran
    // (barre du haut, corps, bouton flottant...)
    return Scaffold(
      // AppBar = la barre en haut de l'écran
      appBar: AppBar(
        title: const Text('Ma Première App Flutter'),
        backgroundColor: Colors.blue,
      ),

      // body = le contenu principal de la page
      body: const Center(         // Center = centrer son enfant
        child: Column(            // Column = empiler verticalement
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(                 // Text = afficher du texte
              '👋 Bonjour, Flutter !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), // SizedBox = espace vide
            Text(
              'Tu viens de créer ta première app !',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
*/

// ============================================================
// ✅ RÉSUMÉ DE LA LEÇON
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║  ✅ CE QUE TU AS APPRIS                                      ║
╠══════════════════════════════════════════════════════════════╣
║  • Flutter = framework Google pour apps multi-plateformes   ║
║  • Un seul code → iOS, Android, Web, Desktop                ║
║  • Tout est Widget (les briques de construction de l'UI)    ║
║  • Flutter dessine ses propres pixels → perf maximale       ║
║  • Dart est le langage, Flutter est le framework            ║
║  • Hot Reload = voir les changements en temps réel          ║
║  • Tu connais déjà Dart → 50% du chemin est fait !          ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 🏋️ EXERCICES
// ============================================================

/*
🟢 FACILE :
  Sans regarder le cours, explique en 3 phrases simples ce qu'est
  Flutter à quelqu'un qui ne sait pas programmer.

🟡 MOYEN :
  Compare Flutter avec une technologie que tu connais
  (ex: un site web, une app Android). Quelles sont les 3 principales
  différences que tu retiens ?

🔴 DIFFICILE :
  Recherche 3 applications populaires construites avec Flutter
  (utilise Google). Note le nom, la catégorie, et pourquoi
  l'entreprise a choisi Flutter selon toi.

══════════════════════════════════════════════════════════════
SOLUTIONS
══════════════════════════════════════════════════════════════

🟢 SOLUTION :
  "Flutter est un outil créé par Google qui permet aux développeurs
  d'écrire un seul code et d'obtenir une application qui fonctionne
  sur téléphone, tablette, et ordinateur. Il utilise le langage Dart
  et dessine lui-même chaque élément visible à l'écran."

🟡 SOLUTION (comparaison site web) :
  1. Un site web nécessite HTML+CSS+JS, Flutter utilise uniquement Dart
  2. Un site web s'ouvre dans un navigateur, Flutter crée de vraies apps
  3. Flutter tourne aussi sur mobile nativement, un site web non (PWA mis à part)

🔴 SOLUTION (exemples d'apps Flutter) :
  → Google Pay (paiements)
  → Alibaba (Xianyu, marketplace)
  → BMW App (automobile)
  → Nubank (banque, Brésil)
  → eBay Motors (marketplace)
  Ces entreprises ont choisi Flutter pour la cohérence
  d'UI entre plateformes et la rapidité de développement.
*/

void main() {
  print('╔══════════════════════════════════════════════════╗');
  print('║   LEÇON 1 : QU\'EST-CE QUE FLUTTER ?              ║');
  print('╚══════════════════════════════════════════════════╝');
  print('');
  print('Flutter en résumé :');
  print('  → Framework Google open-source');
  print('  → Langage : Dart (que tu connais déjà !)');
  print('  → Cible : iOS, Android, Web, macOS, Windows, Linux');
  print('  → Performance : Haute (rendu propre, 60fps+)');
  print('  → Concept clé : TOUT est un Widget');
  print('');
  print('Prochaine leçon → Installation de Flutter !');
}
