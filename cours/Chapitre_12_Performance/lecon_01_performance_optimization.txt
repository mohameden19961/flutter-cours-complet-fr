// ============================================================
// 📘 CHAPITRE 12 — LEÇON 1
// Performance Flutter : Optimisation Avancée
// Niveau : Avancé / Expert
// ============================================================

import 'package:flutter/material.dart';
import 'dart:async';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre le rendering pipeline Flutter               ║
║   ✅ Éviter les rebuilds inutiles                           ║
║   ✅ Optimiser les listes avec ListView.builder             ║
║   ✅ Utiliser const, RepaintBoundary, cache                 ║
║   ✅ Profiler avec DevTools Flutter                         ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : COMPRENDRE LE REBUILD
// ============================================================

/*
🔁 COMMENT FLUTTER REDESSINE ?
════════════════════════════════
Quand setState() est appelé, Flutter :
  1. Marque le widget "dirty" (à redessiner)
  2. Appelle build() sur ce widget ET SES ENFANTS
  3. Compare avec l'ancienne version (diffing)
  4. Ne met à jour que ce qui a changé dans le DOM

PROBLÈME :
  Si setState() est appelé dans un widget parent,
  TOUS les widgets enfants se rebuild, même s'ils n'ont
  pas changé → Performance dégradée

SOLUTION :
  1. Utiliser const pour les widgets statiques
  2. Déplacer l'état le plus bas possible dans l'arbre
  3. Utiliser ValueNotifier / Provider / Riverpod
*/

// ─── MAUVAIS : rebuild de toute la liste ─────────────────────
class MauvaisExemple extends StatefulWidget {
  const MauvaisExemple({super.key});

  @override
  State<MauvaisExemple> createState() => _MauvaisExempleState();
}

class _MauvaisExempleState extends State<MauvaisExemple> {
  int _compteur = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ce compteur change
        Text('Compteur: $_compteur'),
        ElevatedButton(
          onPressed: () => setState(() => _compteur++),
          child: const Text('+'),
        ),
        // ⚠️ MAUVAIS : cette liste se rebuild ENTIÈRE à chaque click
        // même si les données n'ont pas changé
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, i) => _ElementListe(index: i),
        ),
      ],
    );
  }
}

class _ElementListe extends StatelessWidget {
  final int index;
  const _ElementListe({required this.index});

  @override
  Widget build(BuildContext context) {
    // print('Rebuild élément $index'); // Décommente pour voir les rebuilds
    return ListTile(title: Text('Élément $index'));
  }
}

// ─── BON : isoler l'état au minimum ──────────────────────────
class BonExemple extends StatelessWidget {
  const BonExemple({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Seul ce widget se rebuild quand le compteur change
        const _CompteurIsole(),
        // Cette liste ne se rebuild JAMAIS (const + widgets const)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, i) => _ElementListeConst(index: i),
        ),
      ],
    );
  }
}

class _CompteurIsole extends StatefulWidget {
  const _CompteurIsole();

  @override
  State<_CompteurIsole> createState() => _CompteurIsoleState();
}

class _CompteurIsoleState extends State<_CompteurIsole> {
  int _compteur = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Compteur: $_compteur'),
        IconButton(
          onPressed: () => setState(() => _compteur++),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

// const = ce widget ne se rebuild JAMAIS si les props ne changent pas
class _ElementListeConst extends StatelessWidget {
  final int index;
  const _ElementListeConst({required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('Élément $index'));
  }
}

// ============================================================
// 📖 PARTIE 2 : OPTIMISATIONS CLÉS
// ============================================================

/*
1. TOUJOURS UTILISER const QUAND POSSIBLE
══════════════════════════════════════════

  // ❌ Mauvais — recréé à chaque build()
  Text('Titre', style: TextStyle(fontSize: 20))

  // ✅ Bon — créé une seule fois, jamais recréé
  const Text('Titre', style: TextStyle(fontSize: 20))

  // ❌ Mauvais
  SizedBox(height: 16)

  // ✅ Bon
  const SizedBox(height: 16)

2. LISTVIEW.BUILDER PLUTÔT QUE LISTVIEW
════════════════════════════════════════
  // ❌ Mauvais — crée TOUS les widgets d'un coup
  ListView(
    children: items.map((i) => MonWidget(item: i)).toList(),
  )

  // ✅ Bon — crée seulement les widgets VISIBLES
  ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, i) => MonWidget(item: items[i]),
  )

3. REPAINTBOUNDARY — Isoler les zones qui se redessinenet
══════════════════════════════════════════════════════════
  // Utile pour : animations, Canvas personnalisés
  RepaintBoundary(
    child: MonAnimationComplexe(),
  )

4. ÉVITER LES FONCTIONS DANS ONCREATED
════════════════════════════════════════
  // ❌ Mauvais — crée une nouvelle fonction à chaque rebuild
  ElevatedButton(
    onPressed: () => faireQuelqueChose(), // Nouvelle lambda !
    child: ...
  )

  // ✅ Bon — référence à une méthode existante
  ElevatedButton(
    onPressed: faireQuelqueChose, // Même référence
    child: ...
  )

5. IMAGECACHE ET CACHEDNETWORKIMAGE
═════════════════════════════════════
  // ❌ Mauvais — re-télécharge à chaque rebuild
  Image.network(url)

  // ✅ Bon (avec le package cached_network_image)
  CachedNetworkImage(imageUrl: url)
*/

// ============================================================
// 📖 PARTIE 3 : LAZY LOADING ET PAGINATION
// ============================================================

class ListeAvecPagination extends StatefulWidget {
  const ListeAvecPagination({super.key});

  @override
  State<ListeAvecPagination> createState() => _ListeAvecPaginationState();
}

class _ListeAvecPaginationState extends State<ListeAvecPagination> {
  final List<String> _elements = [];
  final _scrollController = ScrollController();
  bool _chargement = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _chargerPage();

    // Écouter le scroll pour charger plus
    _scrollController.addListener(_ecouterScroll);
  }

  void _ecouterScroll() {
    // Si on est à 80% du scroll → charger la page suivante
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!_chargement) _chargerPage();
    }
  }

  Future<void> _chargerPage() async {
    if (_chargement) return;

    setState(() => _chargement = true);
    await Future.delayed(const Duration(milliseconds: 800));

    final nouveaux = List.generate(
      20,
      (i) => 'Élément ${_page * 20 + i + 1}',
    );

    setState(() {
      _elements.addAll(nouveaux);
      _page++;
      _chargement = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ⚠️ Toujours disposer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination (${_elements.length} éléments)'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _elements.length + (_chargement ? 1 : 0),
        itemBuilder: (context, i) {
          // Dernier élément = indicateur de chargement
          if (i == _elements.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text(_elements[i]),
          );
        },
      ),
    );
  }
}

// ============================================================
// 📖 PARTIE 4 : DEBOUNCING ET THROTTLING
// ============================================================

class RechercheOptimisee extends StatefulWidget {
  const RechercheOptimisee({super.key});

  @override
  State<RechercheOptimisee> createState() => _RechercheOptimiseeState();
}

class _RechercheOptimiseeState extends State<RechercheOptimisee> {
  final _ctrl = TextEditingController();
  Timer? _debounce;
  List<String> _resultats = [];
  bool _chargement = false;

  // Liste simulée de données
  final List<String> _toutesLesDonnees = [
    'Flutter', 'Dart', 'Firebase', 'Android', 'iOS',
    'React Native', 'Swift', 'Kotlin', 'Java', 'Python',
    'JavaScript', 'TypeScript', 'Node.js', 'Vue.js', 'Angular',
  ];

  void _onChangement(String texte) {
    // DEBOUNCING : attendre 300ms d'inactivité avant de chercher
    // Évite une requête à CHAQUE touche tapée
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _rechercher(texte);
    });
  }

  Future<void> _rechercher(String texte) async {
    if (texte.isEmpty) {
      setState(() => _resultats = []);
      return;
    }

    setState(() => _chargement = true);

    // Simulation d'une requête API
    await Future.delayed(const Duration(milliseconds: 200));

    final resultats = _toutesLesDonnees
        .where((d) => d.toLowerCase().contains(texte.toLowerCase()))
        .toList();

    setState(() {
      _resultats = resultats;
      _chargement = false;
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _debounce?.cancel(); // ⚠️ Annuler le timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _ctrl,
          onChanged: _onChangement,
          decoration: InputDecoration(
            hintText: 'Rechercher... (debounce 300ms)',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _chargement
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        if (_resultats.isEmpty && _ctrl.text.isNotEmpty && !_chargement)
          const Text('Aucun résultat', style: TextStyle(color: Colors.grey))
        else
          ...(_resultats.map(
            (r) => ListTile(
              title: Text(r),
              leading: const Icon(Icons.code, color: Colors.blue),
            ),
          )),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 5 : CHECKLIST PERFORMANCE
// ============================================================

/*
✅ CHECKLIST PERFORMANCE FLUTTER
══════════════════════════════════

BUILD
──────
[ ] Utiliser const partout où c'est possible
[ ] setState() seulement dans le widget qui en a besoin
[ ] Pas de calculs lourds dans build()
[ ] Extraire les widgets en classes séparées

LISTES
───────
[ ] Toujours ListView.builder (pas ListView)
[ ] Spécifier itemCount
[ ] Utiliser const pour les items statiques
[ ] Pagination pour les longues listes

IMAGES
───────
[ ] CachedNetworkImage (package)
[ ] Spécifier width et height des images
[ ] Utiliser fit: BoxFit.cover pour éviter le recalcul
[ ] Précacher les images avec precacheImage()

ANIMATIONS
───────────
[ ] RepaintBoundary autour des animations complexes
[ ] Utiliser AnimationController.dispose()
[ ] Préférer les animations CSS-like (AnimatedContainer)

RÉSEAU
───────
[ ] Débouncer les recherches (300ms minimum)
[ ] Mettre en cache les réponses API
[ ] Gérer les erreurs et les timeouts
[ ] Afficher des skeletons pendant le chargement

MÉMOIRE
────────
[ ] dispose() sur TOUS les controllers/subscriptions
[ ] Libérer les ressources (timers, streams, blocs)
[ ] Éviter les closures qui retiennent des références

PROFILING
──────────
[ ] flutter run --profile (mode profil)
[ ] Flutter DevTools → Performance tab
[ ] Chercher les "jank" (images qui prennent >16ms)
[ ] Widget Inspector → check unnecessary rebuilds
*/

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(MaterialApp(
    title: 'Performance Flutter',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Optimisations Performance'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. Recherche avec Debounce',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const RechercheOptimisee(),
            const Divider(height: 48),
            const Text('2. Pagination Lazy Loading',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: Card(
                child: Navigator(
                  onGenerateRoute: (_) => MaterialPageRoute(
                    builder: (_) => const ListeAvecPagination(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
