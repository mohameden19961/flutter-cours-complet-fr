// ============================================================
// 📘 CHAPITRE 05 — LEÇON 1
// Navigation Flutter : Passer d'un écran à l'autre
// Niveau : Intermédiaire
// ============================================================

import 'package:flutter/material.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Naviguer avec Navigator.push/pop                       ║
║   ✅ Passer des données entre écrans                        ║
║   ✅ Récupérer des données en retour                        ║
║   ✅ Utiliser les routes nommées                            ║
║   ✅ Implémenter une BottomNavigationBar                    ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : NAVIGATION DE BASE
// ============================================================

/*
📖 ANALOGIE
════════════
La navigation Flutter = une PILE de cartes
  → push() = ajouter une carte sur la pile (aller à un écran)
  → pop()  = retirer la carte du dessus (revenir en arrière)
  → La pile s'appelle la "Navigation Stack"

DEUX FAÇONS DE NAVIGUER
═════════════════════════
  1. Navigation directe (push/pop) — Simple, sans routes
  2. Routes nommées — Plus organisé, recommandé pour les grandes apps
*/

// ─── Écran Accueil ────────────────────────────────────────────
class EcranAccueil extends StatelessWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🏠 Écran d\'Accueil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // ─── Navigation directe ──────────────────────────
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.push = aller à un nouvel écran
                // MaterialPageRoute = transition standard Material
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EcranDetails(
                      titre: 'Flutter Navigation',
                      description: 'Apprendre à naviguer entre les écrans',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Aller à l\'écran Détails'),
            ),
            const SizedBox(height: 16),

            // ─── Navigation avec données en retour ───────────
            ElevatedButton.icon(
              onPressed: () async {
                // await = attendre le résultat quand on revient
                final resultat = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EcranFormulaire(),
                  ),
                );

                // resultat contient ce que l'écran précédent a retourné
                if (resultat != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Retour : $resultat')),
                  );
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text('Formulaire (retour de données)'),
            ),
            const SizedBox(height: 16),

            // ─── Routes nommées ───────────────────────────────
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
              icon: const Icon(Icons.person),
              label: const Text('Profil (route nommée)'),
            ),
            const SizedBox(height: 16),

            // ─── Remplacer l'écran actuel ─────────────────────
            ElevatedButton.icon(
              onPressed: () {
                // pushReplacement = remplace l'écran actuel (pas de retour)
                // Utile pour : connexion → accueil (pas de retour à la connexion)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EcranSansRetour(),
                  ),
                );
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Écran sans retour (pushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran Détails (reçoit des données) ──────────────────────
class EcranDetails extends StatelessWidget {
  // Données reçues via le constructeur
  final String titre;
  final String description;

  const EcranDetails({
    super.key,
    required this.titre,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        // La flèche de retour est automatiquement ajoutée par Flutter !
        // Navigator.pop() est appelé automatiquement quand on appuie
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Retour manuel
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context), // Retour arrière
              icon: const Icon(Icons.arrow_back),
              label: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran Formulaire (retourne des données) ─────────────────
class EcranFormulaire extends StatefulWidget {
  const EcranFormulaire({super.key});

  @override
  State<EcranFormulaire> createState() => _EcranFormulaireState();
}

class _EcranFormulaireState extends State<EcranFormulaire> {
  final _controleur = TextEditingController();

  @override
  void dispose() {
    _controleur.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulaire')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controleur,
              decoration: const InputDecoration(
                labelText: 'Ton prénom',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // pop() avec une valeur = retourner des données à l'écran précédent
                Navigator.pop(context, 'Bonjour ${_controleur.text} !');
              },
              child: const Text('Valider et retourner'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran Sans Retour ────────────────────────────────────────
class EcranSansRetour extends StatelessWidget {
  const EcranSansRetour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pas de retour possible')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            const Text('Tu ne peux pas revenir en arrière !'),
            const Text('(Utile pour l\'écran de connexion)'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // popUntil = revenir jusqu'à une route précise
                // ici, on revient à la toute première route
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Revenir à l\'Accueil'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran Profil (route nommée) ──────────────────────────────
class EcranProfil extends StatelessWidget {
  const EcranProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Profil')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text('Alice Martin',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('alice@flutter.dev',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 📖 PARTIE 2 : BOTTOM NAVIGATION BAR
// ============================================================

class AppAvecNavigation extends StatefulWidget {
  const AppAvecNavigation({super.key});

  @override
  State<AppAvecNavigation> createState() => _AppAvecNavigationState();
}

class _AppAvecNavigationState extends State<AppAvecNavigation> {
  int _indexActuel = 0;

  // Les écrans correspondant à chaque onglet
  final List<Widget> _ecrans = const [
    _EcranOnglet(titre: 'Accueil', icone: Icons.home, couleur: Colors.blue),
    _EcranOnglet(titre: 'Recherche', icone: Icons.search, couleur: Colors.green),
    _EcranOnglet(titre: 'Favoris', icone: Icons.favorite, couleur: Colors.red),
    _EcranOnglet(titre: 'Profil', icone: Icons.person, couleur: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // L'écran actuellement affiché
      body: _ecrans[_indexActuel],

      // Barre de navigation en bas
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexActuel,
        onDestinationSelected: (index) {
          setState(() => _indexActuel = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _EcranOnglet extends StatelessWidget {
  final String titre;
  final IconData icone;
  final Color couleur;

  const _EcranOnglet({
    required this.titre,
    required this.icone,
    required this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 64, color: couleur),
          const SizedBox(height: 16),
          Text(
            titre,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: couleur,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL avec routes nommées
// ============================================================

void main() {
  runApp(const AppNavigation());
}

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // ─── Routes nommées ──────────────────────────────────────
      initialRoute: '/',
      routes: {
        '/': (context) => const EcranAccueil(),
        '/profil': (context) => const EcranProfil(),
        '/navigation': (context) => const AppAvecNavigation(),
      },

      // onUnknownRoute = fallback si route inconnue
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('Page "${settings.name}" introuvable')),
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
  Crée 2 écrans : EcranA et EcranB.
  EcranA a un bouton "Aller à B".
  EcranB a un bouton "Retour".

🟡 MOYEN :
  Crée une app avec BottomNavigationBar à 3 onglets :
  - Actualités (icône newspaper)
  - Bookmarks (icône bookmark)
  - Paramètres (icône settings)
  Chaque onglet affiche un écran différent avec un titre.

🔴 DIFFICILE :
  Crée un flow de "Login" → "Accueil" :
  - EcranLogin avec 2 champs (email, mot de passe)
  - Quand on valide, naviguer vers EcranAccueil avec pushReplacement
    (pour ne pas pouvoir revenir au login)
  - EcranAccueil affiche "Bienvenue [email]" et a un bouton Déconnexion
    qui revient au login avec pushReplacement aussi
*/
