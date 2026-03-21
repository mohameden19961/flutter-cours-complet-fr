// ============================================================
// 📘 CHAPITRE 09 — LEÇON 1
// JSON Parsing : Convertir les données réseau
// Niveau : Intermédiaire
// ============================================================

import 'dart:convert';
import 'package:flutter/material.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Comprendre JSON et sa structure                        ║
║   ✅ Parser JSON manuellement avec fromJson/toJson          ║
║   ✅ Gérer les types nullable et les listes                 ║
║   ✅ Comprendre json_serializable (automatique)             ║
║   ✅ Construire des modèles robustes                        ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : QU'EST-CE QUE JSON ?
// ============================================================

/*
📖 DÉFINITION
═════════════
JSON = JavaScript Object Notation
  → Format texte universel pour échanger des données
  → Utilisé par TOUTES les APIs modernes
  → Lisible par les humains ET les machines

SYNTAXE JSON
═════════════

// Objet (comme une Map en Dart)
{
  "nom": "Alice",
  "age": 28,
  "actif": true,
  "score": 9.5,
  "adresse": null,
  "hobbies": ["Flutter", "Dart", "Tennis"],
  "adresseObj": {
    "ville": "Paris",
    "pays": "France"
  }
}

CORRESPONDANCES DART ↔ JSON
══════════════════════════════
  JSON String  → Dart String
  JSON Number  → Dart int ou double
  JSON Boolean → Dart bool
  JSON null    → Dart null (nullable)
  JSON Array   → Dart List
  JSON Object  → Dart Map<String, dynamic>
*/

// ============================================================
// 📖 PARTIE 2 : PARSING MANUEL (fromJson / toJson)
// ============================================================

// ─── Modèle simple ────────────────────────────────────────────
class Produit {
  final int id;
  final String nom;
  final double prix;
  final bool disponible;
  final String? imageUrl; // Nullable = peut être absent dans le JSON
  final List<String> categories;

  const Produit({
    required this.id,
    required this.nom,
    required this.prix,
    required this.disponible,
    this.imageUrl,
    required this.categories,
  });

  // ── fromJson : Créer un Produit depuis un Map JSON ──────────
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      // int.parse pour les strings, cast as int pour les entiers
      id: json['id'] as int,
      nom: json['nom'] as String,

      // double peut venir comme int du JSON → toDouble()
      prix: (json['prix'] as num).toDouble(),

      disponible: json['disponible'] as bool,

      // Nullable : utiliser ?. et ?? pour les valeurs optionnelles
      imageUrl: json['imageUrl'] as String?,

      // Liste : cast et map pour convertir
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  // ── toJson : Convertir un Produit en Map JSON ───────────────
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prix': prix,
      'disponible': disponible,
      'imageUrl': imageUrl, // null sera inclus tel quel
      'categories': categories,
    };
  }

  @override
  String toString() => 'Produit($id, $nom, ${prix}€)';
}

// ─── Modèle imbriqué (objet dans objet) ──────────────────────
class Adresse {
  final String rue;
  final String ville;
  final String pays;
  final String codePostal;

  const Adresse({
    required this.rue,
    required this.ville,
    required this.pays,
    required this.codePostal,
  });

  factory Adresse.fromJson(Map<String, dynamic> json) {
    return Adresse(
      rue: json['rue'] as String,
      ville: json['ville'] as String,
      pays: json['pays'] as String,
      codePostal: json['codePostal'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'rue': rue,
        'ville': ville,
        'pays': pays,
        'codePostal': codePostal,
      };
}

class Client {
  final int id;
  final String nom;
  final String email;
  final Adresse adresse; // Objet imbriqué
  final List<Produit> commandes; // Liste d'objets imbriqués

  const Client({
    required this.id,
    required this.nom,
    required this.email,
    required this.adresse,
    required this.commandes,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int,
      nom: json['nom'] as String,
      email: json['email'] as String,

      // Objet imbriqué → appeler fromJson récursivement
      adresse: Adresse.fromJson(json['adresse'] as Map<String, dynamic>),

      // Liste d'objets → map chaque élément avec fromJson
      commandes: (json['commandes'] as List<dynamic>)
          .map((p) => Produit.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'email': email,
        'adresse': adresse.toJson(),
        'commandes': commandes.map((p) => p.toJson()).toList(),
      };
}

// ============================================================
// 📖 PARTIE 3 : PARSE DEPUIS STRING JSON
// ============================================================

void exempleParsingComplet() {
  // JSON reçu d'une API (String)
  const jsonString = '''
  {
    "id": 1,
    "nom": "Alice Martin",
    "email": "alice@flutter.dev",
    "adresse": {
      "rue": "12 rue de la Paix",
      "ville": "Paris",
      "pays": "France",
      "codePostal": "75001"
    },
    "commandes": [
      {
        "id": 101,
        "nom": "Cours Flutter",
        "prix": 29.99,
        "disponible": true,
        "categories": ["Mobile", "Développement"]
      },
      {
        "id": 102,
        "nom": "Cours Dart",
        "prix": 19.99,
        "disponible": true,
        "imageUrl": "https://dart.dev/logo.png",
        "categories": ["Langage", "Développement"]
      }
    ]
  }
  ''';

  // ① Parser le JSON string en Map
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // ② Créer l'objet Dart depuis le Map
  final client = Client.fromJson(jsonMap);

  print('Client parsé :');
  print('  Nom : ${client.nom}');
  print('  Email : ${client.email}');
  print('  Ville : ${client.adresse.ville}');
  print('  Commandes :');
  for (final commande in client.commandes) {
    print('    - ${commande.nom} (${commande.prix}€)');
  }

  // ③ Reconvertir en JSON
  final retourJson = jsonEncode(client.toJson());
  print('\nJSON encodé : ${retourJson.substring(0, 80)}...');
}

// ============================================================
// 📖 PARTIE 4 : GESTION D'ERREURS DE PARSING
// ============================================================

Produit? parseProduitsecurise(String jsonStr) {
  try {
    final json = jsonDecode(jsonStr);
    return Produit.fromJson(json);
  } on FormatException catch (e) {
    print('JSON malformé : $e');
    return null;
  } on TypeError catch (e) {
    print('Type incorrect dans le JSON : $e');
    return null;
  } catch (e) {
    print('Erreur inconnue : $e');
    return null;
  }
}

// ============================================================
// 📖 PARTIE 5 : AFFICHAGE DANS L'UI FLUTTER
// ============================================================

class EcranProduits extends StatefulWidget {
  const EcranProduits({super.key});

  @override
  State<EcranProduits> createState() => _EcranProduitsState();
}

class _EcranProduitsState extends State<EcranProduits> {
  List<Produit>? _produits;
  bool _chargement = true;
  String? _erreur;

  @override
  void initState() {
    super.initState();
    _chargerProduits();
  }

  Future<void> _chargerProduits() async {
    setState(() {
      _chargement = true;
      _erreur = null;
    });

    try {
      // Simulation d'une réponse API JSON
      await Future.delayed(const Duration(seconds: 1));
      const jsonReponse = '''[
        {
          "id": 1, "nom": "iPhone 15 Pro", "prix": 1199.99,
          "disponible": true, "categories": ["Électronique", "Mobile"],
          "imageUrl": null
        },
        {
          "id": 2, "nom": "MacBook Pro M3", "prix": 2499.99,
          "disponible": true, "categories": ["Ordinateur", "Apple"]
        },
        {
          "id": 3, "nom": "AirPods Pro", "prix": 279.99,
          "disponible": false, "categories": ["Audio", "Accessoire"]
        },
        {
          "id": 4, "nom": "Apple Watch Ultra", "prix": 849.99,
          "disponible": true, "categories": ["Montre", "Sport"]
        }
      ]''';

      final List<dynamic> liste = jsonDecode(jsonReponse);
      final produits = liste
          .map((json) => Produit.fromJson(json as Map<String, dynamic>))
          .toList();

      setState(() {
        _produits = produits;
        _chargement = false;
      });
    } catch (e) {
      setState(() {
        _erreur = 'Erreur : $e';
        _chargement = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits (JSON)'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _chargerProduits,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (_chargement) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_erreur != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_erreur!, style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: _chargerProduits,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }
        final produits = _produits!;
        return ListView.builder(
          itemCount: produits.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, i) {
            final p = produits[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      p.disponible ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(
                    p.disponible ? Icons.check : Icons.close,
                    color: p.disponible ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(p.nom,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Wrap(
                  spacing: 4,
                  children: p.categories
                      .map(
                        (c) => Chip(
                          label: Text(c, style: const TextStyle(fontSize: 10)),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${p.prix.toStringAsFixed(2)} €',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Text(
                      p.disponible ? 'En stock' : 'Épuisé',
                      style: TextStyle(
                        fontSize: 11,
                        color: p.disponible ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  // Test du parsing en console
  print('=== Test JSON Parsing ===');
  exempleParsingComplet();

  // Lancer l'app Flutter
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const EcranProduits(),
  ));
}
