// ============================================================
// 📘 CHAPITRE 11 — LEÇON 1
// UI/UX Best Practices Flutter
// Niveau : Avancé
// ============================================================

import 'package:flutter/material.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Créer un système de thème cohérent                     ║
║   ✅ Implémenter les animations Flutter                     ║
║   ✅ Respecter les guidelines Material 3                    ║
║   ✅ Construire des UIs responsives                         ║
║   ✅ Accessibilité et bonnes pratiques                      ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : SYSTÈME DE THÈME PROFESSIONNEL
// ============================================================

class AppTheme {
  // ─── Palette de couleurs ─────────────────────────────────
  static const Color primaryColor = Color(0xFF2563EB);   // Bleu
  static const Color secondaryColor = Color(0xFF7C3AED); // Violet
  static const Color accentColor = Color(0xFF10B981);    // Vert
  static const Color errorColor = Color(0xFFEF4444);     // Rouge
  static const Color warningColor = Color(0xFFF59E0B);   // Ambre

  // ─── Thème Clair ─────────────────────────────────────────
  static ThemeData get themeLight => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        // Police globale
        fontFamily: 'Inter',

        // AppBar
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E293B),
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),

        // Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Cards
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          color: Colors.white,
        ),

        // Inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        // Typographie
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.5,
          ),
          headlineMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(fontSize: 16, height: 1.6),
          bodyMedium: TextStyle(fontSize: 14, height: 1.5),
          labelLarge: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ─── Thème Sombre ─────────────────────────────────────────
  static ThemeData get themeDark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1E293B),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}

// ============================================================
// 📖 PARTIE 2 : ANIMATIONS FLUTTER
// ============================================================

// ─── Animation ImplicitlyAnimated (la plus simple) ───────────
class AnimationImplicite extends StatefulWidget {
  const AnimationImplicite({super.key});

  @override
  State<AnimationImplicite> createState() => _AnimationImpliciteState();
}

class _AnimationImpliciteState extends State<AnimationImplicite> {
  bool _grand = false;
  bool _rouge = false;
  double _opacite = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── AnimatedContainer ───────────────────────────────
        GestureDetector(
          onTap: () => setState(() {
            _grand = !_grand;
            _rouge = !_rouge;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutBack,
            width: _grand ? 200 : 100,
            height: _grand ? 200 : 100,
            decoration: BoxDecoration(
              color: _rouge ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.circular(_grand ? 50 : 10),
              boxShadow: [
                BoxShadow(
                  color: (_rouge ? Colors.red : Colors.blue).withOpacity(0.3),
                  blurRadius: _grand ? 20 : 4,
                  offset: Offset(0, _grand ? 8 : 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                _grand ? '🎉' : '👆',
                style: TextStyle(fontSize: _grand ? 48 : 24),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ─── AnimatedOpacity ─────────────────────────────────
        AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _opacite,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Je peux disparaître !'),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => setState(() => _opacite = 0.0),
              child: const Text('Masquer'),
            ),
            TextButton(
              onPressed: () => setState(() => _opacite = 1.0),
              child: const Text('Afficher'),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── AnimatedList — Liste animée ──────────────────────────────
class ListeAnimee extends StatefulWidget {
  const ListeAnimee({super.key});

  @override
  State<ListeAnimee> createState() => _ListeAnimeeState();
}

class _ListeAnimeeState extends State<ListeAnimee> {
  final _cle = GlobalKey<AnimatedListState>();
  final List<String> _elements = ['Flutter', 'Dart', 'Firebase'];

  void _ajouter() {
    const nouveau = 'Nouvel élément';
    _elements.insert(0, nouveau);
    _cle.currentState?.insertItem(0);
  }

  void _supprimer(int index) {
    final element = _elements.removeAt(index);
    _cle.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _construireElement(element, index, animation),
      ),
    );
  }

  Widget _construireElement(String element, int index, Animation<double> anim) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(anim),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          title: Text(element),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _supprimer(index),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _ajouter,
          icon: const Icon(Icons.add),
          label: const Text('Ajouter avec animation'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: AnimatedList(
            key: _cle,
            initialItemCount: _elements.length,
            itemBuilder: (context, index, animation) =>
                _construireElement(_elements[index], index, animation),
          ),
        ),
      ],
    );
  }
}

// ─── Hero Animation — Transition entre écrans ────────────────
class EcranListeHero extends StatelessWidget {
  const EcranListeHero({super.key});

  static const List<Map<String, dynamic>> items = [
    {'tag': 'bleu', 'couleur': Colors.blue, 'titre': 'Ocean'},
    {'tag': 'rouge', 'couleur': Colors.red, 'titre': 'Feu'},
    {'tag': 'vert', 'couleur': Colors.green, 'titre': 'Forêt'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animations')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EcranDetailHero(
                  tag: item['tag'],
                  couleur: item['couleur'],
                  titre: item['titre'],
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Hero = widget qui "vole" vers le prochain écran
                  Hero(
                    tag: item['tag'],
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: item['couleur'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(item['titre'],
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EcranDetailHero extends StatelessWidget {
  final String tag;
  final Color couleur;
  final String titre;

  const EcranDetailHero({
    super.key,
    required this.tag,
    required this.couleur,
    required this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Column(
        children: [
          Hero(
            tag: tag,
            child: Container(
              width: double.infinity,
              height: 250,
              color: couleur,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              titre,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 📖 PARTIE 3 : RESPONSIVE DESIGN
// ============================================================

class LayoutResponsive extends StatelessWidget {
  const LayoutResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder donne les contraintes de l'écran parent
    return LayoutBuilder(
      builder: (context, contraintes) {
        final largeur = contraintes.maxWidth;

        // Breakpoints comme CSS
        if (largeur > 1200) {
          return const _LayoutDesktop();
        } else if (largeur > 600) {
          return const _LayoutTablet();
        } else {
          return const _LayoutMobile();
        }
      },
    );
  }
}

class _LayoutMobile extends StatelessWidget {
  const _LayoutMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          color: Colors.blue.shade100,
          child: const Center(child: Text('📱 Layout Mobile')),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (_, i) => Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(title: Text('Élément $i')),
          ),
        ),
      ],
    );
  }
}

class _LayoutTablet extends StatelessWidget {
  const _LayoutTablet();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.green.shade100,
            child: const Center(child: Text('Sidebar Tablette')),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              6,
              (i) => Card(
                margin: const EdgeInsets.all(8),
                child: Center(child: Text('Carte $i')),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LayoutDesktop extends StatelessWidget {
  const _LayoutDesktop();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
          color: Colors.grey.shade100,
          child: const Center(child: Text('🖥️ Navigation Desktop')),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              9,
              (i) => Card(
                margin: const EdgeInsets.all(8),
                child: Center(child: Text('Carte $i')),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 4 : COMPOSANTS UI PREMIUM
// ============================================================

// ─── Skeleton Loading (effet de chargement) ──────────────────
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 4,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

class CarteSkeletonDemo extends StatelessWidget {
  const CarteSkeletonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const SkeletonLoader(
              width: 60,
              height: 60,
              borderRadius: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonLoader(height: 14),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 12),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Snackbars et Dialogs stylisés ───────────────────────────
class UtilitairesUI {
  static void snackbarSucces(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static void snackbarErreur(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static Future<bool?> dialogueConfirmation(
    BuildContext context, {
    required String titre,
    required String message,
    String boutonOui = 'Confirmer',
    String boutonNon = 'Annuler',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(titre),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(boutonNon,
                style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: Text(boutonOui),
          ),
        ],
      ),
    );
  }

  static Future<void> bottomSheet(
    BuildContext context, {
    required String titre,
    required Widget contenu,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(titre,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: contenu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(MaterialApp(
    title: 'UI/UX Best Practices',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.themeLight,
    darkTheme: AppTheme.themeDark,
    themeMode: ThemeMode.system,
    home: const EcranUIUX(),
  ));
}

class EcranUIUX extends StatefulWidget {
  const EcranUIUX({super.key});

  @override
  State<EcranUIUX> createState() => _EcranUIUXState();
}

class _EcranUIUXState extends State<EcranUIUX> {
  int _section = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(['Animations', 'Responsive', 'Composants'][_section]),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => UtilitairesUI.snackbarSucces(
                context, 'Thème appliqué ! ✨'),
          ),
        ],
      ),
      body: [
        // Section Animations
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Animations Implicites',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Center(child: AnimationImplicite()),
              const Divider(height: 48),
              Text('Liste Animée',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const ListeAnimee(),
            ],
          ),
        ),
        // Section Responsive
        const LayoutResponsive(),
        // Section Composants
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Skeleton Loading',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const CarteSkeletonDemo(),
              const CarteSkeletonDemo(),
              const Divider(height: 48),
              Text('Dialogs & Snackbars',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        UtilitairesUI.snackbarSucces(context, 'Succès !'),
                    child: const Text('Snackbar Succès'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () =>
                        UtilitairesUI.snackbarErreur(context, 'Erreur !'),
                    child: const Text('Snackbar Erreur'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final ok = await UtilitairesUI.dialogueConfirmation(
                        context,
                        titre: 'Supprimer ?',
                        message: 'Cette action est irréversible.',
                      );
                      if (ok == true && context.mounted) {
                        UtilitairesUI.snackbarSucces(
                            context, 'Supprimé !');
                      }
                    },
                    child: const Text('Dialog Confirmation'),
                  ),
                  OutlinedButton(
                    onPressed: () => UtilitairesUI.bottomSheet(
                      context,
                      titre: 'Options',
                      contenu: Column(
                        children: [
                          for (final opt in [
                            'Modifier',
                            'Partager',
                            'Télécharger',
                            'Supprimer',
                          ])
                            ListTile(
                              title: Text(opt),
                              trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14),
                            ),
                        ],
                      ),
                    ),
                    child: const Text('Bottom Sheet'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ][_section],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _section,
        onDestinationSelected: (i) => setState(() => _section = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.animation), label: 'Animations'),
          NavigationDestination(
              icon: Icon(Icons.devices), label: 'Responsive'),
          NavigationDestination(
              icon: Icon(Icons.widgets), label: 'Composants'),
        ],
      ),
    );
  }
}
