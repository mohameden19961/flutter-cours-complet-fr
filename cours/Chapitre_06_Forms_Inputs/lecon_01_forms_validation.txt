// ============================================================
// 📘 CHAPITRE 06 — LEÇON 1
// Forms & Inputs : Saisie utilisateur et validation
// Niveau : Intermédiaire
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
╔══════════════════════════════════════════════════════════════╗
║   🎯 OBJECTIFS                                               ║
╠══════════════════════════════════════════════════════════════╣
║   ✅ Créer des formulaires avec Form et TextFormField        ║
║   ✅ Valider les entrées utilisateur                        ║
║   ✅ Utiliser les différents types de TextField             ║
║   ✅ Gérer le focus et le clavier                           ║
║   ✅ Construire un formulaire d'inscription complet         ║
╚══════════════════════════════════════════════════════════════╝
*/

// ============================================================
// 📖 PARTIE 1 : TEXTFIELD VS TEXTFORMFIELD
// ============================================================

/*
TEXTFIELD :
  → Widget de saisie de base
  → Pas de validation intégrée
  → Utilise TextEditingController pour lire la valeur

TEXTFORMFIELD :
  → Hérite de TextField
  → S'intègre dans un widget Form
  → Possède un validator (fonction de validation)
  → Recommandé pour les formulaires

RÈGLE : Utilise TextFormField + Form pour tous tes formulaires.
*/

// ─── Démonstration des TextField types ───────────────────────
class DemoTextFields extends StatelessWidget {
  const DemoTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Texte normal ─────────────────────────────────────
        const TextField(
          decoration: InputDecoration(
            labelText: 'Texte normal',
            hintText: 'Tape quelque chose...',
            prefixIcon: Icon(Icons.text_fields),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // ─── Mot de passe ────────────────────────────────────
        const TextField(
          obscureText: true, // Cache le texte (mot de passe)
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.visibility), // Icône "voir"
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // ─── Email ────────────────────────────────────────────
        const TextField(
          keyboardType: TextInputType.emailAddress, // Clavier email
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // ─── Téléphone ────────────────────────────────────────
        const TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Téléphone',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // ─── Numérique ────────────────────────────────────────
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Chiffres seulement
          ],
          decoration: const InputDecoration(
            labelText: 'Âge (chiffres seulement)',
            prefixIcon: Icon(Icons.numbers),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // ─── Multi-lignes ─────────────────────────────────────
        const TextField(
          maxLines: 4, // Hauteur de 4 lignes
          decoration: InputDecoration(
            labelText: 'Biographie',
            hintText: 'Parle-nous de toi...',
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 📖 PARTIE 2 : FORMULAIRE COMPLET AVEC VALIDATION
// ============================================================

class FormulaireInscription extends StatefulWidget {
  const FormulaireInscription({super.key});

  @override
  State<FormulaireInscription> createState() => _FormulaireInscriptionState();
}

class _FormulaireInscriptionState extends State<FormulaireInscription> {
  // ① Clé du formulaire — obligatoire pour valider
  final _formKey = GlobalKey<FormState>();

  // ② Controllers pour lire les valeurs
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _mdpController = TextEditingController();
  final _mdpConfirmController = TextEditingController();

  // ③ État du formulaire
  bool _mdpVisible = false;
  bool _mdpConfirmVisible = false;
  bool _accepteCGU = false;
  bool _chargement = false;
  String _genreSelectionne = 'Homme';

  @override
  void dispose() {
    // ⚠️ TOUJOURS disposer les controllers
    _nomController.dispose();
    _emailController.dispose();
    _mdpController.dispose();
    _mdpConfirmController.dispose();
    super.dispose();
  }

  // ─── Fonctions de validation ──────────────────────────────
  String? _validerNom(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) {
      return 'Le nom est obligatoire';
    }
    if (valeur.trim().length < 2) {
      return 'Le nom doit avoir au moins 2 caractères';
    }
    return null; // null = pas d'erreur
  }

  String? _validerEmail(String? valeur) {
    if (valeur == null || valeur.isEmpty) {
      return 'L\'email est obligatoire';
    }
    // Vérification basique du format email
    final regexEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regexEmail.hasMatch(valeur)) {
      return 'Format email invalide (ex: alice@gmail.com)';
    }
    return null;
  }

  String? _validerMotDePasse(String? valeur) {
    if (valeur == null || valeur.isEmpty) {
      return 'Le mot de passe est obligatoire';
    }
    if (valeur.length < 8) {
      return 'Au moins 8 caractères';
    }
    if (!valeur.contains(RegExp(r'[A-Z]'))) {
      return 'Au moins une majuscule';
    }
    if (!valeur.contains(RegExp(r'[0-9]'))) {
      return 'Au moins un chiffre';
    }
    return null;
  }

  String? _validerConfirmation(String? valeur) {
    if (valeur != _mdpController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  // ─── Soumission du formulaire ─────────────────────────────
  Future<void> _soumettre() async {
    // Valider TOUS les champs d'un coup
    if (!_formKey.currentState!.validate()) {
      return; // Arrêter si erreurs
    }
    if (!_accepteCGU) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tu dois accepter les CGU'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simuler une requête réseau
    setState(() => _chargement = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _chargement = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Compte créé pour ${_nomController.text} ! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // ① Attacher la clé au Form
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Nom complet ──────────────────────────────────
          TextFormField(
            controller: _nomController,
            validator: _validerNom,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nom complet *',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
              helperText: 'Prénom et nom de famille',
            ),
          ),
          const SizedBox(height: 16),

          // ─── Email ────────────────────────────────────────
          TextFormField(
            controller: _emailController,
            validator: _validerEmail,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Adresse email *',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // ─── Genre (DropdownButtonFormField) ──────────────
          DropdownButtonFormField<String>(
            value: _genreSelectionne,
            decoration: const InputDecoration(
              labelText: 'Genre',
              prefixIcon: Icon(Icons.wc),
              border: OutlineInputBorder(),
            ),
            items: ['Homme', 'Femme', 'Autre', 'Non spécifié']
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (val) => setState(() => _genreSelectionne = val!),
          ),
          const SizedBox(height: 16),

          // ─── Mot de passe ─────────────────────────────────
          TextFormField(
            controller: _mdpController,
            validator: _validerMotDePasse,
            obscureText: !_mdpVisible,
            decoration: InputDecoration(
              labelText: 'Mot de passe *',
              prefixIcon: const Icon(Icons.lock),
              border: const OutlineInputBorder(),
              helperText: '8+ chars, 1 majuscule, 1 chiffre',
              suffixIcon: IconButton(
                icon: Icon(
                  _mdpVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _mdpVisible = !_mdpVisible),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ─── Confirmation mot de passe ────────────────────
          TextFormField(
            controller: _mdpConfirmController,
            validator: _validerConfirmation,
            obscureText: !_mdpConfirmVisible,
            decoration: InputDecoration(
              labelText: 'Confirmer le mot de passe *',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _mdpConfirmVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _mdpConfirmVisible = !_mdpConfirmVisible),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ─── Accepter les CGU ─────────────────────────────
          Row(
            children: [
              Checkbox(
                value: _accepteCGU,
                onChanged: (val) => setState(() => _accepteCGU = val!),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _accepteCGU = !_accepteCGU),
                  child: const Text(
                    'J\'accepte les Conditions Générales d\'Utilisation',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ─── Bouton de soumission ─────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _chargement ? null : _soumettre,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _chargement
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Créer mon compte',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 🚀 PROGRAMME PRINCIPAL
// ============================================================

void main() {
  runApp(const AppForms());
}

class AppForms extends StatelessWidget {
  const AppForms({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulaire d\'Inscription'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Créer un compte',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Remplis le formulaire ci-dessous',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 24),
              FormulaireInscription(),
            ],
          ),
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
  Crée un formulaire de connexion simple avec :
  - Champ email avec validation
  - Champ mot de passe (obscureText)
  - Bouton "Se connecter"
  Affiche un SnackBar de succès si les 2 champs sont remplis.

🟡 MOYEN :
  Crée un formulaire "Ajouter une tâche" avec :
  - Titre (obligatoire, max 50 chars)
  - Description (optionnelle, max 200 chars)
  - Priorité (DropdownButtonFormField : basse/normale/haute)
  - Date d'échéance (TextField avec icône calendrier)
  Valide et affiche les données en console.

🔴 DIFFICILE :
  Crée un formulaire de paiement avec :
  - Numéro de carte (16 chiffres, formaté automatiquement "XXXX XXXX XXXX XXXX")
  - Date d'expiration (MM/YY, validation format)
  - CVV (3 chiffres, obscureText)
  - Nom sur la carte
  Utilise inputFormatters pour formater automatiquement.
*/
