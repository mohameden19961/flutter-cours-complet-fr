// ============================================================
// 📘 CHAPITRE 03 — LEÇON 2
// StatefulWidget — Les Widgets Avec État
// Niveau : Débutant Flutter
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre la différence State/Widget                  ║
║   ✅ Créer et utiliser des StatefulWidgets                  ║
║   ✅ Utiliser setState() correctement                       ║
║   ✅ Gérer le cycle de vie d'un widget                      ║
║   ✅ Construire des compteurs, toggles, etc.               ║
╚══════════════════════════════════════════════════════════════╝
*/

import 'package:flutter/material.dart';

// ============================================================
// 📖 PARTIE 1 : POURQUOI STATEFULWIDGET ?
// ============================================================

/*
📖 ANALOGIE
════════════
Un StatelessWidget est comme une PHOTO :
  → Elle capture un moment figé
  → Elle ne change jamais

Un StatefulWidget est comme une VIDÉO :
  → Elle évolue dans le temps
  → Elle réagit aux événements

QUAND UTILISER STATEFULWIDGET ?
═════════════════════════════════
  ✅ Un compteur qui s'incrémente
  ✅ Un formulaire que l'utilisateur remplit
  ✅ Un switch On/Off (thème sombre/clair)
  ✅ Une liste qui se met à jour
  ✅ Une animation
  ✅ Tout ce qui CHANGE suite à une action

UN STATEFULWIDGET = 2 CLASSES
══════════════════════════════
  1. La classe Widget (configuration)  → MonWidget
  2. La classe State (état mutable)    → _MonWidgetState

Séparation volontaire : la config est constante, l'état change.
*/

// ============================================================
// 📖 PARTIE 2 : STRUCTURE D'UN STATEFULWIDGET
// ============================================================

// ─── Structure minimale ──────────────────────────────────────
class MonCompteur extends StatefulWidget {
  // ① Propriétés CONSTANTES du widget (ne changent pas)
  final String titre;

  const MonCompteur({super.key, this.titre = 'Compteur'});

  // ② Crée l'objet State associé
  @override
  State<MonCompteur> createState() => _MonCompteurState();
}

// ③ La classe State — le "cerveau" qui mémorise et change
// Commence par _ (privée) par convention
class _MonCompteurState extends State<MonCompteur> {
  // ④ Les variables d'ÉTAT (ce qui peut changer)
  int _compteur = 0;
  bool _estPositif = true;

  // ⑤ Méthode de modification d'état
  void _incrementer() {
    // setState() = "Je vais changer quelque chose → redessine le widget"
    // OBLIGATOIRE pour que l'UI se mette à jour
    setState(() {
      _compteur++;
      _estPositif = _compteur >= 0;
    });
  }

  void _decrementer() {
    setState(() {
      _compteur--;
      _estPositif = _compteur >= 0;
    });
  }

  void _reinitialiser() {
    setState(() {
      _compteur = 0;
      _estPositif = true;
    });
  }

  // ⑥ build() — utilise widget.xxx pour accéder aux props du Widget parent
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Accéder aux propriétés du Widget via widget.xxx
        Text(
          widget.titre,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24),

        // Affichage du compteur avec couleur conditionnelle
        Text(
          '$_compteur',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            color: _estPositif ? Colors.blue : Colors.red,
          ),
        ),
        const SizedBox(height: 24),

        // Boutons d'action
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'moins',
              onPressed: _decrementer,
              backgroundColor: Colors.red.shade100,
              child: const Icon(Icons.remove, color: Colors.red),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'reset',
              onPressed: _reinitialiser,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.refresh, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'plus',
              onPressed: _incrementer,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.add, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 3 : CYCLE DE VIE D'UN WIDGET
// ============================================================

class WidgetAvecCycleVie extends StatefulWidget {
  const WidgetAvecCycleVie({super.key});

  @override
  State<WidgetAvecCycleVie> createState() => _WidgetAvecCycleVieState();
}

class _WidgetAvecCycleVieState extends State<WidgetAvecCycleVie> {
  int _compteur = 0;

  // ① INITSTATE — appelé UNE SEULE FOIS quand le widget est créé
  // Idéal pour : initialiser des données, lancer des animations,
  //              ouvrir une connexion, démarrer un timer
  @override
  void initState() {
    super.initState(); // TOUJOURS appeler super.initState() en premier
    print('🟢 initState() — Widget créé');
    // Exemples d'utilisation :
    // _chargerDonnees();
    // _controller = AnimationController(vsync: this);
    // _timer = Timer.periodic(Duration(seconds: 1), (_) => _actualiser());
  }

  // ② DIDUPDATEWIDGET — appelé quand le widget parent se reconstruit
  // Utile pour réagir aux changements de propriétés
  @override
  void didUpdateWidget(WidgetAvecCycleVie oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('🔄 didUpdateWidget() — Props du parent ont changé');
  }

  // ③ BUILD — appelé à CHAQUE changement d'état (setState)
  // Ne pas faire de calculs lourds ici
  @override
  Widget build(BuildContext context) {
    print('🔵 build() — Reconstruction du widget ($_compteur)');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Compteur: $_compteur', style: const TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: () => setState(() => _compteur++),
          child: const Text('Incrémenter'),
        ),
      ],
    );
  }

  // ④ DISPOSE — appelé quand le widget est SUPPRIMÉ de l'écran
  // OBLIGATOIRE pour libérer les ressources :
  //   → Fermer les controllers
  //   → Annuler les subscriptions
  //   → Arrêter les timers
  @override
  void dispose() {
    print('🔴 dispose() — Widget détruit, libération des ressources');
    // Exemples :
    // _controller.dispose();
    // _subscription.cancel();
    // _timer.cancel();
    super.dispose(); // TOUJOURS appeler super.dispose() en dernier
  }
}

// ============================================================
// 📖 PARTIE 4 : EXEMPLES PRATIQUES
// ============================================================

// ─── Toggle Switch (On/Off) ───────────────────────────────────
class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  bool _modeSombre = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _modeSombre ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _modeSombre ? Icons.dark_mode : Icons.light_mode,
                color: _modeSombre ? Colors.amber : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                _modeSombre ? 'Mode Sombre' : 'Mode Clair',
                style: TextStyle(
                  color: _modeSombre ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Switch(
            value: _modeSombre,
            onChanged: (valeur) {
              // valeur = la NOUVELLE valeur du switch
              setState(() => _modeSombre = valeur);
            },
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

// ─── Liste interactive (ajout/suppression) ───────────────────
class ListeInteractive extends StatefulWidget {
  const ListeInteractive({super.key});

  @override
  State<ListeInteractive> createState() => _ListeInteractiveState();
}

class _ListeInteractiveState extends State<ListeInteractive> {
  // Liste d'éléments modifiable
  final List<String> _taches = ['Apprendre Flutter', 'Faire des exercices'];
  final _controleur = TextEditingController(); // Contrôle le champ texte

  void _ajouterTache() {
    final texte = _controleur.text.trim();
    if (texte.isEmpty) return;

    setState(() {
      _taches.add(texte);
      _controleur.clear(); // Vider le champ
    });
  }

  void _supprimerTache(int index) {
    setState(() => _taches.removeAt(index));
  }

  @override
  void dispose() {
    _controleur.dispose(); // ⚠️ IMPORTANT : toujours disposer les controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Champ de saisie + bouton
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controleur,
                decoration: const InputDecoration(
                  hintText: 'Nouvelle tâche...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _ajouterTache(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _ajouterTache,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Liste des tâches
        ..._taches.asMap().entries.map((entry) {
          final index = entry.key;
          final tache = entry.value;
          return ListTile(
            leading: const Icon(Icons.task_alt, color: Colors.green),
            title: Text(tache),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _supprimerTache(index),
            ),
          );
        }),

        if (_taches.isEmpty)
          const Center(
            child: Text(
              'Aucune tâche — ajoutes-en une !',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(const AppStatefulDemo());
}

class AppStatefulDemo extends StatelessWidget {
  const AppStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulWidget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EcranStateful(),
    );
  }
}

class EcranStateful extends StatelessWidget {
  const EcranStateful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compteur
            const Text(
              '1. Compteur Interactif',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const MonCompteur(titre: 'Mon Compteur'),

            const Divider(height: 48),

            // Toggle thème
            const Text(
              '2. Toggle Thème',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ToggleTheme(),

            const Divider(height: 48),

            // Liste interactive
            const Text(
              '3. Liste Interactive',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ListeInteractive(),
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
  Crée un widget StatefulWidget "BoutonLike" :
  - Un bouton cœur (Icons.favorite_border par défaut)
  - Au clic, le cœur devient rouge (Icons.favorite)
  - Un compteur de likes s'affiche à côté
  - Un deuxième clic retire le like

🟡 MOYEN :
  Crée un "SelecteurCouleur" avec 5 boutons ronds de couleurs.
  Quand tu cliques sur une couleur, le fond du Container principal
  change pour cette couleur. La couleur sélectionnée a une bordure.

🔴 DIFFICILE :
  Crée un "StopWatch" (chronomètre) avec :
  - Affichage MM:SS
  - Bouton Démarrer/Pause
  - Bouton Reset
  - Utilise Timer.periodic (dart:async) dans initState
  - N'oublie pas de disposer le timer dans dispose()

══════════════════════════════════════════════════
SOLUTIONS
══════════════════════════════════════════════════

// 🟢 SOLUTION BoutonLike :
class BoutonLike extends StatefulWidget {
  const BoutonLike({super.key});
  @override
  State<BoutonLike> createState() => _BoutonLikeState();
}

class _BoutonLikeState extends State<BoutonLike> {
  bool _aime = false;
  int _nbLikes = 0;

  void _toggleLike() {
    setState(() {
      _aime = !_aime;
      _nbLikes += _aime ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _toggleLike,
          icon: Icon(
            _aime ? Icons.favorite : Icons.favorite_border,
            color: _aime ? Colors.red : Colors.grey,
          ),
        ),
        Text('$_nbLikes', style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
*/
