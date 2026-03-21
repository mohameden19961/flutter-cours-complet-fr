// ============================================================
// 🏆 PROJET 2 — APPLICATION NOTES COMPLÈTE
// Niveau : Intermédiaire
// ============================================================

import 'package:flutter/material.dart';
import 'dart:math';

/*
FONCTIONNALITÉS :
  ✅ CRUD complet des notes
  ✅ Couleurs personnalisées pour chaque note
  ✅ Grille / Liste (toggle)
  ✅ Recherche en temps réel
  ✅ Épingler les notes importantes
  ✅ Date de dernière modification
  ✅ Compteur de mots
  ✅ UI style Google Keep
*/

// ============================================================
// 🗂️ MODÈLES
// ============================================================

class Note {
  final String id;
  String titre;
  String contenu;
  Color couleur;
  bool epinglee;
  final DateTime dateCreation;
  DateTime dateModification;

  Note({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.couleur,
    this.epinglee = false,
    required this.dateCreation,
    required this.dateModification,
  });

  int get nbMots =>
      contenu.trim().isEmpty ? 0 : contenu.trim().split(RegExp(r'\s+')).length;

  String get resumeDateModification {
    final diff = DateTime.now().difference(dateModification);
    if (diff.inMinutes < 1) return 'À l\'instant';
    if (diff.inHours < 1) return 'Il y a ${diff.inMinutes}min';
    if (diff.inDays < 1) return 'Il y a ${diff.inHours}h';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays}j';
    return '${dateModification.day}/${dateModification.month}/${dateModification.year}';
  }
}

// ============================================================
// 🧠 STORE
// ============================================================

class NotesStore extends ChangeNotifier {
  final List<Note> _notes = [];
  String _recherche = '';
  bool _affichageGrille = true;

  static const List<Color> couleursDisponibles = [
    Color(0xFFFFFFFF), // Blanc
    Color(0xFFF28B82), // Rouge
    Color(0xFFFBBC04), // Jaune
    Color(0xFFFFF475), // Jaune clair
    Color(0xFFCCFF90), // Vert
    Color(0xFFA8D8EA), // Bleu clair
    Color(0xFFD7AEFB), // Violet
    Color(0xFFFFCFC9), // Rose
  ];

  NotesStore() {
    // Données de démo
    final couleurs = couleursDisponibles.skip(1).toList();
    final titres = [
      'Idées de projet Flutter',
      'Liste de courses',
      'Recette pizza',
      'Objectifs du mois',
    ];
    final contenus = [
      'App météo avec animations\nApp de suivi de budget\nClone de Instagram',
      'Farine, Tomates, Mozzarella\nBasilic, Olives, Jambon\nN\'oublier pas l\'eau',
      'Pâte à pizza :\n- 500g de farine\n- 20g levure\n- eau tiède\n- sel\n\nGarniture selon envie',
      'Terminer le cours Flutter\nFaire 30min de sport\nLire 20 pages\nMéditation quotidienne',
    ];

    for (int i = 0; i < 4; i++) {
      final now = DateTime.now().subtract(Duration(hours: i * 3));
      _notes.add(Note(
        id: 'demo_$i',
        titre: titres[i],
        contenu: contenus[i],
        couleur: couleurs[i % couleurs.length],
        epinglee: i == 0,
        dateCreation: now,
        dateModification: now,
      ));
    }
  }

  List<Note> get notes => _notes;
  String get recherche => _recherche;
  bool get affichageGrille => _affichageGrille;

  List<Note> get notesFiltrees {
    final liste = _notes.where((n) {
      if (_recherche.isEmpty) return true;
      return n.titre.toLowerCase().contains(_recherche.toLowerCase()) ||
          n.contenu.toLowerCase().contains(_recherche.toLowerCase());
    }).toList();

    // Épinglées en premier
    liste.sort((a, b) {
      if (a.epinglee != b.epinglee) return a.epinglee ? -1 : 1;
      return b.dateModification.compareTo(a.dateModification);
    });

    return liste;
  }

  List<Note> get notesEpinglees =>
      notesFiltrees.where((n) => n.epinglee).toList();
  List<Note> get notesNonEpinglees =>
      notesFiltrees.where((n) => !n.epinglee).toList();

  void ajouter(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void modifier(String id, String titre, String contenu, Color couleur) {
    final i = _notes.indexWhere((n) => n.id == id);
    if (i >= 0) {
      _notes[i].titre = titre;
      _notes[i].contenu = contenu;
      _notes[i].couleur = couleur;
      _notes[i].dateModification = DateTime.now();
      notifyListeners();
    }
  }

  void supprimer(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void toggleEpingle(String id) {
    final i = _notes.indexWhere((n) => n.id == id);
    if (i >= 0) {
      _notes[i].epinglee = !_notes[i].epinglee;
      notifyListeners();
    }
  }

  void setRecherche(String r) {
    _recherche = r;
    notifyListeners();
  }

  void toggleAffichage() {
    _affichageGrille = !_affichageGrille;
    notifyListeners();
  }
}

// ============================================================
// 📱 ÉCRANS
// ============================================================

void main() => runApp(const AppNotes());

class AppNotes extends StatelessWidget {
  const AppNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final store = NotesStore();
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) => MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFBBC04),
          ),
          useMaterial3: true,
        ),
        home: EcranNotes(store: store),
      ),
    );
  }
}

class EcranNotes extends StatefulWidget {
  final NotesStore store;
  const EcranNotes({super.key, required this.store});

  @override
  State<EcranNotes> createState() => _EcranNotesState();
}

class _EcranNotesState extends State<EcranNotes> {
  final _rechercheCtrl = TextEditingController();
  bool _rechercheActive = false;

  @override
  void dispose() {
    _rechercheCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.store,
      builder: (_, __) {
        final store = widget.store;
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            elevation: 0,
            title: _rechercheActive
                ? TextField(
                    controller: _rechercheCtrl,
                    autofocus: true,
                    onChanged: store.setRecherche,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher dans les notes...',
                      border: InputBorder.none,
                    ),
                  )
                : const Text(
                    'Notes',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
            actions: [
              IconButton(
                icon: Icon(
                    _rechercheActive ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _rechercheActive = !_rechercheActive;
                    if (!_rechercheActive) {
                      _rechercheCtrl.clear();
                      store.setRecherche('');
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(store.affichageGrille
                    ? Icons.view_list
                    : Icons.grid_view),
                onPressed: store.toggleAffichage,
              ),
            ],
          ),
          body: _CorpsNotes(store: store),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFBBC04),
            onPressed: () => _ouvrirEditeur(context, store),
            child: const Icon(Icons.add, color: Colors.black),
          ),
        );
      },
    );
  }

  void _ouvrirEditeur(BuildContext context, NotesStore store,
      [Note? note]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EcranEditeurNote(store: store, note: note),
      ),
    );
  }
}

class _CorpsNotes extends StatelessWidget {
  final NotesStore store;
  const _CorpsNotes({required this.store});

  @override
  Widget build(BuildContext context) {
    if (store.notes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Aucune note\nAppuie sur + pour créer',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (store.notesEpinglees.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('📌 ÉPINGLÉES',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1)),
            ),
            _GrilleNotes(
                notes: store.notesEpinglees,
                store: store,
                grille: store.affichageGrille),
            if (store.notesNonEpinglees.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text('AUTRES',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1)),
              ),
            ],
          ],
          if (store.notesNonEpinglees.isNotEmpty)
            _GrilleNotes(
                notes: store.notesNonEpinglees,
                store: store,
                grille: store.affichageGrille),
        ],
      ),
    );
  }
}

class _GrilleNotes extends StatelessWidget {
  final List<Note> notes;
  final NotesStore store;
  final bool grille;

  const _GrilleNotes({
    required this.notes,
    required this.store,
    required this.grille,
  });

  @override
  Widget build(BuildContext context) {
    if (!grille) {
      return Column(
        children: notes
            .map((n) => _CarteNote(
                note: n,
                store: store,
                grille: false))
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: notes.length,
      itemBuilder: (_, i) =>
          _CarteNote(note: notes[i], store: store, grille: true),
    );
  }
}

class _CarteNote extends StatelessWidget {
  final Note note;
  final NotesStore store;
  final bool grille;

  const _CarteNote({
    required this.note,
    required this.store,
    required this.grille,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EcranEditeurNote(store: store, note: note),
        ),
      ),
      onLongPress: () => _menuContextuel(context),
      child: Container(
        margin: grille
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: note.couleur,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.titre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (note.epinglee)
                  const Icon(Icons.push_pin, size: 14),
              ],
            ),
            if (note.contenu.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                note.contenu,
                style: const TextStyle(fontSize: 13, height: 1.4),
                maxLines: grille ? 6 : 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const Spacer(),
            Text(
              note.resumeDateModification,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  void _menuContextuel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              note.epinglee ? Icons.push_pin_outlined : Icons.push_pin,
            ),
            title:
                Text(note.epinglee ? 'Désépingler' : 'Épingler'),
            onTap: () {
              store.toggleEpingle(note.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Supprimer',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              store.supprimer(note.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Éditeur de note ─────────────────────────────────────────
class EcranEditeurNote extends StatefulWidget {
  final NotesStore store;
  final Note? note;

  const EcranEditeurNote({super.key, required this.store, this.note});

  @override
  State<EcranEditeurNote> createState() => _EcranEditeurNoteState();
}

class _EcranEditeurNoteState extends State<EcranEditeurNote> {
  late final _titreCtrl =
      TextEditingController(text: widget.note?.titre ?? '');
  late final _contenuCtrl =
      TextEditingController(text: widget.note?.contenu ?? '');
  late Color _couleur =
      widget.note?.couleur ?? NotesStore.couleursDisponibles.first;

  bool get _estModification => widget.note != null;
  bool _aDesModifications = false;

  @override
  void initState() {
    super.initState();
    _titreCtrl.addListener(_marquerModification);
    _contenuCtrl.addListener(_marquerModification);
  }

  void _marquerModification() => _aDesModifications = true;

  @override
  void dispose() {
    _titreCtrl.dispose();
    _contenuCtrl.dispose();
    super.dispose();
  }

  void _sauvegarder() {
    if (!_aDesModifications) return;
    final titre = _titreCtrl.text.trim();
    final contenu = _contenuCtrl.text.trim();

    if (titre.isEmpty && contenu.isEmpty) {
      if (_estModification) widget.store.supprimer(widget.note!.id);
      return;
    }

    if (_estModification) {
      widget.store.modifier(widget.note!.id, titre, contenu, _couleur);
    } else {
      widget.store.ajouter(Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titre: titre.isNotEmpty ? titre : 'Sans titre',
        contenu: contenu,
        couleur: _couleur,
        dateCreation: DateTime.now(),
        dateModification: DateTime.now(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _couleur,
      appBar: AppBar(
        backgroundColor: _couleur,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _sauvegarder();
            Navigator.pop(context);
          },
        ),
        actions: [
          // Compteur de mots
          Center(
            child: ValueListenableBuilder(
              valueListenable: _contenuCtrl,
              builder: (_, val, __) {
                final mots = val.text.trim().isEmpty
                    ? 0
                    : val.text.trim().split(RegExp(r'\s+')).length;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '$mots mot${mots > 1 ? 's' : ''}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                );
              },
            ),
          ),
          // Sélecteur de couleur
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: _selectionnerCouleur,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _titreCtrl,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Titre',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _contenuCtrl,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                      decoration: const InputDecoration(
                        hintText: 'Note...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black38),
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

  void _selectionnerCouleur() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Couleur de la note',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: NotesStore.couleursDisponibles.map((c) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _couleur = c);
                    _aDesModifications = true;
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _couleur == c
                            ? Colors.black
                            : Colors.black.withOpacity(0.2),
                        width: _couleur == c ? 3 : 1,
                      ),
                    ),
                    child: _couleur == c
                        ? const Icon(Icons.check, size: 16)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
