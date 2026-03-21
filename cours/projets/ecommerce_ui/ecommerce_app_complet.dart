// ============================================================
// 🏆 PROJET 4 — E-COMMERCE UI COMPLÈTE
// Niveau : Avancé
// ============================================================

import 'package:flutter/material.dart';

/*
FONCTIONNALITÉS :
  ✅ Écran d'accueil avec bannières et catégories
  ✅ Catalogue de produits en grille
  ✅ Page produit détaillée
  ✅ Panier avec total et quantités
  ✅ Barre de navigation avec badge
  ✅ Favoris
  ✅ Recherche et filtres
  ✅ UI premium Material 3
*/

// ============================================================
// 🗂️ MODÈLES
// ============================================================

class Produit {
  final String id;
  final String nom;
  final String description;
  final double prix;
  final double? prixOriginal;
  final String categorie;
  final double note;
  final int nbAvis;
  final List<String> tailles;
  final List<Color> couleurs;
  final Color couleurPrincipale;
  final String emoji;

  const Produit({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    this.prixOriginal,
    required this.categorie,
    required this.note,
    required this.nbAvis,
    this.tailles = const [],
    this.couleurs = const [],
    required this.couleurPrincipale,
    required this.emoji,
  });

  double get reduction =>
      prixOriginal != null ? (prixOriginal! - prix) / prixOriginal! * 100 : 0;
  bool get enPromo => prixOriginal != null && prixOriginal! > prix;
}

class ElementPanier {
  final Produit produit;
  int quantite;
  String? tailleSelectionnee;
  Color? couleurSelectionnee;

  ElementPanier({
    required this.produit,
    this.quantite = 1,
    this.tailleSelectionnee,
    this.couleurSelectionnee,
  });

  double get sousTotal => produit.prix * quantite;
}

// ============================================================
// 📦 DONNÉES
// ============================================================

const List<Produit> catalogue = [
  Produit(
    id: 'p1',
    nom: 'Sneakers Air Max',
    description: 'Chaussures de sport légères avec amorti optimal pour le quotidien.',
    prix: 89.99,
    prixOriginal: 129.99,
    categorie: 'Chaussures',
    note: 4.7,
    nbAvis: 1243,
    tailles: ['38', '39', '40', '41', '42', '43', '44'],
    couleurs: [Color(0xFF2563EB), Color(0xFFEF4444), Color(0xFF1E293B)],
    couleurPrincipale: Color(0xFF2563EB),
    emoji: '👟',
  ),
  Produit(
    id: 'p2',
    nom: 'T-Shirt Premium',
    description: 'T-shirt 100% coton égyptien. Coupe moderne et confort optimal.',
    prix: 34.99,
    categorie: 'Vêtements',
    note: 4.5,
    nbAvis: 876,
    tailles: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    couleurs: [Color(0xFF1E293B), Color(0xFFF8FAFC), Color(0xFF10B981)],
    couleurPrincipale: Color(0xFF1E293B),
    emoji: '👕',
  ),
  Produit(
    id: 'p3',
    nom: 'Montre Smartwatch',
    description: 'Montre connectée avec suivi santé, GPS et autonomie 7 jours.',
    prix: 199.99,
    prixOriginal: 299.99,
    categorie: 'Tech',
    note: 4.8,
    nbAvis: 2341,
    tailles: [],
    couleurs: [Color(0xFF1E293B), Color(0xFFF8FAFC), Color(0xFF6366F1)],
    couleurPrincipale: Color(0xFF6366F1),
    emoji: '⌚',
  ),
  Produit(
    id: 'p4',
    nom: 'Sac à Dos Urban',
    description: 'Sac à dos 25L avec compartiment laptop 15" et ports USB.',
    prix: 59.99,
    categorie: 'Accessoires',
    note: 4.6,
    nbAvis: 543,
    tailles: [],
    couleurs: [Color(0xFF1E293B), Color(0xFF7C3AED), Color(0xFF059669)],
    couleurPrincipale: Color(0xFF1E293B),
    emoji: '🎒',
  ),
  Produit(
    id: 'p5',
    nom: 'Casque Audio Pro',
    description: 'Casque sans fil avec réduction de bruit active. 30h d\'autonomie.',
    prix: 149.99,
    prixOriginal: 199.99,
    categorie: 'Tech',
    note: 4.9,
    nbAvis: 3187,
    tailles: [],
    couleurs: [Color(0xFF1E293B), Color(0xFFF8FAFC)],
    couleurPrincipale: Color(0xFF1E293B),
    emoji: '🎧',
  ),
  Produit(
    id: 'p6',
    nom: 'Veste Bomber',
    description: 'Veste bomber vintage en nylon déperlant. Idéale entre-saisons.',
    prix: 119.99,
    prixOriginal: 169.99,
    categorie: 'Vêtements',
    note: 4.4,
    nbAvis: 312,
    tailles: ['S', 'M', 'L', 'XL'],
    couleurs: [Color(0xFF059669), Color(0xFF1E293B), Color(0xFF7C3AED)],
    couleurPrincipale: Color(0xFF059669),
    emoji: '🧥',
  ),
];

const List<Map<String, dynamic>> categories = [
  {'nom': 'Tous', 'emoji': '🛍️'},
  {'nom': 'Vêtements', 'emoji': '👕'},
  {'nom': 'Chaussures', 'emoji': '👟'},
  {'nom': 'Tech', 'emoji': '💻'},
  {'nom': 'Accessoires', 'emoji': '🎒'},
];

// ============================================================
// 🧠 STORE
// ============================================================

class BoutiqueStore extends ChangeNotifier {
  final List<ElementPanier> _panier = [];
  final Set<String> _favoris = {};
  String _categorieActive = 'Tous';
  String _recherche = '';

  // Panier
  List<ElementPanier> get panier => _panier;
  int get nbArticlesPanier =>
      _panier.fold(0, (sum, e) => sum + e.quantite);
  double get totalPanier =>
      _panier.fold(0, (sum, e) => sum + e.sousTotal);

  // Favoris
  bool estFavori(String id) => _favoris.contains(id);
  int get nbFavoris => _favoris.length;

  // Catalogue filtré
  String get categorieActive => _categorieActive;
  String get recherche => _recherche;

  List<Produit> get produitsFiltres => catalogue.where((p) {
        final catOk =
            _categorieActive == 'Tous' || p.categorie == _categorieActive;
        final rechOk = _recherche.isEmpty ||
            p.nom.toLowerCase().contains(_recherche.toLowerCase());
        return catOk && rechOk;
      }).toList();

  // Actions
  void toggleFavori(String id) {
    if (_favoris.contains(id)) {
      _favoris.remove(id);
    } else {
      _favoris.add(id);
    }
    notifyListeners();
  }

  void ajouterAuPanier(Produit p, {String? taille, Color? couleur}) {
    final i = _panier.indexWhere((e) => e.produit.id == p.id);
    if (i >= 0) {
      _panier[i].quantite++;
    } else {
      _panier.add(ElementPanier(
          produit: p,
          tailleSelectionnee: taille,
          couleurSelectionnee: couleur));
    }
    notifyListeners();
  }

  void changerQuantite(String id, int delta) {
    final i = _panier.indexWhere((e) => e.produit.id == id);
    if (i >= 0) {
      _panier[i].quantite += delta;
      if (_panier[i].quantite <= 0) _panier.removeAt(i);
      notifyListeners();
    }
  }

  void supprimerDuPanier(String id) {
    _panier.removeWhere((e) => e.produit.id == id);
    notifyListeners();
  }

  void setCategorie(String c) {
    _categorieActive = c;
    notifyListeners();
  }

  void setRecherche(String r) {
    _recherche = r;
    notifyListeners();
  }
}

// ============================================================
// 📱 APPLICATION
// ============================================================

void main() => runApp(const AppEcommerce());

class AppEcommerce extends StatelessWidget {
  const AppEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    final store = BoutiqueStore();
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) => MaterialApp(
        title: 'StyleShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
          ),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: MainScreen(store: store),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final BoutiqueStore store;
  const MainScreen({super.key, required this.store});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _onglet = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.store,
      builder: (_, __) {
        final ecrans = [
          EcranAccueil(store: widget.store),
          EcranCatalogue(store: widget.store),
          EcranPanier(store: widget.store),
          EcranFavoris(store: widget.store),
        ];

        return Scaffold(
          body: ecrans[_onglet],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _onglet,
            onDestinationSelected: (i) => setState(() => _onglet = i),
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Accueil'),
              const NavigationDestination(
                  icon: Icon(Icons.store_outlined),
                  selectedIcon: Icon(Icons.store),
                  label: 'Boutique'),
              NavigationDestination(
                icon: Badge(
                  count: widget.store.nbArticlesPanier,
                  isLabelVisible: widget.store.nbArticlesPanier > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  count: widget.store.nbArticlesPanier,
                  isLabelVisible: widget.store.nbArticlesPanier > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Panier',
              ),
              NavigationDestination(
                icon: Badge(
                  count: widget.store.nbFavoris,
                  isLabelVisible: widget.store.nbFavoris > 0,
                  child: const Icon(Icons.favorite_outline),
                ),
                selectedIcon: Badge(
                  count: widget.store.nbFavoris,
                  isLabelVisible: widget.store.nbFavoris > 0,
                  child: const Icon(Icons.favorite),
                ),
                label: 'Favoris',
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Écran Accueil ────────────────────────────────────────────
class EcranAccueil extends StatelessWidget {
  final BoutiqueStore store;
  const EcranAccueil({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Bonjour 👋',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 14)),
                        Text('Découvrez nos nouveautés',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bannière promo
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 20,
                          top: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Soldes 🔥',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("Jusqu'à -40%",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                              SizedBox(height: 12),
                              _BoutonBlanc(texte: 'Voir tout'),
                            ],
                          ),
                        ),
                        const Positioned(
                          right: 20,
                          top: 10,
                          child: Text('🛍️',
                              style: TextStyle(fontSize: 80)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top ventes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('🔥 Top Ventes',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                          onPressed: () {}, child: const Text('Voir tout')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: catalogue.length,
                      itemBuilder: (_, i) => _CarteProduiHorizontale(
                        produit: catalogue[i],
                        store: store,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoutonBlanc extends StatelessWidget {
  final String texte;
  const _BoutonBlanc({required this.texte});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(texte,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

class _CarteProduiHorizontale extends StatelessWidget {
  final Produit produit;
  final BoutiqueStore store;

  const _CarteProduiHorizontale(
      {required this.produit, required this.store});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  EcranDetailProduit(produit: produit, store: store))),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: produit.couleurPrincipale.withOpacity(0.1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Text(produit.emoji,
                    style: const TextStyle(fontSize: 48)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produit.nom,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text('${produit.prix.toStringAsFixed(2)} €',
                      style: const TextStyle(
                          color: Color(0xFF6366F1),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran Catalogue ──────────────────────────────────────────
class EcranCatalogue extends StatefulWidget {
  final BoutiqueStore store;
  const EcranCatalogue({super.key, required this.store});

  @override
  State<EcranCatalogue> createState() => _EcranCatalogueState();
}

class _EcranCatalogueState extends State<EcranCatalogue> {
  final _rechCtrl = TextEditingController();

  @override
  void dispose() {
    _rechCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.store,
      builder: (_, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8FAFC),
            title: const Text('Boutique',
                style: TextStyle(fontWeight: FontWeight.bold)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _rechCtrl,
                      onChanged: widget.store.setRecherche,
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (_, i) {
                        final cat = categories[i];
                        final active =
                            widget.store.categorieActive == cat['nom'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(
                                '${cat['emoji']} ${cat['nom']}'),
                            selected: active,
                            onSelected: (_) =>
                                widget.store.setCategorie(cat['nom']!),
                            selectedColor: const Color(0xFF6366F1),
                            labelStyle: TextStyle(
                              color: active ? Colors.white : null,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          body: widget.store.produitsFiltres.isEmpty
              ? const Center(child: Text('Aucun produit'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: widget.store.produitsFiltres.length,
                  itemBuilder: (_, i) => _CarteProduitGrille(
                    produit: widget.store.produitsFiltres[i],
                    store: widget.store,
                  ),
                ),
        );
      },
    );
  }
}

class _CarteProduitGrille extends StatelessWidget {
  final Produit produit;
  final BoutiqueStore store;

  const _CarteProduitGrille(
      {required this.produit, required this.store});

  @override
  Widget build(BuildContext context) {
    final estFavori = store.estFavori(produit.id);
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  EcranDetailProduit(produit: produit, store: store))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05), blurRadius: 8)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: produit.couleurPrincipale.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16)),
                    ),
                    child: Center(
                      child: Text(produit.emoji,
                          style: const TextStyle(fontSize: 56)),
                    ),
                  ),
                  if (produit.enPromo)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-${produit.reduction.round()}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => store.toggleFavori(produit.id),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          estFavori
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16,
                          color: estFavori
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produit.nom,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.amber, size: 12),
                      Text(' ${produit.note}',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${produit.prix.toStringAsFixed(2)} €',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6366F1))),
                      GestureDetector(
                        onTap: () => store.ajouterAuPanier(produit),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
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

// ─── Écran Détail Produit ─────────────────────────────────────
class EcranDetailProduit extends StatefulWidget {
  final Produit produit;
  final BoutiqueStore store;

  const EcranDetailProduit(
      {super.key, required this.produit, required this.store});

  @override
  State<EcranDetailProduit> createState() => _EcranDetailProduitState();
}

class _EcranDetailProduitState extends State<EcranDetailProduit> {
  String? _tailleSelectionnee;
  Color? _couleurSelectionnee;

  @override
  Widget build(BuildContext context) {
    final p = widget.produit;
    return ListenableBuilder(
      listenable: widget.store,
      builder: (_, __) {
        final estFavori = widget.store.estFavori(p.id);
        return Scaffold(
          backgroundColor: p.couleurPrincipale.withOpacity(0.05),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  estFavori ? Icons.favorite : Icons.favorite_border,
                  color: estFavori ? Colors.red : null,
                ),
                onPressed: () => widget.store.toggleFavori(p.id),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Image
                Container(
                  height: 280,
                  child: Center(
                      child: Text(p.emoji,
                          style: const TextStyle(fontSize: 120))),
                ),

                // Infos
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(p.nom,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${p.prix.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                              if (p.prixOriginal != null)
                                Text(
                                  '${p.prixOriginal!.toStringAsFixed(2)} €',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    decoration:
                                        TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(
                              5,
                              (i) => Icon(
                                    i < p.note.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 16,
                                    color: Colors.amber,
                                  )),
                          const SizedBox(width: 4),
                          Text('${p.note} (${p.nbAvis} avis)',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(p.description,
                          style: const TextStyle(
                              color: Colors.grey, height: 1.5)),

                      // Tailles
                      if (p.tailles.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text('Taille :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: p.tailles.map((t) {
                            final sel = _tailleSelectionnee == t;
                            return ChoiceChip(
                              label: Text(t),
                              selected: sel,
                              onSelected: (_) =>
                                  setState(() => _tailleSelectionnee = t),
                              selectedColor: const Color(0xFF6366F1),
                              labelStyle: TextStyle(
                                  color: sel ? Colors.white : null),
                            );
                          }).toList(),
                        ),
                      ],

                      // Couleurs
                      if (p.couleurs.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text('Couleur :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: p.couleurs.map((c) {
                            final sel = _couleurSelectionnee == c;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => setState(
                                    () => _couleurSelectionnee = c),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: c,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: sel
                                          ? Colors.black
                                          : Colors.grey.shade300,
                                      width: sel ? 3 : 1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            widget.store.ajouterAuPanier(
                              p,
                              taille: _tailleSelectionnee,
                              couleur: _couleurSelectionnee,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('✅ Ajouté au panier !'),
                                  backgroundColor: Color(0xFF10B981)),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('Ajouter au panier',
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Écran Panier ─────────────────────────────────────────────
class EcranPanier extends StatelessWidget {
  final BoutiqueStore store;
  const EcranPanier({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: Text('Panier (${store.nbArticlesPanier})'),
            backgroundColor: const Color(0xFFF8FAFC),
          ),
          body: store.panier.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🛒', style: TextStyle(fontSize: 64)),
                      SizedBox(height: 16),
                      Text('Votre panier est vide',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: store.panier.length,
                        itemBuilder: (_, i) {
                          final elem = store.panier[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: elem.produit.couleurPrincipale
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text(elem.produit.emoji,
                                        style: const TextStyle(
                                            fontSize: 28))),
                              ),
                              title: Text(elem.produit.nom,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                '${elem.sousTotal.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                    color: Color(0xFF6366F1),
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () =>
                                        store.changerQuantite(
                                            elem.produit.id, -1),
                                  ),
                                  Text('${elem.quantite}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Color(0xFF6366F1)),
                                    onPressed: () =>
                                        store.changerQuantite(
                                            elem.produit.id, 1),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                '${store.totalPanier.toStringAsFixed(2)} €',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6366F1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('🎉 Commande passée !'),
                                    backgroundColor: Color(0xFF10B981),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                              ),
                              child: const Text('Commander',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// ─── Écran Favoris ────────────────────────────────────────────
class EcranFavoris extends StatelessWidget {
  final BoutiqueStore store;
  const EcranFavoris({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) {
        final favoris = catalogue
            .where((p) => store.estFavori(p.id))
            .toList();
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8FAFC),
            title: const Text('Mes Favoris'),
          ),
          body: favoris.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('💝', style: TextStyle(fontSize: 64)),
                      SizedBox(height: 16),
                      Text('Aucun favori',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: favoris.length,
                  itemBuilder: (_, i) => _CarteProduitGrille(
                      produit: favoris[i], store: store),
                ),
        );
      },
    );
  }
}
