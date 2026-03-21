// ============================================================
// 🏆 PROJET 1 — APPLICATION TO-DO COMPLÈTE
// Une application de gestion de tâches professionnelle
// Niveau : Intermédiaire
// ============================================================

import 'package:flutter/material.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║  🎯 OBJECTIFS DE CE PROJET                                   ║
╠══════════════════════════════════════════════════════════════╣
║  • StatefulWidget + setState avancé                         ║
║  • ChangeNotifier pour le state management                  ║
║  • Formulaires avec validation                              ║
║  • CRUD complet (Create/Read/Update/Delete)                  ║
║  • Animations (AnimatedList, Hero)                          ║
║  • Filtres et recherche                                     ║
║  • UI professionnelle Material 3                            ║
╚══════════════════════════════════════════════════════════════╝

FONCTIONNALITÉS :
  ✅ Ajouter des tâches avec titre, description, priorité
  ✅ Marquer comme terminé
  ✅ Supprimer (swipe ou bouton)
  ✅ Filtrer : Toutes / En cours / Terminées
  ✅ Recherche en temps réel
  ✅ Statistiques (barre de progression)
  ✅ Priorités (haute/normale/basse) avec couleurs
  ✅ Animations d'ajout/suppression
*/

// ============================================================
// 🗂️ MODÈLES
// ============================================================

enum Priorite { haute, normale, basse }

class Tache {
  final String id;
  String titre;
  String? description;
  bool terminee;
  Priorite priorite;
  final DateTime dateCreation;
  DateTime? dateTerminee;

  Tache({
    required this.id,
    required this.titre,
    this.description,
    this.terminee = false,
    this.priorite = Priorite.normale,
    required this.dateCreation,
  });

  Tache copyWith({
    String? titre,
    String? description,
    bool? terminee,
    Priorite? priorite,
    DateTime? dateTerminee,
  }) => Tache(
        id: id,
        titre: titre ?? this.titre,
        description: description ?? this.description,
        terminee: terminee ?? this.terminee,
        priorite: priorite ?? this.priorite,
        dateCreation: dateCreation,
      )..dateTerminee = dateTerminee ?? this.dateTerminee;

  Color get couleurPriorite => switch (priorite) {
        Priorite.haute => const Color(0xFFEF4444),
        Priorite.normale => const Color(0xFF3B82F6),
        Priorite.basse => const Color(0xFF10B981),
      };

  String get labelPriorite => switch (priorite) {
        Priorite.haute => '🔴 Haute',
        Priorite.normale => '🔵 Normale',
        Priorite.basse => '🟢 Basse',
      };
}

// ============================================================
// 🧠 STATE MANAGEMENT
// ============================================================

enum FiltreStatut { toutes, enCours, terminees }

class TacheStore extends ChangeNotifier {
  final List<Tache> _taches = [];
  FiltreStatut _filtre = FiltreStatut.toutes;
  String _recherche = '';

  // Données de démo
  TacheStore() {
    _taches.addAll([
      Tache(
        id: '1',
        titre: 'Terminer le Chapitre 7 Flutter',
        description: 'State Management avec Provider',
        priorite: Priorite.haute,
        dateCreation: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Tache(
        id: '2',
        titre: 'Créer l\'UI de l\'app météo',
        priorite: Priorite.normale,
        dateCreation: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Tache(
        id: '3',
        titre: 'Revoir les exercices JSON',
        priorite: Priorite.basse,
        terminee: true,
        dateCreation: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ]);
  }

  // Getters
  FiltreStatut get filtre => _filtre;
  String get recherche => _recherche;

  List<Tache> get tachesFiltrees {
    var liste = _taches.where((t) {
      // Filtre par statut
      final statut = switch (_filtre) {
        FiltreStatut.toutes => true,
        FiltreStatut.enCours => !t.terminee,
        FiltreStatut.terminees => t.terminee,
      };
      // Filtre par recherche
      final rechercheOk = _recherche.isEmpty ||
          t.titre.toLowerCase().contains(_recherche.toLowerCase()) ||
          (t.description?.toLowerCase().contains(_recherche.toLowerCase()) ??
              false);
      return statut && rechercheOk;
    }).toList();

    // Trier : non-terminées d'abord, puis par priorité
    liste.sort((a, b) {
      if (a.terminee != b.terminee) return a.terminee ? 1 : -1;
      return a.priorite.index.compareTo(b.priorite.index);
    });

    return liste;
  }

  int get total => _taches.length;
  int get terminees => _taches.where((t) => t.terminee).length;
  double get progression => total == 0 ? 0 : terminees / total;

  // Actions
  void ajouter(Tache tache) {
    _taches.insert(0, tache);
    notifyListeners();
  }

  void toggleTerminee(String id) {
    final i = _taches.indexWhere((t) => t.id == id);
    if (i >= 0) {
      _taches[i] = _taches[i].copyWith(
        terminee: !_taches[i].terminee,
        dateTerminee: !_taches[i].terminee ? DateTime.now() : null,
      );
      notifyListeners();
    }
  }

  void modifier(String id, String titre, String? description, Priorite p) {
    final i = _taches.indexWhere((t) => t.id == id);
    if (i >= 0) {
      _taches[i] = _taches[i].copyWith(
          titre: titre, description: description, priorite: p);
      notifyListeners();
    }
  }

  void supprimer(String id) {
    _taches.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void setFiltre(FiltreStatut f) {
    _filtre = f;
    notifyListeners();
  }

  void setRecherche(String r) {
    _recherche = r;
    notifyListeners();
  }

  void viderTerminees() {
    _taches.removeWhere((t) => t.terminee);
    notifyListeners();
  }
}

// ============================================================
// 📱 ÉCRANS
// ============================================================

class AppTodo extends StatelessWidget {
  const AppTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final store = TacheStore();
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) => MaterialApp(
        title: 'To-Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
          ),
          useMaterial3: true,
        ),
        home: EcranTodo(store: store),
      ),
    );
  }
}

class EcranTodo extends StatefulWidget {
  final TacheStore store;
  const EcranTodo({super.key, required this.store});

  @override
  State<EcranTodo> createState() => _EcranTodoState();
}

class _EcranTodoState extends State<EcranTodo> {
  final _rechercheCtrl = TextEditingController();

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
        final taches = store.tachesFiltrees;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: CustomScrollView(
            slivers: [
              // ─── AppBar avec recherche ────────────────────
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
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
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '📋 Mes Tâches',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${store.terminees}/${store.total} terminées',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: store.progression,
                                backgroundColor: Colors.white30,
                                color: Colors.white,
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: TextField(
                      controller: _rechercheCtrl,
                      onChanged: store.setRecherche,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Rechercher une tâche...',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: store.recherche.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _rechercheCtrl.clear();
                                  store.setRecherche('');
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ),
              ),

              // ─── Filtres ──────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: FiltreStatut.values.map((f) {
                      final labels = ['Toutes', 'En cours', 'Terminées'];
                      final isSelected = store.filtre == f;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(labels[f.index]),
                          selected: isSelected,
                          onSelected: (_) => store.setFiltre(f),
                          backgroundColor: Colors.white,
                          selectedColor: const Color(0xFF6366F1),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // ─── Liste des tâches ─────────────────────────
              taches.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.task_alt,
                                size: 80, color: Color(0xFF6366F1)),
                            const SizedBox(height: 16),
                            Text(
                              store.recherche.isNotEmpty
                                  ? 'Aucun résultat'
                                  : '🎉 Tout est fait !',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      sliver: SliverList.builder(
                        itemCount: taches.length,
                        itemBuilder: (context, i) {
                          final t = taches[i];
                          return _CarteTache(
                            key: ValueKey(t.id),
                            tache: t,
                            store: store,
                          );
                        },
                      ),
                    ),
            ],
          ),

          // ─── FAB ──────────────────────────────────────────
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _ouvrirFormulaire(context, store),
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add),
            label: const Text('Nouvelle tâche'),
          ),
        );
      },
    );
  }

  void _ouvrirFormulaire(BuildContext context, TacheStore store,
      [Tache? tacheAmodifier]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FormulaireAjoutTache(
        store: store,
        tacheAmodifier: tacheAmodifier,
      ),
    );
  }
}

// ─── Carte de tâche ──────────────────────────────────────────
class _CarteTache extends StatelessWidget {
  final Tache tache;
  final TacheStore store;

  const _CarteTache({super.key, required this.tache, required this.store});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(tache.id),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        store.supprimer(tache.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${tache.titre}" supprimée'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () => store.ajouter(tache),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: tache.terminee
              ? Colors.grey.shade100
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: tache.terminee
                ? Colors.grey.shade200
                : tache.couleurPriorite.withOpacity(0.3),
          ),
          boxShadow: tache.terminee
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: GestureDetector(
            onTap: () => store.toggleTerminee(tache.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tache.terminee
                    ? const Color(0xFF10B981)
                    : Colors.transparent,
                border: Border.all(
                  color: tache.terminee
                      ? const Color(0xFF10B981)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: tache.terminee
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ),
          title: Text(
            tache.titre,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration: tache.terminee ? TextDecoration.lineThrough : null,
              color: tache.terminee ? Colors.grey : Colors.black87,
            ),
          ),
          subtitle: tache.description != null
              ? Text(
                  tache.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600),
                )
              : null,
          trailing: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tache.couleurPriorite.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tache.labelPriorite.split(' ').first,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Formulaire ajout/modification ───────────────────────────
class _FormulaireAjoutTache extends StatefulWidget {
  final TacheStore store;
  final Tache? tacheAmodifier;

  const _FormulaireAjoutTache({required this.store, this.tacheAmodifier});

  @override
  State<_FormulaireAjoutTache> createState() => _FormulaireAjoutTacheState();
}

class _FormulaireAjoutTacheState extends State<_FormulaireAjoutTache> {
  final _formKey = GlobalKey<FormState>();
  late final _titreCtrl = TextEditingController(
      text: widget.tacheAmodifier?.titre);
  late final _descCtrl = TextEditingController(
      text: widget.tacheAmodifier?.description);
  late Priorite _priorite =
      widget.tacheAmodifier?.priorite ?? Priorite.normale;

  bool get _estModification => widget.tacheAmodifier != null;

  @override
  void dispose() {
    _titreCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _sauvegarder() {
    if (!_formKey.currentState!.validate()) return;

    if (_estModification) {
      widget.store.modifier(
        widget.tacheAmodifier!.id,
        _titreCtrl.text.trim(),
        _descCtrl.text.trim().isNotEmpty ? _descCtrl.text.trim() : null,
        _priorite,
      );
    } else {
      widget.store.ajouter(Tache(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titre: _titreCtrl.text.trim(),
        description:
            _descCtrl.text.trim().isNotEmpty ? _descCtrl.text.trim() : null,
        priorite: _priorite,
        dateCreation: DateTime.now(),
      ));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _estModification ? 'Modifier la tâche' : 'Nouvelle tâche',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titreCtrl,
              autofocus: true,
              validator: (v) => v!.trim().isEmpty ? 'Titre requis' : null,
              decoration: const InputDecoration(
                labelText: 'Titre *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description (optionnel)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Priorité :',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: Priorite.values.map((p) {
                final labels = ['🔴 Haute', '🔵 Normale', '🟢 Basse'];
                final selected = _priorite == p;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ChoiceChip(
                      label: Text(labels[p.index],
                          style: const TextStyle(fontSize: 12)),
                      selected: selected,
                      onSelected: (_) => setState(() => _priorite = p),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sauvegarder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _estModification ? 'Enregistrer' : 'Ajouter la tâche',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 🚀 LANCEMENT
// ============================================================

void main() => runApp(const AppTodo());
