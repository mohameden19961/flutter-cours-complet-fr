// ============================================================
// 📚 RESSOURCES — CHEAT SHEET FLUTTER COMPLET
// Référence rapide de tous les widgets et patterns
// ============================================================

/*
╔══════════════════════════════════════════════════════════════╗
║  🗺️ CHEAT SHEET FLUTTER — RÉFÉRENCE RAPIDE                  ║
╚══════════════════════════════════════════════════════════════╝

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📦 WIDGETS LAYOUT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MISE EN PAGE PRINCIPALE
  Scaffold         → Structure d'un écran (appBar + body + FAB)
  AppBar           → Barre du haut
  Column           → Enfants en colonne (vertical)
  Row              → Enfants en ligne (horizontal)
  Stack            → Enfants superposés
  Wrap             → Comme Row mais retour à la ligne

ESPACEMENT & TAILLE
  SizedBox(h,w)    → Espace fixe OU taille fixe
  Padding          → Espace intérieur
  Margin           → Via Container(margin:...)
  Center           → Centre son enfant
  Align            → Aligne son enfant

FLEXBOX
  Expanded         → Prend tout l'espace dispo (flex: 1)
  Flexible         → Prend l'espace dispo, peut être plus petit
  Spacer           → Espace vide flexible entre éléments

SCROLLABLE
  SingleChildScrollView → Un seul enfant scrollable
  ListView              → Liste scrollable verticale
  ListView.builder      → Liste optimisée (lazy)
  GridView.count        → Grille à nb colonnes fixe
  GridView.builder      → Grille optimisée
  CustomScrollView      → Scroll avancé avec Slivers
  SliverAppBar          → AppBar qui se réduit au scroll

CONTENEUR
  Container        → Boîte avec style complet
  Card             → Boîte avec ombre portée Material
  ClipRRect        → Découpe avec coins arrondis
  ClipOval         → Découpe en cercle

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 WIDGETS TEXTE & ICÔNES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Text('...')                    → Texte simple
  Text('...', style: TextStyle(  → Texte stylisé
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
    letterSpacing: 1.5,
    height: 1.5,                 → Interligne
  ))
  
  RichText(...)                  → Texte avec styles mixtes
  SelectableText(...)            → Texte sélectionnable
  Icon(Icons.star)               → Icône Material
  Icon(Icons.star, size: 32, color: Colors.amber)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🖼️ WIDGETS IMAGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Image.network(url)             → Image depuis URL
  Image.asset('assets/img.png') → Image locale
  Image.file(file)               → Image depuis fichier
  
  // Propriétés importantes :
  Image.network(
    url,
    width: 200,
    height: 200,
    fit: BoxFit.cover,          → Remplir en coupant
    fit: BoxFit.contain,        → Tout afficher
    fit: BoxFit.fill,           → Déformer pour remplir
    loadingBuilder: ...,        → Widget pendant chargement
    errorBuilder: ...,          → Widget si erreur
  )
  
  CircleAvatar(radius: 30)       → Avatar circulaire

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔘 BOUTONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ElevatedButton(onPressed: f, child: Text('...'))  → Bouton surélevé
  OutlinedButton(onPressed: f, child: Text('...'))  → Bouton contour
  TextButton(onPressed: f, child: Text('...'))       → Bouton texte
  IconButton(onPressed: f, icon: Icon(...))          → Bouton icône
  FloatingActionButton(onPressed: f, child: Icon()) → FAB
  ElevatedButton.icon(icon: ..., label: ...)         → Bouton icône+texte
  
  // Style des boutons :
  ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  )

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 FORMULAIRES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Form(key: _formKey, child: ...)        → Conteneur formulaire
  _formKey.currentState!.validate()      → Valider tout
  _formKey.currentState!.save()          → Sauvegarder
  _formKey.currentState!.reset()         → Réinitialiser
  
  TextFormField(
    controller: _ctrl,
    validator: (v) => v!.isEmpty ? 'Requis' : null,
    keyboardType: TextInputType.emailAddress,
    obscureText: true,                   → Mot de passe
    maxLines: 4,                         → Multi-lignes
    onChanged: (v) => setState((){}),
    onSubmitted: (v) => ...,
    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'ex@email.com',
      prefixIcon: Icon(Icons.email),
      suffixIcon: Icon(Icons.clear),
      border: OutlineInputBorder(),
      errorText: 'Erreur...',
    ),
  )
  
  DropdownButtonFormField<String>(
    value: _valeur,
    items: [...].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
    onChanged: (v) => setState((){}),
  )
  
  Checkbox(value: _val, onChanged: (v) => setState((){}))
  Switch(value: _val, onChanged: (v) => setState((){}))
  Slider(value: _val, onChanged: (v) => setState((){}))

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📐 DÉCORATION CONTAINER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Container(
    decoration: BoxDecoration(
      color: Colors.blue,                           → Couleur unie
      gradient: LinearGradient(                     → Dégradé
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),     → Coins arrondis
      border: Border.all(color: Colors.grey),       → Bordure
      boxShadow: [BoxShadow(                        → Ombre
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 4),
      )],
      image: DecorationImage(                       → Image de fond
        image: NetworkImage(url),
        fit: BoxFit.cover,
      ),
    ),
  )

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧭 NAVIGATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Navigator.push(context, MaterialPageRoute(builder: (_) => EcranB()))
  Navigator.pop(context)                           → Retour
  Navigator.pop(context, 'résultat')               → Retour avec données
  Navigator.pushReplacement(context, route)         → Remplace l'écran
  Navigator.pushAndRemoveUntil(context, route, (_) => false) → Vide le stack
  Navigator.pushNamed(context, '/route')            → Route nommée
  
  // Routes nommées dans MaterialApp :
  routes: {
    '/': (ctx) => EcranAccueil(),
    '/profil': (ctx) => EcranProfil(),
  }
  
  // Passer des données :
  Navigator.push(context, MaterialPageRoute(
    builder: (_) => EcranB(data: maVariable),
  ))
  
  // Récupérer des données en retour :
  final result = await Navigator.push<String>(context, route)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ ASYNC / FUTURES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  // FutureBuilder — afficher le résultat d'une Future
  FutureBuilder<String>(
    future: monFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.hasError) return Text('Erreur: ${snapshot.error}');
      return Text(snapshot.data!);
    },
  )
  
  // StreamBuilder — écouter un Stream
  StreamBuilder<int>(
    stream: monStream,
    builder: (context, snapshot) {
      return Text('${snapshot.data ?? 0}');
    },
  )

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 ANIMATIONS RAPIDES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  AnimatedContainer(duration: Duration(milliseconds: 300), ...)
  AnimatedOpacity(duration: ..., opacity: _val, child: ...)
  AnimatedSize(duration: ..., child: ...)
  AnimatedCrossFade(firstChild: A, secondChild: B, crossFadeState: ...)
  Hero(tag: 'unique', child: ...)            → Transition entre écrans
  AnimatedSwitcher(duration: ..., child: ...) → Transition entre enfants

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 DIALOGS & SNACKBARS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  // SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Message'), duration: Duration(seconds: 3))
  )
  
  // Dialog
  showDialog(context: context, builder: (ctx) => AlertDialog(
    title: Text('Titre'),
    content: Text('Message'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Annuler')),
      ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text('OK')),
    ],
  ))
  
  // Bottom Sheet
  showModalBottomSheet(context: context, builder: (_) => MonWidget())

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 COULEURS & THÈME
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Colors.blue                    → Couleur directe
  Colors.blue.shade200           → Teinte plus claire
  Colors.blue.shade800           → Teinte plus foncée
  Color(0xFF2563EB)              → Couleur hexadécimale
  color.withOpacity(0.5)         → Couleur semi-transparente
  
  Theme.of(context).colorScheme.primary    → Couleur primaire du thème
  Theme.of(context).textTheme.bodyLarge    → Style de texte du thème

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔧 PACKAGES INCONTOURNABLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  http: ^1.1.0                   → Requêtes HTTP
  provider: ^6.1.1               → State management
  shared_preferences: ^2.2.0    → Stockage simple clé-valeur
  sqflite: ^2.3.0               → Base de données SQLite
  hive_flutter: ^1.1.0          → Base NoSQL rapide
  go_router: ^12.0.0            → Navigation avancée
  cached_network_image: ^3.3.0  → Cache d'images réseau
  flutter_riverpod: ^2.4.0      → State management avancé
  dio: ^5.3.0                   → HTTP avancé
  get_it: ^7.6.0                → Injection de dépendances
  freezed: ^2.4.0               → Classes immutables
  json_serializable: ^6.7.0     → Sérialisation JSON auto
  geolocator: ^10.1.0           → Géolocalisation
  image_picker: ^1.0.0          → Sélectionner des images
  url_launcher: ^6.2.0          → Ouvrir URLs / apps
  flutter_svg: ^2.0.9           → Afficher des SVG
  lottie: ^2.7.0               → Animations Lottie
  fl_chart: ^0.65.0            → Graphiques et charts
  intl: ^0.18.0                → Internationalisation + dates
  
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 TIPS & BEST PRACTICES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ✅ Utiliser const partout où c'est possible
  ✅ Extraire les widgets en classes séparées (>30 lignes)
  ✅ Toujours dispose() les controllers/subscriptions
  ✅ ListView.builder pour les listes (pas ListView)
  ✅ BuildContext ne doit pas traverser les async gaps
     → vérifier context.mounted après await
  ✅ Ne jamais faire de calculs lourds dans build()
  ✅ Nommer les keys (ValueKey) pour les listes animées
  ✅ MediaQuery.of(context).size pour les tailles d'écran
  ✅ LayoutBuilder pour les layouts responsives
  ✅ RepaintBoundary pour isoler les animations complexes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔗 LIENS UTILES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  flutter.dev                    → Documentation officielle
  api.flutter.dev                → API Reference complète
  pub.dev                        → Packages Flutter/Dart
  dartpad.dev                    → IDE en ligne
  flutter.dev/docs/codelabs     → Tutoriels officiels
  material.io/components        → Guidelines Material Design
  icons.flutterclutter.app      → Chercher les Icons.xxx
  flutterfire.dev                → Firebase + Flutter
*/

void main() {
  print('╔══════════════════════════════════════════════════╗');
  print('║  CHEAT SHEET FLUTTER — Référence rapide          ║');
  print('╚══════════════════════════════════════════════════╝');
  print('');
  print('Ce fichier contient tous les widgets et patterns');
  print('Flutter les plus utilisés, en référence rapide.');
  print('');
  print('Chapitres :');
  print('  1. Widgets Layout');
  print('  2. Texte & Icônes');
  print('  3. Images');
  print('  4. Boutons');
  print('  5. Formulaires');
  print('  6. Décoration Container');
  print('  7. Navigation');
  print('  8. Async/Futures');
  print('  9. Animations');
  print('  10. Dialogs & Snackbars');
  print('  11. Couleurs & Thème');
  print('  12. Packages incontournables');
  print('  13. Best Practices');
}
