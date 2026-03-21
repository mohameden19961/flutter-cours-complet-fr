// ============================================================
// 🏆 PROJET 5 — APPLICATION CHAT COMPLÈTE
// Niveau : Avancé
// ============================================================

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

/*
FONCTIONNALITÉS :
  ✅ Liste des conversations avec badge et aperçu
  ✅ Interface de chat style WhatsApp/iMessage
  ✅ Bulles de message distinctes (envoi/réception)
  ✅ Indicateur de saisie (typing indicator)
  ✅ Statut message (envoyé/reçu/lu)
  ✅ Horodatage des messages
  ✅ Messages simulés automatiquement
  ✅ Design premium sombre/clair
*/

// ============================================================
// 🗂️ MODÈLES
// ============================================================

enum StatutMessage { envoi, recu, lu }

class Message {
  final String id;
  final String contenu;
  final bool estMoi;
  final DateTime horodatage;
  StatutMessage statut;

  Message({
    required this.id,
    required this.contenu,
    required this.estMoi,
    required this.horodatage,
    this.statut = StatutMessage.envoi,
  });

  String get heureFormatee {
    final h = horodatage.hour.toString().padLeft(2, '0');
    final m = horodatage.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class Conversation {
  final String id;
  final String nom;
  final String avatar;
  final Color couleurAvatar;
  bool enLigne;
  bool entrain;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.nom,
    required this.avatar,
    required this.couleurAvatar,
    this.enLigne = false,
    this.entrain = false,
    required this.messages,
  });

  Message? get dernierMessage =>
      messages.isNotEmpty ? messages.last : null;

  int get nbNonLus =>
      messages.where((m) => !m.estMoi && m.statut != StatutMessage.lu).length;
}

// ============================================================
// 🤖 RÉPONSES AUTOMATIQUES
// ============================================================

final _random = Random();

const List<String> _reponsesAuto = [
  'Oui bien sûr ! 😊',
  'Je te réponds dans un moment',
  'D\'accord, pas de problème',
  '👍',
  'Super ! Tu fais ça très bien',
  'Haha oui c\'est vrai 😂',
  'Ok je vois, merci pour l\'info',
  'Je vais y réfléchir',
  'C\'est noté !',
  'Tu as raison, bonne idée',
  'On se retrouve là-bas alors ?',
  'Flutter c\'est vraiment top non ? 🚀',
  '❤️',
  'Bonne journée à toi aussi !',
  'Je t\'appelle ce soir',
];

String _reponsealeatoire() =>
    _reponsesAuto[_random.nextInt(_reponsesAuto.length)];

// ============================================================
// 🧠 STORE
// ============================================================

class ChatStore extends ChangeNotifier {
  final List<Conversation> _conversations = [
    Conversation(
      id: 'c1',
      nom: 'Alice Martin',
      avatar: 'AM',
      couleurAvatar: const Color(0xFF6366F1),
      enLigne: true,
      messages: [
        Message(
            id: 'm1',
            contenu: 'Salut ! Tu as commencé le cours Flutter ?',
            estMoi: false,
            horodatage: DateTime.now().subtract(const Duration(minutes: 30)),
            statut: StatutMessage.lu),
        Message(
            id: 'm2',
            contenu: 'Oui ! Je suis au chapitre 5, la navigation 🚀',
            estMoi: true,
            horodatage: DateTime.now().subtract(const Duration(minutes: 28)),
            statut: StatutMessage.lu),
        Message(
            id: 'm3',
            contenu: 'Cool ! C\'est vraiment bien ce cours',
            estMoi: false,
            horodatage: DateTime.now().subtract(const Duration(minutes: 25)),
            statut: StatutMessage.lu),
      ],
    ),
    Conversation(
      id: 'c2',
      nom: 'Bob Dupont',
      avatar: 'BD',
      couleurAvatar: const Color(0xFF10B981),
      enLigne: false,
      messages: [
        Message(
            id: 'm4',
            contenu: 'Tu peux m\'aider avec Provider ?',
            estMoi: false,
            horodatage: DateTime.now().subtract(const Duration(hours: 1)),
            statut: StatutMessage.recu),
        Message(
            id: 'm5',
            contenu: 'Bien sûr ! C\'est quoi le problème ?',
            estMoi: true,
            horodatage: DateTime.now().subtract(const Duration(minutes: 55)),
            statut: StatutMessage.lu),
      ],
    ),
    Conversation(
      id: 'c3',
      nom: 'Equipe Flutter 🚀',
      avatar: '🚀',
      couleurAvatar: const Color(0xFFF59E0B),
      enLigne: true,
      messages: [
        Message(
            id: 'm6',
            contenu: 'Qui est disponible ce weekend ?',
            estMoi: false,
            horodatage: DateTime.now().subtract(const Duration(hours: 2)),
            statut: StatutMessage.recu),
        Message(
            id: 'm7',
            contenu: 'Moi ! On fait quoi ? 🎉',
            estMoi: false,
            horodatage: DateTime.now().subtract(const Duration(hours: 2)),
            statut: StatutMessage.lu),
        Message(
            id: 'm8',
            contenu: 'Je suis dispo dimanche',
            estMoi: true,
            horodatage: DateTime.now().subtract(const Duration(hours: 1)),
            statut: StatutMessage.lu),
      ],
    ),
  ];

  List<Conversation> get conversations => _conversations;

  Conversation getConversation(String id) =>
      _conversations.firstWhere((c) => c.id == id);

  void envoyerMessage(String convId, String contenu) {
    final conv = getConversation(convId);
    conv.messages.add(Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      contenu: contenu,
      estMoi: true,
      horodatage: DateTime.now(),
    ));
    notifyListeners();

    // Simulation : marquer comme reçu après 1s
    Future.delayed(const Duration(seconds: 1), () {
      conv.messages.last.statut = StatutMessage.recu;
      notifyListeners();
    });

    // Simulation : réponse automatique après 1-3s
    final delai = 1000 + _random.nextInt(2000);
    Future.delayed(const Duration(milliseconds: 500), () {
      conv.entrain = true;
      notifyListeners();
    });
    Future.delayed(Duration(milliseconds: delai + 500), () {
      conv.entrain = false;
      conv.messages.add(Message(
        id: '${DateTime.now().millisecondsSinceEpoch}r',
        contenu: _reponsealeatoire(),
        estMoi: false,
        horodatage: DateTime.now(),
      ));
      // Marquer notre message précédent comme lu
      for (final m in conv.messages) {
        if (m.estMoi) m.statut = StatutMessage.lu;
      }
      notifyListeners();
    });
  }
}

// ============================================================
// 📱 APPLICATION
// ============================================================

void main() => runApp(const AppChat());

class AppChat extends StatelessWidget {
  const AppChat({super.key});

  @override
  Widget build(BuildContext context) {
    final store = ChatStore();
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) => MaterialApp(
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF25D366)),
          useMaterial3: true,
        ),
        home: EcranConversations(store: store),
      ),
    );
  }
}

// ─── Écran liste des conversations ───────────────────────────
class EcranConversations extends StatelessWidget {
  final ChatStore store;
  const EcranConversations({super.key, required this.store});

  String _formatHeure(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes}min';
    if (diff.inHours < 24) return '${dt.hour}:${dt.minute.toString().padLeft(2,'0')}';
    return '${dt.day}/${dt.month}';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (_, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Messages',
                style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: ListView.separated(
            itemCount: store.conversations.length,
            separatorBuilder: (_, __) => const Divider(
                indent: 80, height: 1, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, i) {
              final conv = store.conversations[i];
              final dernier = conv.dernierMessage;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: conv.couleurAvatar,
                      child: Text(
                        conv.avatar,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (conv.enLigne)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF25D366),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(conv.nom,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    if (dernier != null)
                      Text(
                        _formatHeure(dernier.horodatage),
                        style: TextStyle(
                          fontSize: 11,
                          color: conv.nbNonLus > 0
                              ? const Color(0xFF25D366)
                              : Colors.grey,
                        ),
                      ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    if (dernier?.estMoi == true) ...[
                      Icon(
                        dernier?.statut == StatutMessage.lu
                            ? Icons.done_all
                            : Icons.done,
                        size: 14,
                        color: dernier?.statut == StatutMessage.lu
                            ? const Color(0xFF25D366)
                            : Colors.grey,
                      ),
                      const SizedBox(width: 2),
                    ],
                    Expanded(
                      child: Text(
                        conv.entrain ? '✍️ En train d\'écrire...' : (dernier?.contenu ?? ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: conv.entrain ? const Color(0xFF25D366) : Colors.grey,
                          fontStyle: conv.entrain ? FontStyle.italic : null,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (conv.nbNonLus > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25D366),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${conv.nbNonLus}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EcranChat(
                        conversationId: conv.id, store: store),
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF25D366),
            onPressed: () {},
            child: const Icon(Icons.chat, color: Colors.white),
          ),
        );
      },
    );
  }
}

// ─── Écran de chat ────────────────────────────────────────────
class EcranChat extends StatefulWidget {
  final String conversationId;
  final ChatStore store;

  const EcranChat(
      {super.key, required this.conversationId, required this.store});

  @override
  State<EcranChat> createState() => _EcranChatState();
}

class _EcranChatState extends State<EcranChat> {
  final _ctrl = TextEditingController();
  final _scrollController = ScrollController();

  void _envoyer() {
    final texte = _ctrl.text.trim();
    if (texte.isEmpty) return;
    widget.store.envoyerMessage(widget.conversationId, texte);
    _ctrl.clear();
    _scrollerEnBas();
  }

  void _scrollerEnBas() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.store,
      builder: (_, __) {
        final conv = widget.store.getConversation(widget.conversationId);
        _scrollerEnBas();

        return Scaffold(
          backgroundColor: const Color(0xFFECE5DD),
          appBar: AppBar(
            backgroundColor: const Color(0xFF128C7E),
            foregroundColor: Colors.white,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: conv.couleurAvatar,
                  child: Text(conv.avatar,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(conv.nom,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(
                      conv.entrain
                          ? 'En train d\'écrire...'
                          : (conv.enLigne ? 'En ligne' : 'Hors ligne'),
                      style: TextStyle(
                        fontSize: 11,
                        color: conv.entrain
                            ? Colors.greenAccent
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.video_call), onPressed: () {}),
              IconButton(icon: const Icon(Icons.call), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: Column(
            children: [
              // Liste de messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  itemCount: conv.messages.length,
                  itemBuilder: (_, i) {
                    final msg = conv.messages[i];
                    final suivant = i < conv.messages.length - 1
                        ? conv.messages[i + 1]
                        : null;
                    final dernierDuGroupe =
                        suivant == null || suivant.estMoi != msg.estMoi;

                    return _BulleMessage(
                      message: msg,
                      dernierDuGroupe: dernierDuGroupe,
                    );
                  },
                ),
              ),

              // Indicateur de saisie
              if (conv.entrain)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12, bottom: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const _TypingIndicator(),
                  ),
                ),

              // Barre de saisie
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                color: const Color(0xFFECE5DD),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              const Icon(Icons.emoji_emotions_outlined,
                                  color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _ctrl,
                                  maxLines: 4,
                                  minLines: 1,
                                  onSubmitted: (_) => _envoyer(),
                                  decoration: const InputDecoration(
                                    hintText: 'Message...',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                ),
                              ),
                              const Icon(Icons.attach_file,
                                  color: Colors.grey),
                              const SizedBox(width: 4),
                              const Icon(Icons.camera_alt_outlined,
                                  color: Colors.grey),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _envoyer,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFF25D366),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.send,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Bulle de message ─────────────────────────────────────────
class _BulleMessage extends StatelessWidget {
  final Message message;
  final bool dernierDuGroupe;

  const _BulleMessage({
    required this.message,
    required this.dernierDuGroupe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.estMoi
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: dernierDuGroupe ? 8 : 2,
          left: message.estMoi ? 48 : 0,
          right: message.estMoi ? 0 : 48,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: message.estMoi
              ? const Color(0xFFDCF8C6)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(
                message.estMoi ? 18 : (dernierDuGroupe ? 4 : 18)),
            bottomRight: Radius.circular(
                message.estMoi ? (dernierDuGroupe ? 4 : 18) : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                message.contenu,
                style: const TextStyle(fontSize: 15, height: 1.3),
              ),
            ),
            const SizedBox(width: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.heureFormatee,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                if (message.estMoi) ...[
                  const SizedBox(width: 2),
                  Icon(
                    message.statut == StatutMessage.lu
                        ? Icons.done_all
                        : Icons.done,
                    size: 14,
                    color: message.statut == StatutMessage.lu
                        ? const Color(0xFF34B7F1)
                        : Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Indicateur de saisie animé ──────────────────────────────
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0, end: -6).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();

    // Démarrer les animations en cascade
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (_, __) => Transform.translate(
            offset: Offset(0, _animations[i].value),
            child: Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
