// ============================================================
// 🚀 WORKSPACE — COURS FLUTTER COMPLET EN FRANÇAIS
// ============================================================
//
// COMMENT UTILISER CE FICHIER :
//
//   1. Ouvre un fichier de leçon dans cours/
//      ex: cours/Chapitre_03_Widgets_Basics/lecon_01_stateless_widget.dart
//
//   2. Copie TOUT son contenu (Ctrl+A → Ctrl+C)
//
//   3. Reviens ici dans lib/main.dart
//
//   4. Remplace tout (Ctrl+A → Ctrl+V)
//
//   5. Sauvegarde (Ctrl+S) → Hot Reload automatique ! 🔥
//
// ============================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cours Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
        ),
        useMaterial3: true,
      ),
      home: const EcranAccueil(),
    );
  }
}

class EcranAccueil extends StatelessWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Flutter
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 56,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                '🚀 Workspace Prêt !',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Cours Flutter Complet en Français',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 40),

              // Instructions
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📖 Comment utiliser ce workspace',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 16),
                    _Etape(
                      numero: '1',
                      texte: 'Ouvre un fichier dans cours/',
                      detail: 'ex: Chapitre_03.../lecon_01_stateless_widget.dart',
                    ),
                    _Etape(
                      numero: '2',
                      texte: 'Copie tout le contenu',
                      detail: 'Ctrl+A puis Ctrl+C',
                    ),
                    _Etape(
                      numero: '3',
                      texte: 'Reviens ici → lib/main.dart',
                      detail: 'Ctrl+A puis Ctrl+V',
                    ),
                    _Etape(
                      numero: '4',
                      texte: 'Sauvegarde',
                      detail: 'Ctrl+S → Hot Reload automatique 🔥',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Badge chapitres
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (final chap in [
                    '01 Intro',
                    '02 Install',
                    '03 Widgets',
                    '04 Layouts',
                    '05 Navigation',
                    '06 Forms',
                    '07 State',
                    '08 API',
                    '09 JSON',
                    '10 Storage',
                    '11 UI/UX',
                    '12 Perf',
                  ])
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        chap,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6366F1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Etape extends StatelessWidget {
  final String numero;
  final String texte;
  final String detail;

  const _Etape({
    required this.numero,
    required this.texte,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                numero,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  texte,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
