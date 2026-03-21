// ============================================================
// 📘 CHAPITRE 08 — LEÇON 1
// API HTTP : Communiquer avec les serveurs
// Niveau : Intermédiaire → Avancé
// ============================================================

import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; // pubspec: http: ^1.1.0

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre les requêtes HTTP (GET, POST, PUT, DELETE)  ║
║   ✅ Utiliser le package http                               ║
║   ✅ Parser les réponses JSON                               ║
║   ✅ Gérer les états (chargement/succès/erreur)             ║
║   ✅ Afficher des données depuis une vraie API              ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : COMPRENDRE HTTP
// ============================================================

/*
📖 ANALOGIE
════════════
Une requête HTTP = une commande dans un restaurant :
  → Tu (l'app) = le client
  → L'API = le serveur du restaurant
  → La requête = ta commande
  → La réponse = le plat que tu reçois

LES VERBES HTTP
════════════════
  GET    → Lire des données       (obtenir la liste des plats)
  POST   → Créer des données      (passer une commande)
  PUT    → Modifier des données   (changer ta commande)
  PATCH  → Modifier partiellement (changer juste la quantité)
  DELETE → Supprimer des données  (annuler la commande)

LES CODES DE RÉPONSE
═════════════════════
  200 → OK ✅
  201 → Créé ✅
  400 → Mauvaise requête ❌ (erreur du client)
  401 → Non autorisé ❌ (connexion requise)
  403 → Interdit ❌ (pas les droits)
  404 → Introuvable ❌ (ressource inexistante)
  500 → Erreur serveur ❌ (problème côté serveur)

SETUP PUBSPEC.YAML
═══════════════════
  dependencies:
    http: ^1.1.0

Pour Android, ajouter dans android/app/src/main/AndroidManifest.xml :
  <uses-permission android:name="android.permission.INTERNET"/>
*/

// ============================================================
// 📖 PARTIE 2 : MODÈLE DE DONNÉES
// ============================================================

// Modèle Post (correspond à l'API jsonplaceholder)
class Post {
  final int id;
  final int userId;
  final String titre;
  final String corps;

  const Post({
    required this.id,
    required this.userId,
    required this.titre,
    required this.corps,
  });

  // Créer depuis JSON (fromJson)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      titre: json['title'] as String,
      corps: json['body'] as String,
    );
  }

  // Convertir en JSON (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': titre,
      'body': corps,
    };
  }

  @override
  String toString() => 'Post(id: $id, titre: $titre)';
}

// Modèle Utilisateur
class Utilisateur {
  final int id;
  final String nom;
  final String email;
  final String telephone;
  final String site;

  const Utilisateur({
    required this.id,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.site,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'] as int,
      nom: json['name'] as String,
      email: json['email'] as String,
      telephone: json['phone'] as String,
      site: json['website'] as String,
    );
  }
}

// ============================================================
// 📖 PARTIE 3 : SERVICE HTTP (sans le package pour l'exemple)
// ============================================================

/*
Dans un vrai projet, voici comment utiliser le package http :

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // ─── GET — Récupérer une liste ───────────────────────────
  static Future<List<Post>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token', // Pour les APIs authentifiées
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Erreur ${response.statusCode}: ${response.body}');
    }
  }

  // ─── GET — Récupérer un élément ──────────────────────────
  static Future<Post> getPost(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Post $id introuvable');
    }
  }

  // ─── POST — Créer un élément ─────────────────────────────
  static Future<Post> creerPost(String titre, String corps) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': titre,
        'body': corps,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur de création');
    }
  }

  // ─── PUT — Modifier un élément ───────────────────────────
  static Future<Post> modifierPost(int id, String titre) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': titre}),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur de modification');
    }
  }

  // ─── DELETE — Supprimer un élément ───────────────────────
  static Future<void> supprimerPost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erreur de suppression');
    }
  }
}
*/

// ============================================================
// 📖 PARTIE 4 : SIMULATION DE SERVICE API (sans dépendances)
// ============================================================

// Service simulé (pour l'exemple sans http installé)
class ApiServiceSimule {
  // Simule un délai réseau
  static Future<void> _delaiSimule() =>
      Future.delayed(const Duration(milliseconds: 800));

  static Future<List<Post>> getPosts() async {
    await _delaiSimule();

    // Données simulées (dans un vrai projet, viennent de l'API)
    return [
      const Post(
        id: 1,
        userId: 1,
        titre: 'Introduction à Flutter',
        corps: 'Flutter est un framework développé par Google...',
      ),
      const Post(
        id: 2,
        userId: 1,
        titre: 'Les Widgets Flutter',
        corps: 'En Flutter, tout est un widget. Les widgets sont...',
      ),
      const Post(
        id: 3,
        userId: 2,
        titre: 'State Management',
        corps: 'Gérer l\'état d\'une application Flutter peut...',
      ),
      const Post(
        id: 4,
        userId: 2,
        titre: 'Navigation et Routes',
        corps: 'La navigation en Flutter utilise le concept de pile...',
      ),
      const Post(
        id: 5,
        userId: 3,
        titre: 'Formulaires et Validation',
        corps: 'Les formulaires sont essentiels dans toute app...',
      ),
    ];
  }

  static Future<Post> getPost(int id) async {
    await _delaiSimule();
    final posts = await getPosts();
    return posts.firstWhere((p) => p.id == id);
  }

  static Future<Post> creerPost(String titre, String corps) async {
    await _delaiSimule();
    return Post(
      id: 99,
      userId: 1,
      titre: titre,
      corps: corps,
    );
  }
}

// ============================================================
// 📖 PARTIE 5 : GESTION DES ÉTATS (Loading/Success/Error)
// ============================================================

// Pattern "AsyncState" pour gérer les états d'une requête
sealed class AsyncState<T> {
  const AsyncState();
}

class StateInitial<T> extends AsyncState<T> {
  const StateInitial();
}

class StateChargement<T> extends AsyncState<T> {
  const StateChargement();
}

class StateSucces<T> extends AsyncState<T> {
  final T donnees;
  const StateSucces(this.donnees);
}

class StateErreur<T> extends AsyncState<T> {
  final String message;
  const StateErreur(this.message);
}

// ─── Écran liste des posts ────────────────────────────────────
class EcranListePosts extends StatefulWidget {
  const EcranListePosts({super.key});

  @override
  State<EcranListePosts> createState() => _EcranListePostsState();
}

class _EcranListePostsState extends State<EcranListePosts> {
  AsyncState<List<Post>> _etat = const StateInitial();

  @override
  void initState() {
    super.initState();
    _chargerPosts();
  }

  Future<void> _chargerPosts() async {
    setState(() => _etat = const StateChargement());

    try {
      final posts = await ApiServiceSimule.getPosts();
      setState(() => _etat = StateSucces(posts));
    } catch (e) {
      setState(() => _etat = StateErreur('Impossible de charger les posts: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts (API)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _chargerPosts,
          ),
        ],
      ),
      body: switch (_etat) {
        // ─── État initial ──────────────────────────────────
        StateInitial() => const Center(
            child: Text('Appuie sur Refresh pour charger'),
          ),

        // ─── État chargement ───────────────────────────────
        StateChargement() => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Chargement des posts...'),
              ],
            ),
          ),

        // ─── État succès ───────────────────────────────────
        StateSucces(donnees: final posts) => RefreshIndicator(
            onRefresh: _chargerPosts,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        '${post.id}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                    title: Text(
                      post.titre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      post.corps,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EcranDetailPost(post: post),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        // ─── État erreur ───────────────────────────────────
        StateErreur(message: final msg) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _chargerPosts,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ),
          ),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranNouveauPost()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── Écran détail d'un post ───────────────────────────────────
class EcranDetailPost extends StatelessWidget {
  final Post post;
  const EcranDetailPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post #${post.id}')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Utilisateur #${post.userId}',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              post.titre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              post.corps,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Écran nouveau post ───────────────────────────────────────
class EcranNouveauPost extends StatefulWidget {
  const EcranNouveauPost({super.key});

  @override
  State<EcranNouveauPost> createState() => _EcranNouveauPostState();
}

class _EcranNouveauPostState extends State<EcranNouveauPost> {
  final _formKey = GlobalKey<FormState>();
  final _titreCtrl = TextEditingController();
  final _corpsCtrl = TextEditingController();
  bool _envoi = false;

  @override
  void dispose() {
    _titreCtrl.dispose();
    _corpsCtrl.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _envoi = true);
    try {
      final nouveauPost = await ApiServiceSimule.creerPost(
        _titreCtrl.text,
        _corpsCtrl.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Post #${nouveauPost.id} créé ! ✅'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur : $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau Post')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextFormField(
                controller: _titreCtrl,
                validator: (v) => v!.isEmpty ? 'Titre requis' : null,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _corpsCtrl,
                  maxLines: null,
                  expands: true,
                  validator: (v) => v!.isEmpty ? 'Contenu requis' : null,
                  decoration: const InputDecoration(
                    labelText: 'Contenu',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _envoi ? null : _envoyer,
                  child: _envoi
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Publier le Post'),
                ),
              ),
            ],
          ),
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
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const EcranListePosts(),
  ));
}
