// ============================================================
// 📘 CHAPITRE 10 — LEÇON 1
// Local Storage : Sauvegarder des données localement
// Niveau : Intermédiaire → Avancé
// ============================================================

import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:hive_flutter/hive_flutter.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Connaître les options de stockage local                ║
║   ✅ Utiliser SharedPreferences pour les préférences        ║
║   ✅ Comprendre SQLite pour les données structurées         ║
║   ✅ Découvrir Hive (NoSQL rapide)                          ║
║   ✅ Implémenter un système de sauvegarde complet           ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : COMPARAISON DES OPTIONS
// ============================================================

/*
OPTIONS DE STOCKAGE LOCAL EN FLUTTER
══════════════════════════════════════

┌────────────────────┬──────────────┬──────────────┬──────────────┐
│ Option             │ SharedPrefs  │ SQLite       │ Hive         │
├────────────────────┼──────────────┼──────────────┼──────────────┤
│ Type de données    │ Simples      │ Structurées  │ Objets       │
│ Performances       │ Rapide       │ Bon          │ Très rapide  │
│ Requêtes complexes │ ❌           │ ✅ SQL       │ Limité       │
│ Facile à utiliser  │ ✅ Très      │ Moyen        │ ✅           │
│ Chiffrement        │ ❌           │ flutter_secure│ ✅ HiveAES  │
│ Cas d'usage        │ Préférences  │ Données app  │ Cache, prefs │
└────────────────────┴──────────────┴──────────────┴──────────────┘

RÈGLE D'OR :
  → Thème, langue, token → SharedPreferences
  → Contacts, tâches, messages → SQLite (sqflite)
  → Cache d'images, données offline → Hive
  → Données sensibles → flutter_secure_storage

PUBSPEC.YAML :
  dependencies:
    shared_preferences: ^2.2.0
    sqflite: ^2.3.0
    path: ^1.8.3
    hive_flutter: ^1.1.0
*/

// ============================================================
// 📖 PARTIE 2 : SHAREDPREFERENCES
// ============================================================

/*
SHARED PREFERENCES = stockage clé-valeur simple
  → Parfait pour : thème, langue, token, paramètres utilisateur
  → Types supportés : String, int, double, bool, List<String>
  → ASYNCHRONE : toutes les opérations sont des Futures

UTILISATION RÉELLE :
════════════════════
class PrefsService {
  static SharedPreferences? _prefs;

  // Initialiser (dans main() avant runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── Thème ────────────────────────────────────────────────
  static bool get modeSombre => _prefs?.getBool('darkMode') ?? false;
  static Future<void> setModeSombre(bool val) async =>
    await _prefs?.setBool('darkMode', val);

  // ─── Langue ───────────────────────────────────────────────
  static String get langue => _prefs?.getString('langue') ?? 'fr';
  static Future<void> setLangue(String val) async =>
    await _prefs?.setString('langue', val);

  // ─── Token de connexion ───────────────────────────────────
  static String? get token => _prefs?.getString('authToken');
  static Future<void> setToken(String token) async =>
    await _prefs?.setString('authToken', token);
  static Future<void> supprimerToken() async =>
    await _prefs?.remove('authToken');

  // ─── Objet complexe (sérialisé en JSON) ──────────────────
  static Map<String, dynamic>? get profil {
    final json = _prefs?.getString('profil');
    return json != null ? jsonDecode(json) : null;
  }
  static Future<void> setProfil(Map<String, dynamic> profil) async =>
    await _prefs?.setString('profil', jsonEncode(profil));

  // ─── Réinitialiser tout ───────────────────────────────────
  static Future<void> vider() async => await _prefs?.clear();
}
*/

// ============================================================
// 📖 PARTIE 3 : SQLITE AVEC SQFLITE
// ============================================================

/*
SQLITE = base de données relationnelle complète
  → Données structurées en tables
  → Requêtes SQL complètes
  → Parfait pour : tâches, contacts, messages, historique

IMPLÉMENTATION SQFLITE :
═════════════════════════

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static const String _dbName = 'app_database.db';
  static const int _version = 1;

  // Singleton — une seule connexion à la base
  static Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _version,
      onCreate: _creerTables,
      onUpgrade: _migrerTables,
    );
  }

  // Créer les tables à la première ouverture
  static Future<void> _creerTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE taches (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        description TEXT,
        terminee INTEGER DEFAULT 0,
        priorite TEXT DEFAULT 'normale',
        dateCreation TEXT NOT NULL,
        dateEcheance TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL UNIQUE,
        couleur TEXT NOT NULL
      )
    ''');
  }

  static Future<void> _migrerTables(
      Database db, int ancienneVersion, int nouvelleVersion) async {
    // Ajouter les nouvelles colonnes lors d'une mise à jour
    if (ancienneVersion < 2) {
      await db.execute('ALTER TABLE taches ADD COLUMN notes TEXT');
    }
  }

  // ─── CRUD Tâches ──────────────────────────────────────────

  // CREATE
  static Future<int> insererTache(TacheDB tache) async {
    final db = await database;
    return db.insert(
      'taches',
      tache.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ — Toutes les tâches
  static Future<List<TacheDB>> getTaches() async {
    final db = await database;
    final maps = await db.query(
      'taches',
      orderBy: 'dateCreation DESC',
    );
    return maps.map(TacheDB.fromMap).toList();
  }

  // READ — Tâches filtrées
  static Future<List<TacheDB>> getTachesTerminees() async {
    final db = await database;
    final maps = await db.query(
      'taches',
      where: 'terminee = ?',
      whereArgs: [1],
    );
    return maps.map(TacheDB.fromMap).toList();
  }

  // READ — Recherche
  static Future<List<TacheDB>> rechercherTaches(String terme) async {
    final db = await database;
    final maps = await db.rawQuery(
      'SELECT * FROM taches WHERE titre LIKE ? OR description LIKE ?',
      ['%$terme%', '%$terme%'],
    );
    return maps.map(TacheDB.fromMap).toList();
  }

  // UPDATE
  static Future<int> mettreAJourTache(TacheDB tache) async {
    final db = await database;
    return db.update(
      'taches',
      tache.toMap(),
      where: 'id = ?',
      whereArgs: [tache.id],
    );
  }

  // DELETE
  static Future<int> supprimerTache(int id) async {
    final db = await database;
    return db.delete('taches', where: 'id = ?', whereArgs: [id]);
  }

  // DELETE ALL
  static Future<void> viderTaches() async {
    final db = await database;
    await db.delete('taches');
  }
}
*/

// ============================================================
// 📖 PARTIE 4 : MODÈLE POUR SQLITE
// ============================================================

class TacheDB {
  final int? id;
  final String titre;
  final String? description;
  final bool terminee;
  final String priorite;
  final DateTime dateCreation;
  final DateTime? dateEcheance;

  const TacheDB({
    this.id,
    required this.titre,
    this.description,
    this.terminee = false,
    this.priorite = 'normale',
    required this.dateCreation,
    this.dateEcheance,
  });

  // Convertir en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titre': titre,
      'description': description,
      'terminee': terminee ? 1 : 0, // SQLite n'a pas de bool
      'priorite': priorite,
      'dateCreation': dateCreation.toIso8601String(),
      'dateEcheance': dateEcheance?.toIso8601String(),
    };
  }

  // Créer depuis un Map SQLite
  factory TacheDB.fromMap(Map<String, dynamic> map) {
    return TacheDB(
      id: map['id'] as int?,
      titre: map['titre'] as String,
      description: map['description'] as String?,
      terminee: (map['terminee'] as int) == 1,
      priorite: map['priorite'] as String,
      dateCreation: DateTime.parse(map['dateCreation'] as String),
      dateEcheance: map['dateEcheance'] != null
          ? DateTime.parse(map['dateEcheance'] as String)
          : null,
    );
  }

  // Copier avec modifications (immuable)
  TacheDB copyWith({
    int? id,
    String? titre,
    String? description,
    bool? terminee,
    String? priorite,
    DateTime? dateCreation,
    DateTime? dateEcheance,
  }) {
    return TacheDB(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      description: description ?? this.description,
      terminee: terminee ?? this.terminee,
      priorite: priorite ?? this.priorite,
      dateCreation: dateCreation ?? this.dateCreation,
      dateEcheance: dateEcheance ?? this.dateEcheance,
    );
  }
}

// ============================================================
// 📖 PARTIE 5 : APP DE TÂCHES AVEC ÉTAT LOCAL (SIMULÉ)
// ============================================================

class GestionnaireTachesSimule extends ChangeNotifier {
  final List<TacheDB> _taches = [];

  List<TacheDB> get taches => List.unmodifiable(_taches);
  List<TacheDB> get tachesEnCours =>
      _taches.where((t) => !t.terminee).toList();
  List<TacheDB> get tachesTerminees =>
      _taches.where((t) => t.terminee).toList();

  void ajouter(String titre, {String? description, String priorite = 'normale'}) {
    _taches.insert(
      0,
      TacheDB(
        titre: titre,
        description: description,
        priorite: priorite,
        dateCreation: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void toggleTerminee(int index) {
    final tache = _taches[index];
    _taches[index] = tache.copyWith(terminee: !tache.terminee);
    notifyListeners();
  }

  void supprimer(int index) {
    _taches.removeAt(index);
    notifyListeners();
  }
}

// ─── UI Application Tâches ───────────────────────────────────
class AppTaches extends StatefulWidget {
  const AppTaches({super.key});

  @override
  State<AppTaches> createState() => _AppTachesState();
}

class _AppTachesState extends State<AppTaches> {
  final _gestionnaire = GestionnaireTachesSimule();
  final _ctrl = TextEditingController();
  String _prioriteSelectionnee = 'normale';

  @override
  void initState() {
    super.initState();
    // Ajouter des données de démo
    _gestionnaire.ajouter('Terminer le cours Flutter', priorite: 'haute');
    _gestionnaire.ajouter('Créer une app To-Do', description: 'Projet pratique', priorite: 'normale');
    _gestionnaire.ajouter('Apprendre Provider', priorite: 'normale');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _ajouterTache() {
    if (_ctrl.text.trim().isEmpty) return;
    _gestionnaire.ajouter(_ctrl.text.trim(), priorite: _prioriteSelectionnee);
    _ctrl.clear();
    setState(() {});
  }

  Color _couleurPriorite(String p) => switch (p) {
        'haute' => Colors.red,
        'normale' => Colors.blue,
        'basse' => Colors.green,
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _gestionnaire,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mes Tâches'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    '${_gestionnaire.tachesTerminees.length}/${_gestionnaire.taches.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Barre de progression
              LinearProgressIndicator(
                value: _gestionnaire.taches.isEmpty
                    ? 0
                    : _gestionnaire.tachesTerminees.length /
                        _gestionnaire.taches.length,
                backgroundColor: Colors.grey.shade200,
                color: Colors.green,
              ),

              // Saisie nouvelle tâche
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        onSubmitted: (_) => _ajouterTache(),
                        decoration: const InputDecoration(
                          hintText: 'Nouvelle tâche...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Sélecteur de priorité
                    DropdownButton<String>(
                      value: _prioriteSelectionnee,
                      underline: Container(),
                      items: ['basse', 'normale', 'haute']
                          .map(
                            (p) => DropdownMenuItem(
                              value: p,
                              child: Row(
                                children: [
                                  Icon(Icons.flag,
                                      color: _couleurPriorite(p), size: 16),
                                  const SizedBox(width: 4),
                                  Text(p),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _prioriteSelectionnee = v!),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton.small(
                      onPressed: _ajouterTache,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),

              // Liste des tâches
              Expanded(
                child: _gestionnaire.taches.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_alt,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Aucune tâche !',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _gestionnaire.taches.length,
                        itemBuilder: (context, index) {
                          final tache = _gestionnaire.taches[index];
                          return Dismissible(
                            key: ValueKey('${tache.titre}-$index'),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => _gestionnaire.supprimer(index),
                            child: ListTile(
                              leading: Checkbox(
                                value: tache.terminee,
                                onChanged: (_) =>
                                    _gestionnaire.toggleTerminee(index),
                                activeColor: Colors.green,
                              ),
                              title: Text(
                                tache.titre,
                                style: TextStyle(
                                  decoration: tache.terminee
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: tache.terminee
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              trailing: Icon(
                                Icons.flag,
                                color: _couleurPriorite(tache.priorite),
                                size: 16,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Local Storage',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const AppTaches(),
  ));
}
