// ============================================================
// 🏆 PROJET 3 — APPLICATION MÉTÉO (API Simulation)
// Niveau : Intermédiaire → Avancé
// ============================================================

import 'package:flutter/material.dart';
import 'dart:math';

/*
FONCTIONNALITÉS :
  ✅ Simulation d'une vraie API météo (OpenWeatherMap)
  ✅ Météo actuelle avec icône et température
  ✅ Prévisions sur 7 jours
  ✅ Recherche de ville
  ✅ Indicateurs : humidité, vent, pression
  ✅ Fond dynamique selon la météo (soleil/pluie/nuage)
  ✅ Pull-to-refresh
  ✅ Design premium avec gradients

POUR UNE VRAIE APP :
  Utilise l'API OpenWeatherMap (gratuite) :
  https://openweathermap.org/api

  dependencies:
    http: ^1.1.0
    geolocator: ^10.1.0     // Pour la géolocalisation
    geocoding: ^2.1.1       // Pour convertir coords → ville
*/

// ============================================================
// 🗂️ MODÈLES
// ============================================================

class MeteoActuelle {
  final String ville;
  final String pays;
  final double temperature;
  final double temperatureRessentie;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final int humidite;
  final double vitesseVent;
  final int pression;
  final int visibilite;
  final DateTime heureLever;
  final DateTime heureCoucher;

  const MeteoActuelle({
    required this.ville,
    required this.pays,
    required this.temperature,
    required this.temperatureRessentie,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.humidite,
    required this.vitesseVent,
    required this.pression,
    required this.visibilite,
    required this.heureLever,
    required this.heureCoucher,
  });
}

class PrevisionJour {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final String description;
  final String icon;
  final int humidite;

  const PrevisionJour({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.icon,
    required this.humidite,
  });

  String get jourSemaine {
    const jours = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return jours[date.weekday - 1];
  }
}

// ============================================================
// 🌐 SERVICE MÉTÉO (SIMULÉ)
// ============================================================

class MeteoService {
  static final _random = Random();

  static final Map<String, MeteoActuelle> _donneesVilles = {
    'paris': MeteoActuelle(
      ville: 'Paris', pays: 'FR',
      temperature: 18, temperatureRessentie: 16,
      tempMin: 14, tempMax: 22,
      description: 'Partiellement nuageux',
      icon: '⛅',
      humidite: 65, vitesseVent: 12, pression: 1013, visibilite: 10,
      heureLever: DateTime(2024, 3, 21, 7, 15),
      heureCoucher: DateTime(2024, 3, 21, 19, 45),
    ),
    'new york': MeteoActuelle(
      ville: 'New York', pays: 'US',
      temperature: 12, temperatureRessentie: 9,
      tempMin: 8, tempMax: 15,
      description: 'Pluie légère',
      icon: '🌧️',
      humidite: 82, vitesseVent: 25, pression: 995, visibilite: 5,
      heureLever: DateTime(2024, 3, 21, 7, 0),
      heureCoucher: DateTime(2024, 3, 21, 19, 30),
    ),
    'tokyo': MeteoActuelle(
      ville: 'Tokyo', pays: 'JP',
      temperature: 22, temperatureRessentie: 21,
      tempMin: 17, tempMax: 25,
      description: 'Ensoleillé',
      icon: '☀️',
      humidite: 55, vitesseVent: 8, pression: 1020, visibilite: 20,
      heureLever: DateTime(2024, 3, 21, 5, 45),
      heureCoucher: DateTime(2024, 3, 21, 18, 0),
    ),
    'dubai': MeteoActuelle(
      ville: 'Dubai', pays: 'AE',
      temperature: 38, temperatureRessentie: 42,
      tempMin: 30, tempMax: 40,
      description: 'Très ensoleillé',
      icon: '🌞',
      humidite: 30, vitesseVent: 15, pression: 1005, visibilite: 15,
      heureLever: DateTime(2024, 3, 21, 6, 15),
      heureCoucher: DateTime(2024, 3, 21, 18, 30),
    ),
    'london': MeteoActuelle(
      ville: 'Londres', pays: 'GB',
      temperature: 10, temperatureRessentie: 7,
      tempMin: 7, tempMax: 13,
      description: 'Brouillard',
      icon: '🌫️',
      humidite: 90, vitesseVent: 18, pression: 988, visibilite: 2,
      heureLever: DateTime(2024, 3, 21, 6, 30),
      heureCoucher: DateTime(2024, 3, 21, 18, 45),
    ),
  };

  static Future<MeteoActuelle?> rechercherVille(String ville) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _donneesVilles[ville.toLowerCase()] ??
        // Si ville inconnue, on génère des données aléatoires
        MeteoActuelle(
          ville: ville,
          pays: 'XX',
          temperature: 15 + _random.nextInt(25).toDouble(),
          temperatureRessentie: 12 + _random.nextInt(25).toDouble(),
          tempMin: 10 + _random.nextInt(15).toDouble(),
          tempMax: 20 + _random.nextInt(15).toDouble(),
          description: ['Ensoleillé', 'Nuageux', 'Pluie légère'][_random.nextInt(3)],
          icon: ['☀️', '⛅', '🌧️'][_random.nextInt(3)],
          humidite: 40 + _random.nextInt(50),
          vitesseVent: 5 + _random.nextInt(30).toDouble(),
          pression: 980 + _random.nextInt(40),
          visibilite: 5 + _random.nextInt(15),
          heureLever: DateTime(2024, 3, 21, 6, 30),
          heureCoucher: DateTime(2024, 3, 21, 18, 45),
        );
  }

  static List<PrevisionJour> getPrevisions() {
    final icones = ['☀️', '⛅', '🌧️', '⛈️', '🌨️'];
    final descriptions = ['Ensoleillé', 'Nuageux', 'Pluie', 'Orage', 'Neige'];
    return List.generate(7, (i) {
      final idx = _random.nextInt(icones.length);
      final baseTemp = 15 + _random.nextInt(15);
      return PrevisionJour(
        date: DateTime.now().add(Duration(days: i + 1)),
        tempMin: baseTemp - 3.0,
        tempMax: baseTemp + 5.0,
        description: descriptions[idx],
        icon: icones[idx],
        humidite: 40 + _random.nextInt(50),
      );
    });
  }
}

// ============================================================
// 📱 APPLICATION
// ============================================================

void main() => runApp(const AppMeteo());

class AppMeteo extends StatelessWidget {
  const AppMeteo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Météo App',
      debugShowCheckedModeBanner: false,
      home: EcranMeteo(),
    );
  }
}

class EcranMeteo extends StatefulWidget {
  const EcranMeteo({super.key});

  @override
  State<EcranMeteo> createState() => _EcranMeteoState();
}

class _EcranMeteoState extends State<EcranMeteo> {
  MeteoActuelle? _meteo;
  List<PrevisionJour> _previsions = [];
  bool _chargement = false;
  String? _erreur;
  String _villeActuelle = 'Paris';
  final _rechercheCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chargerMeteo('Paris');
  }

  @override
  void dispose() {
    _rechercheCtrl.dispose();
    super.dispose();
  }

  Future<void> _chargerMeteo(String ville) async {
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      final meteo = await MeteoService.rechercherVille(ville);
      final previsions = MeteoService.getPrevisions();
      setState(() {
        _meteo = meteo;
        _previsions = previsions;
        _villeActuelle = ville;
        _chargement = false;
      });
    } catch (e) {
      setState(() {
        _erreur = 'Impossible de charger la météo';
        _chargement = false;
      });
    }
  }

  // Gradient selon la météo
  LinearGradient get _gradient {
    if (_meteo == null) {
      return const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)]);
    }
    final icon = _meteo!.icon;
    if (icon.contains('☀') || icon.contains('🌞')) {
      return const LinearGradient(
        colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (icon.contains('🌧') || icon.contains('⛈')) {
      return const LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (icon.contains('❄') || icon.contains('🌨')) {
      return const LinearGradient(
        colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: _gradient),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _chargerMeteo(_villeActuelle),
            child: CustomScrollView(
              slivers: [
                // ─── Header avec recherche ───────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Barre de recherche
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Icon(Icons.search, color: Colors.white),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _rechercheCtrl,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Rechercher une ville...',
                                    hintStyle:
                                        TextStyle(color: Colors.white60),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  onSubmitted: (v) {
                                    if (v.trim().isNotEmpty) {
                                      _chargerMeteo(v.trim());
                                      _rechercheCtrl.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Villes rapides
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              'Paris', 'New York', 'Tokyo', 'Dubai', 'London'
                            ]
                                .map(
                                  (v) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ActionChip(
                                      label: Text(v,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      side: BorderSide.none,
                                      onPressed: () => _chargerMeteo(v),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (_chargement)
                  const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 16),
                          Text('Chargement...',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  )
                else if (_meteo != null) ...[
                  // ─── Météo actuelle ──────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Ville
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white70, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '${_meteo!.ville}, ${_meteo!.pays}',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Température principale
                          Text(
                            _meteo!.icon,
                            style: const TextStyle(fontSize: 72),
                          ),
                          Text(
                            '${_meteo!.temperature.round()}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            _meteo!.description,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Min ${_meteo!.tempMin.round()}° · Res. ${_meteo!.temperatureRessentie.round()}° · Max ${_meteo!.tempMax.round()}°',
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 13),
                          ),
                          const SizedBox(height: 24),

                          // Indicateurs
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                _Indicateur('💧', '${_meteo!.humidite}%',
                                    'Humidité'),
                                _Indicateur(
                                    '💨',
                                    '${_meteo!.vitesseVent.round()}km/h',
                                    'Vent'),
                                _Indicateur('🌡️',
                                    '${_meteo!.pression}hPa', 'Pression'),
                                _Indicateur('👁️',
                                    '${_meteo!.visibilite}km', 'Visibilité'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ─── Prévisions 7 jours ──────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '📅 Prévisions 7 jours',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: _previsions
                                  .asMap()
                                  .entries
                                  .map((e) => _LignePrevision(
                                      prevision: e.value,
                                      derniere: e.key ==
                                          _previsions.length - 1))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Indicateur extends StatelessWidget {
  final String icone;
  final String valeur;
  final String label;

  const _Indicateur(this.icone, this.valeur, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icone, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(valeur,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        Text(label,
            style: const TextStyle(color: Colors.white60, fontSize: 10)),
      ],
    );
  }
}

class _LignePrevision extends StatelessWidget {
  final PrevisionJour prevision;
  final bool derniere;

  const _LignePrevision({required this.prevision, required this.derniere});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: derniere
            ? null
            : Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(
              prevision.jourSemaine,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Text(prevision.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              prevision.description,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Text(
            '${prevision.tempMin.round()}°',
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(width: 8),
          Text(
            '${prevision.tempMax.round()}°',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
