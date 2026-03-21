// ============================================================
// 📘 CHAPITRE 04 — LEÇON 1
// Layouts Flutter : Row, Column, Stack et plus
// Niveau : Débutant Flutter
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Maîtriser Row et Column                                ║
║   ✅ Comprendre MainAxisAlignment et CrossAxisAlignment     ║
║   ✅ Utiliser Expanded, Flexible, Spacer                    ║
║   ✅ Superposer avec Stack et Positioned                    ║
║   ✅ Construire des layouts complexes réels                 ║
╚══════════════════════════════════════════════════════════════╝
*/

import 'package:flutter/material.dart';

// ============================================================
// 📖 PARTIE 1 : COLUMN — Organisation Verticale
// ============================================================

/*
📖 ANALOGIE
════════════
Column = une pile de livres sur une étagère
  → Les livres sont empilés de haut en bas
  → Tu contrôles l'alignement horizontal (gauche/centre/droite)
  → Tu contrôles l'espacement vertical

PROPRIÉTÉS CLÉS DE COLUMN
═══════════════════════════
  mainAxisAlignment   → Alignement sur l'AXE PRINCIPAL (vertical)
  crossAxisAlignment  → Alignement sur l'AXE SECONDAIRE (horizontal)
  mainAxisSize        → Taille de la colonne (max ou min)
*/

class DemoColumn extends StatelessWidget {
  const DemoColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // ─── mainAxisAlignment ─────────────────────────────────
      // start     → En haut (défaut)
      // end       → En bas
      // center    → Au milieu
      // spaceBetween → Espace égal ENTRE les enfants
      // spaceAround  → Espace égal AUTOUR des enfants
      // spaceEvenly  → Espace exactement égal partout
      mainAxisAlignment: MainAxisAlignment.center,

      // ─── crossAxisAlignment ────────────────────────────────
      // start    → À gauche
      // end      → À droite
      // center   → Au milieu (défaut)
      // stretch  → Étire sur toute la largeur
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        const Text('Premier élément'),
        const SizedBox(height: 8), // Espace vertical
        const Text('Deuxième élément'),
        const SizedBox(height: 8),
        const Text('Troisième élément'),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 2 : ROW — Organisation Horizontale
// ============================================================

/*
📖 ANALOGIE
════════════
Row = une rangée de wagons de train
  → Les wagons sont alignés de gauche à droite
  → Tu contrôles l'alignement vertical (haut/milieu/bas)
*/

class DemoRow extends StatelessWidget {
  const DemoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement égal
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.amber),
        const Text('Produit'),
        const Text('25 €', style: TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text('Acheter'),
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 3 : EXPANDED & FLEXIBLE & SPACER
// ============================================================

/*
EXPANDED = prend TOUT l'espace disponible (comme flex: 1)
FLEXIBLE = prend jusqu'à l'espace disponible (peut rester petit)
SPACER   = espace vide flexible (comme Expanded avec Container vide)
*/

class DemoExpanded extends StatelessWidget {
  const DemoExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── ROW avec Expanded ────────────────────────────────
        const Text('Row avec Expanded :'),
        Row(
          children: [
            // flex: 1 = 1 part
            Expanded(
              flex: 2, // 2 parts = 2/3 de l'espace
              child: Container(
                height: 50,
                color: Colors.blue,
                child: const Center(
                  child: Text('flex:2', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 1, // 1 part = 1/3 de l'espace
              child: Container(
                height: 50,
                color: Colors.red,
                child: const Center(
                  child: Text('flex:1', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ─── ROW avec Spacer ──────────────────────────────────
        const Text('Row avec Spacer (icône + titre + action) :'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.notifications, color: Colors.blue),
              const SizedBox(width: 8),
              const Text('Nouvelle notification'),
              const Spacer(), // Pousse les éléments suivants à droite
              TextButton(
                onPressed: () {},
                child: const Text('Voir'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 4 : STACK — Superposition
// ============================================================

/*
📖 ANALOGIE
════════════
Stack = une pile de feuilles sur un bureau
  → Les feuilles sont posées les unes sur les autres
  → La dernière posée est visible en premier
  → On peut positionner chaque feuille précisément

Utile pour :
  → Badges sur des icônes
  → Texte sur une image
  → Boutons flottants personnalisés
*/

class DemoStack extends StatelessWidget {
  const DemoStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Stack simple : image + texte par-dessus ──────────
        const Text('Stack : texte sur image'),
        const SizedBox(height: 8),
        SizedBox(
          width: 300,
          height: 180,
          child: Stack(
            children: [
              // ① Couche de fond (image simulée)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.purple.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // ② Éléments superposés avec Positioned
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '🔥 NOUVEAU',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // ③ Texte centré en bas
              const Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cours Flutter Complet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '12 chapitres • 40 leçons',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Stack : badge sur icône ───────────────────────────
        const Text('Stack : badge sur icône'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge notifications
            Stack(
              clipBehavior: Clip.none, // Permet le badge de déborder
              children: [
                const Icon(Icons.notifications, size: 40, color: Colors.blue),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 5 : AUTRES WIDGETS DE LAYOUT IMPORTANTS
// ============================================================

class DemoAutresLayouts extends StatelessWidget {
  const DemoAutresLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── WRAP — comme Row mais avec retour à la ligne ─────
        const Text('Wrap (retour à la ligne automatique) :',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, // Espace horizontal entre les éléments
          runSpacing: 8, // Espace vertical entre les lignes
          children: [
            for (final tag in [
              'Flutter',
              'Dart',
              'Mobile',
              'iOS',
              'Android',
              'Web',
              'Open Source',
            ])
              Chip(
                label: Text(tag),
                backgroundColor: Colors.blue.shade50,
                labelStyle: const TextStyle(color: Colors.blue),
              ),
          ],
        ),

        const SizedBox(height: 24),

        // ─── GRIDVIEW.COUNT — Grille fixe ────────────────────
        const Text('GridView (2 colonnes) :',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3, // 3 colonnes
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(9, (index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length]
                      .shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 24),

        // ─── LISTVIEW.BUILDER — Liste optimisée ──────────────
        const Text('ListView.builder (liste optimisée) :',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text('${index + 1}'),
                ),
                title: Text('Élément ${index + 1}'),
                subtitle: Text('Sous-titre ${index + 1}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 6 : LAYOUT RÉEL — Carte Produit Complète
// ============================================================

class CarteProduitComplete extends StatelessWidget {
  final String nom;
  final double prix;
  final double prixOriginal;
  final double note;
  final int nbAvis;
  final String categorie;

  const CarteProduitComplete({
    super.key,
    required this.nom,
    required this.prix,
    required this.prixOriginal,
    required this.note,
    required this.nbAvis,
    required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    final double reduction = ((prixOriginal - prix) / prixOriginal * 100);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + badge réduction
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
              if (reduction > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '-${reduction.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.favorite_border, size: 18),
                ),
              ),
            ],
          ),

          // Informations du produit
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Catégorie
                Text(
                  categorie.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),

                // Nom du produit
                Text(
                  nom,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Note et avis
                Row(
                  children: [
                    ...List.generate(5, (i) {
                      return Icon(
                        i < note.floor() ? Icons.star : Icons.star_border,
                        size: 14,
                        color: Colors.amber,
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      '($nbAvis)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${prix.toStringAsFixed(2)} €',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        if (prixOriginal > prix)
                          Text(
                            '${prixOriginal.toStringAsFixed(2)} €',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart, size: 16),
                      label: const Text('Ajouter'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(const AppLayouts());
}

class AppLayouts extends StatelessWidget {
  const AppLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layouts Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EcranLayouts(),
    );
  }
}

class EcranLayouts extends StatelessWidget {
  const EcranLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layouts Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded demo
            const Text('Expanded & Spacer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const DemoExpanded(),

            const Divider(height: 48),

            // Stack demo
            const Text('Stack & Positioned',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const DemoStack(),

            const Divider(height: 48),

            // Autres layouts
            const Text('Autres Layouts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const DemoAutresLayouts(),

            const Divider(height: 48),

            // Carte produit complète
            const Text('Carte Produit Réelle',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CarteProduitComplete(
              nom: 'Cours Flutter Avancé — Du Zéro au Pro',
              prix: 29.99,
              prixOriginal: 99.99,
              note: 4.5,
              nbAvis: 2847,
              categorie: 'Développement Mobile',
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
  Crée une Row avec 3 icônes (maison, recherche, profil) espacées
  uniformément avec mainAxisAlignment.spaceEvenly.

🟡 MOYEN :
  Crée un layout de "Profil Utilisateur" avec :
  - Photo (CircleAvatar) à gauche
  - Nom, email en Column à droite (Expanded)
  - Row en dessous avec 3 statistiques (Posts/Followers/Following)
  Utilise Row, Column, Expanded correctement.

🔴 DIFFICILE :
  Crée un "StoryWidget" style Instagram avec Stack :
  - Image de fond (Container coloré)
  - Gradient sombre en bas (BoxDecoration avec gradient)
  - Texte du nom en bas à gauche
  - Durée en haut à droite
  - Une barre de progression en haut (LinearProgressIndicator)
*/
