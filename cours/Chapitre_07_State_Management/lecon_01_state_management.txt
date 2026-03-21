// ============================================================
// 📘 CHAPITRE 07 — LEÇON 1
// State Management : De setState à Provider
// Niveau : Intermédiaire → Avancé
// ============================================================

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Ajouter dans pubspec.yaml

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre les limites de setState                     ║
║   ✅ Apprendre InheritedWidget (base de tout)               ║
║   ✅ Maîtriser Provider (solution recommandée)              ║
║   ✅ Implémenter ChangeNotifier                             ║
║   ✅ Comprendre ValueNotifier pour les cas simples          ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : PROBLÈME AVEC setState
// ============================================================

/*
📖 PROBLÈME : "Prop Drilling"
══════════════════════════════
Imagine cette structure d'app :

  AppRoot
  └── PageProduits
      └── ListeProduits
          └── CarteProduit
              └── BoutonPanier  ← DOIT CONNAÎTRE LE PANIER

Si le panier est dans AppRoot, il faut passer les données
de niveau en niveau (AppRoot → Page → Liste → Carte → Bouton).
C'est le "Prop Drilling" → CAUCHEMAR à maintenir !

SOLUTIONS DE STATE MANAGEMENT
══════════════════════════════
  Niveau 1 → setState()       : Pour l'état LOCAL d'un seul widget
  Niveau 2 → ValueNotifier    : Pour partager 1 valeur simple
  Niveau 3 → InheritedWidget  : Base de Flutter, complexe
  Niveau 4 → Provider         : ✅ Recommandé (simple + puissant)
  Niveau 5 → Riverpod         : Version améliorée de Provider
  Niveau 6 → Bloc/Cubit       : Pour les grandes apps
  Niveau 7 → Redux/MobX       : Patterns avancés

Pour ce cours : setState + Provider (le duo parfait !)
*/

// ============================================================
// 📖 PARTIE 2 : VALUENOTIFIER (solution légère)
// ============================================================

/*
ValueNotifier = un "observateur" pour une seule valeur.
Quand la valeur change, les widgets qui l'écoutent se rebuilent.
Pas besoin de StatefulWidget !
*/

class DemoValueNotifier extends StatelessWidget {
  DemoValueNotifier({super.key});

  // ValueNotifier ne nécessite PAS de StatefulWidget
  final ValueNotifier<int> _compteur = ValueNotifier(0);
  final ValueNotifier<bool> _favori = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ValueListenableBuilder se rebuild UNIQUEMENT quand _compteur change
        ValueListenableBuilder<int>(
          valueListenable: _compteur,
          builder: (context, valeur, child) {
            return Text(
              'Compteur : $valeur',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _compteur.value--,
              icon: const Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () => _compteur.value++,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Bouton favori avec ValueNotifier
        ValueListenableBuilder<bool>(
          valueListenable: _favori,
          builder: (context, estFavori, child) {
            return IconButton(
              iconSize: 40,
              onPressed: () => _favori.value = !_favori.value,
              icon: Icon(
                estFavori ? Icons.favorite : Icons.favorite_border,
                color: estFavori ? Colors.red : Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 3 : PROVIDER — La solution complète
// ============================================================

/*
COMMENT FONCTIONNE PROVIDER ?
══════════════════════════════

  1. Tu crées un ChangeNotifier (le "magasin" de données)
  2. Tu le fournis via ChangeNotifierProvider
  3. N'importe quel widget peut l'écouter avec context.watch()
  4. Quand les données changent → notifyListeners() → UI se met à jour

AJOUTER PROVIDER DANS pubspec.yaml :
══════════════════════════════════════
  dependencies:
    provider: ^6.1.1

Puis : flutter pub get
*/

// ─── 1. Le ChangeNotifier (notre "Store") ────────────────────
class PanierStore extends ChangeNotifier {
  // État interne (privé)
  final List<ProduitModel> _articles = [];
  bool _chargement = false;

  // Getters publics (lecture seule)
  List<ProduitModel> get articles => List.unmodifiable(_articles);
  bool get chargement => _chargement;
  int get nombreArticles => _articles.length;
  double get total => _articles.fold(0, (sum, p) => sum + p.prix);
  bool get estVide => _articles.isEmpty;

  // Méthodes qui modifient l'état
  void ajouterArticle(ProduitModel produit) {
    _articles.add(produit);
    notifyListeners(); // ← Notifie tous les widgets qui écoutent
  }

  void retirerArticle(ProduitModel produit) {
    _articles.removeWhere((p) => p.id == produit.id);
    notifyListeners();
  }

  bool contient(String id) => _articles.any((p) => p.id == id);

  void vider() {
    _articles.clear();
    notifyListeners();
  }

  Future<void> commander() async {
    _chargement = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // Simule API
    _articles.clear();

    _chargement = false;
    notifyListeners();
  }
}

// ─── 2. Le modèle de données ──────────────────────────────────
class ProduitModel {
  final String id;
  final String nom;
  final double prix;
  final IconData icone;
  final Color couleur;

  const ProduitModel({
    required this.id,
    required this.nom,
    required this.prix,
    required this.icone,
    required this.couleur,
  });
}

// ─── 3. Données de test ───────────────────────────────────────
final List<ProduitModel> produitsDisponibles = [
  ProduitModel(
    id: 'p1',
    nom: 'Cours Flutter',
    prix: 29.99,
    icone: Icons.phone_android,
    couleur: Colors.blue,
  ),
  ProduitModel(
    id: 'p2',
    nom: 'Cours Dart',
    prix: 19.99,
    icone: Icons.code,
    couleur: Colors.teal,
  ),
  ProduitModel(
    id: 'p3',
    nom: 'Cours Firebase',
    prix: 24.99,
    icone: Icons.storage,
    couleur: Colors.orange,
  ),
  ProduitModel(
    id: 'p4',
    nom: 'Cours UI/UX',
    prix: 34.99,
    icone: Icons.palette,
    couleur: Colors.purple,
  ),
];

// ─── 4. Widget liste de produits ──────────────────────────────
// Note: Utilise context.watch() et context.read()
// Pour l'exemple, on simulera Provider avec un InheritedWidget simplifié

class ListeProduits extends StatelessWidget {
  final PanierStore panier;
  const ListeProduits({super.key, required this.panier});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: produitsDisponibles.length,
      itemBuilder: (context, index) {
        final produit = produitsDisponibles[index];
        return _CarteProduit(produit: produit, panier: panier);
      },
    );
  }
}

class _CarteProduit extends StatelessWidget {
  final ProduitModel produit;
  final PanierStore panier;

  const _CarteProduit({required this.produit, required this.panier});

  @override
  Widget build(BuildContext context) {
    // Avec Provider réel, on utiliserait :
    // final panier = context.watch<PanierStore>();
    final estDansPanier = panier.contient(produit.id);

    return ListenableBuilder(
      listenable: panier,
      builder: (context, _) {
        final dansPanier = panier.contient(produit.id);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: produit.couleur.withOpacity(0.2),
              child: Icon(produit.icone, color: produit.couleur),
            ),
            title: Text(produit.nom),
            subtitle: Text(
              '${produit.prix.toStringAsFixed(2)} €',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: dansPanier
                  ? IconButton(
                      key: const ValueKey('dans'),
                      icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                      onPressed: () => panier.retirerArticle(produit),
                    )
                  : IconButton(
                      key: const ValueKey('hors'),
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () => panier.ajouterArticle(produit),
                    ),
            ),
          ),
        );
      },
    );
  }
}

// ─── 5. Widget panier ─────────────────────────────────────────
class WidgetPanier extends StatelessWidget {
  final PanierStore panier;
  const WidgetPanier({super.key, required this.panier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: panier,
      builder: (context, _) {
        if (panier.estVide) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Panier vide', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: panier.articles.length,
                itemBuilder: (context, index) {
                  final article = panier.articles[index];
                  return ListTile(
                    leading: Icon(article.icone, color: article.couleur),
                    title: Text(article.nom),
                    trailing: Text('${article.prix.toStringAsFixed(2)} €'),
                    onLongPress: () => panier.retirerArticle(article),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total :',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        '${panier.total.toStringAsFixed(2)} €',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: panier.chargement ? null : panier.commander,
                      icon: panier.chargement
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.payment),
                      label: Text(
                          panier.chargement ? 'Commande en cours...' : 'Commander'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(const AppStateManagement());
}

class AppStateManagement extends StatelessWidget {
  const AppStateManagement({super.key});

  @override
  Widget build(BuildContext context) {
    // Créer le store (dans une vraie app, utilise ChangeNotifierProvider)
    final panier = PanierStore();

    return MaterialApp(
      title: 'State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: _AppPrincipale(panier: panier),
    );
  }
}

class _AppPrincipale extends StatefulWidget {
  final PanierStore panier;
  const _AppPrincipale({required this.panier});

  @override
  State<_AppPrincipale> createState() => _AppPrincipaleState();
}

class _AppPrincipaleState extends State<_AppPrincipale> {
  int _ongletActuel = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.panier,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ma Boutique Flutter'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => setState(() => _ongletActuel = 1),
                  ),
                  if (widget.panier.nombreArticles > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${widget.panier.nombreArticles}',
                          style: const TextStyle(
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
          body: _ongletActuel == 0
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nos Cours',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListeProduits(panier: widget.panier),
                    ],
                  ),
                )
              : WidgetPanier(panier: widget.panier),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _ongletActuel,
            onDestinationSelected: (i) => setState(() => _ongletActuel = i),
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.store),
                label: 'Boutique',
              ),
              NavigationDestination(
                icon: Badge(
                  count: widget.panier.nombreArticles,
                  isLabelVisible: widget.panier.nombreArticles > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Panier',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// 🏋️ EXERCICES
// ============================================================

/*
🟢 FACILE :
  Crée un ChangeNotifier "ThemeStore" avec :
  - bool isDark
  - void toggleTheme()
  Utilise-le pour changer le thème de l'app au clic d'un bouton.

🟡 MOYEN :
  Crée un ChangeNotifier "FavorisStore" avec :
  - Liste de favoris (IDs)
  - Ajouter/retirer un favori
  - Vérifier si un élément est favori
  Applique-le à une liste de produits.

🔴 DIFFICILE :
  Avec Provider (ajouter dans pubspec.yaml) :
  1. Crée un AuthStore (isConnecte, utilisateur, connexion(), deconnexion())
  2. Fournis-le via ChangeNotifierProvider dans MaterialApp
  3. Affiche l'écran Login si !isConnecte, l'écran Accueil sinon
  4. Un bouton "Déconnexion" dans l'accueil met à jour l'état global
*/
