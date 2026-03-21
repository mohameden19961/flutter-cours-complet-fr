// ============================================================
// 📘 CHAPITRE 03 — LEÇON 1
// StatelessWidget — Les Widgets Sans État
// Niveau : Débutant Flutter
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS DE CETTE LEÇON                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre ce qu'est un Widget en profondeur           ║
║   ✅ Créer des StatelessWidgets personnalisés               ║
║   ✅ Utiliser les widgets de base (Text, Icon, Image...)    ║
║   ✅ Passer des données via le constructeur                 ║
║   ✅ Appliquer des styles avec TextStyle, BoxDecoration     ║
╚══════════════════════════════════════════════════════════════╝
*/

// ─── NOTE : Ce fichier contient des exemples Flutter
// Pour les exécuter, copie le code dans un projet Flutter
// dans lib/main.dart et remplace le contenu.
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

// ============================================================
// 📖 PARTIE 1 : QU'EST-CE QU'UN WIDGET ?
// ============================================================

/*
🧱 DÉFINITION
═════════════
En Flutter, TOUT ce que tu vois à l'écran est un Widget :
  → Le texte "Bonjour" → Widget Text
  → Le bouton rouge → Widget ElevatedButton
  → L'image de profil → Widget Image
  → L'espace vide entre deux éléments → Widget SizedBox
  → La couleur de fond → Widget Container
  → La mise en page elle-même → Widget Column/Row/Stack

📖 ANALOGIE
════════════
Les Widgets sont comme des PIÈCES DE LEGO :
  → Chaque pièce a une forme précise
  → On peut les assembler de mille façons différentes
  → Les petites pièces s'imbriquent dans les grandes
  → Ensemble, ils forment quelque chose de grand

🌳 L'ARBRE DE WIDGETS (Widget Tree)
════════════════════════════════════
Ton app Flutter est un ARBRE de widgets imbriqués :

MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text("Titre")
    └── Body
        └── Column
            ├── Text("Bonjour")
            ├── SizedBox(height: 16)
            └── ElevatedButton
                └── Text("Cliquer")

Chaque widget est le "parent" de ceux qui sont à l'intérieur.
*/

// ============================================================
// 📖 PARTIE 2 : STATELESS VS STATEFUL
// ============================================================

/*
STATELESSWIDGET = Widget SANS état (sans mémoire)
══════════════════════════════════════════════════
  → Il reçoit des données (paramètres) lors de sa création
  → Il les AFFICHE mais ne peut PAS les modifier
  → Une fois créé, il ne change JAMAIS
  → Plus simple, plus performant

  Exemples : logo de l'app, texte statique, carte de profil fixe

STATEFULWIDGET = Widget AVEC état (avec mémoire)
═════════════════════════════════════════════════
  → Il peut changer selon les interactions
  → Un compteur, un formulaire, une liste qui se met à jour
  → Plus complexe (expliqué en détail à la leçon suivante)

RÈGLE D'OR :
  → Commence TOUJOURS par StatelessWidget
  → Passe en StatefulWidget SEULEMENT si tu as besoin
    que quelque chose change dans le widget
*/

// ============================================================
// 📖 PARTIE 3 : CRÉER UN STATELESSWIDGET
// ============================================================

// ─── Structure de base d'un StatelessWidget ──────────────────
class MonPremierWidget extends StatelessWidget {
  // ① Le constructeur — avec {super.key} (bonne pratique)
  const MonPremierWidget({super.key});

  // ② La méthode build() — OBLIGATOIRE
  // Elle décrit à quoi ressemble le widget
  // BuildContext = le "contexte" de l'app (thème, taille, etc.)
  @override
  Widget build(BuildContext context) {
    // Retourne UN widget (qui peut en contenir d'autres)
    return const Text(
      'Mon premier Widget Flutter !',
      style: TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ─── Widget avec paramètres (données passées de l'extérieur) ──
class CarteUtilisateur extends StatelessWidget {
  // ① Déclarer les propriétés FINALES (immutables)
  final String nom;
  final String email;
  final String? photoUrl; // Nullable = optionnel
  final int age;

  // ② Constructeur avec paramètres nommés obligatoires
  const CarteUtilisateur({
    super.key,
    required this.nom,    // required = obligatoire
    required this.email,
    required this.age,
    this.photoUrl,        // Optionnel (pas de required)
  });

  // ③ build() utilise les propriétés pour construire l'UI
  @override
  Widget build(BuildContext context) {
    return Card(
      // Card = widget avec ombre portée (Material)
      elevation: 4, // Hauteur de l'ombre
      margin: const EdgeInsets.all(16), // Marge extérieure
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Coins arrondis
      ),
      child: Padding(
        // Padding = espace intérieur
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Photo de profil
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              backgroundImage: photoUrl != null
                  ? NetworkImage(photoUrl!) // Image depuis URL
                  : null,
              child: photoUrl == null
                  ? Text(
                      // Première lettre du nom
                      nom.isNotEmpty ? nom[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 16), // Espace horizontal

            // Informations
            Expanded(
              // Expanded = prend tout l'espace disponible
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nom,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$age ans',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widget de badge / étiquette ──────────────────────────────
class BadgeEtiquette extends StatelessWidget {
  final String texte;
  final Color couleur;
  final IconData? icone;

  const BadgeEtiquette({
    super.key,
    required this.texte,
    this.couleur = Colors.blue,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container = widget de mise en forme polyvalent
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        // BoxDecoration = définit l'apparence d'un Container
        color: couleur.withOpacity(0.15), // Fond semi-transparent
        borderRadius: BorderRadius.circular(20), // Pilule
        border: Border.all(
          color: couleur.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prend le minimum d'espace
        children: [
          if (icone != null) ...[
            // if dans une liste de widgets = conditionnel
            Icon(icone, size: 14, color: couleur),
            const SizedBox(width: 4),
          ],
          Text(
            texte,
            style: TextStyle(
              color: couleur,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Widget de statistique (carte de chiffre) ────────────────
class CarteStatistique extends StatelessWidget {
  final String titre;
  final String valeur;
  final IconData icone;
  final Color couleur;

  const CarteStatistique({
    super.key,
    required this.titre,
    required this.valeur,
    required this.icone,
    required this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Dégradé de couleurs
          colors: [
            couleur,
            couleur.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Ombre portée
          BoxShadow(
            color: couleur.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            valeur,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            titre,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 📖 PARTIE 4 : WIDGETS DE BASE À CONNAÎTRE
// ============================================================

class DemoWidgetsBase extends StatelessWidget {
  const DemoWidgetsBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets de Base')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── TEXT ────────────────────────────────────────
            const Text('1. Widget Text'),
            const SizedBox(height: 8),
            const Text('Texte simple'),
            const Text(
              'Texte stylisé',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
                letterSpacing: 2,
              ),
            ),
            // RichText = texte avec plusieurs styles dans une phrase
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: 'Texte '),
                  TextSpan(
                    text: 'multi-style',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' en Flutter'),
                ],
              ),
            ),

            const Divider(height: 32), // Ligne de séparation

            // ─── ICON ─────────────────────────────────────────
            const Text('2. Widget Icon'),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                Icon(Icons.favorite, color: Colors.red, size: 32),
                Icon(Icons.home, color: Colors.blue, size: 32),
                Icon(Icons.settings, color: Colors.grey, size: 32),
              ],
            ),

            const Divider(height: 32),

            // ─── IMAGE ────────────────────────────────────────
            const Text('3. Widget Image'),
            const SizedBox(height: 8),
            // Image depuis internet :
            // Image.network(
            //   'https://flutter.dev/images/flutter-logo-sharing.png',
            //   width: 200,
            //   height: 100,
            //   fit: BoxFit.contain,
            // ),

            // Image depuis les assets :
            // Image.asset('assets/images/logo.png'),

            // Placeholder (simuler une image) :
            Container(
              width: 200,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.image,
                size: 48,
                color: Colors.grey,
              ),
            ),

            const Divider(height: 32),

            // ─── CONTAINER ────────────────────────────────────
            const Text('4. Widget Container'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity, // Toute la largeur
              height: 80,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: const Text(
                'Container avec style complet',
                style: TextStyle(color: Colors.blue),
              ),
            ),

            const Divider(height: 32),

            // ─── BUTTONS ──────────────────────────────────────
            const Text('5. Boutons'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('ElevatedButton'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('OutlinedButton'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('TextButton'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                ),
                FloatingActionButton.small(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL — Demo complète
// ============================================================

void main() {
  runApp(const AppDemo());
}

class AppDemo extends StatelessWidget {
  const AppDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo StatelessWidget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EcranPrincipal(),
    );
  }
}

class EcranPrincipal extends StatelessWidget {
  const EcranPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Mes Widgets Personnalisés'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Cartes Utilisateurs ──────────────────────────
            const Text(
              'Cartes Utilisateurs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const CarteUtilisateur(
              nom: 'Alice Martin',
              email: 'alice@exemple.com',
              age: 28,
            ),
            const CarteUtilisateur(
              nom: 'Bob Dupont',
              email: 'bob@exemple.com',
              age: 32,
              photoUrl: null,
            ),

            const SizedBox(height: 24),

            // ─── Badges ───────────────────────────────────────
            const Text(
              'Badges / Étiquettes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                BadgeEtiquette(texte: 'Flutter', couleur: Colors.blue),
                BadgeEtiquette(
                  texte: 'Expert',
                  couleur: Colors.green,
                  icone: Icons.star,
                ),
                BadgeEtiquette(
                  texte: 'En cours',
                  couleur: Colors.orange,
                  icone: Icons.access_time,
                ),
                BadgeEtiquette(
                  texte: 'Terminé',
                  couleur: Colors.purple,
                  icone: Icons.check_circle,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Statistiques ─────────────────────────────────
            const Text(
              'Statistiques',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CarteStatistique(
                    titre: 'Leçons',
                    valeur: '22',
                    icone: Icons.book,
                    couleur: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  CarteStatistique(
                    titre: 'Projets',
                    valeur: '5',
                    icone: Icons.code,
                    couleur: Colors.green,
                  ),
                  SizedBox(width: 12),
                  CarteStatistique(
                    titre: 'Jours',
                    valeur: '30',
                    icone: Icons.calendar_today,
                    couleur: Colors.orange,
                  ),
                  SizedBox(width: 12),
                  CarteStatistique(
                    titre: 'Score',
                    valeur: '98%',
                    icone: Icons.star,
                    couleur: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 🏋️ EXERCICES
// ============================================================

/*
🟢 FACILE :
  Crée un widget StatelessWidget appelé "CarteProduit" qui affiche :
  - Le nom du produit (String)
  - Le prix (double)
  - Une icône (Icons.shopping_bag par défaut)
  Utilise une Card avec du Padding.

🟡 MOYEN :
  Crée un widget "BoutonPersonnalise" avec ces propriétés :
  - texte (String)
  - couleur (Color)
  - icone (IconData, optionnel)
  - onPressed (VoidCallback = une fonction void sans argument)
  Le bouton doit être un ElevatedButton avec l'icône si fournie.

🔴 DIFFICILE :
  Crée un widget "CarteProfil" complet qui ressemble à une carte
  de réseaux sociaux avec :
  - Photo de profil (CircleAvatar)
  - Nom et bio
  - Compteurs (posts, followers, following) en Row
  - Bouton "Suivre"
  Tout doit être des propriétés configurables.

══════════════════════════════════════════════════════════════
SOLUTIONS
══════════════════════════════════════════════════════════════

// 🟢 SOLUTION :
class CarteProduit extends StatelessWidget {
  final String nom;
  final double prix;
  final IconData icone;

  const CarteProduit({
    super.key,
    required this.nom,
    required this.prix,
    this.icone = Icons.shopping_bag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icone, size: 40, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${prix.toStringAsFixed(2)} €',
                      style: const TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
