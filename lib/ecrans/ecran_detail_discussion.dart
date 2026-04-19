import 'package:flutter/material.dart';

/// Écran affichant le détail d'une discussion

class EcranDetailDiscussion extends StatefulWidget {
  final String discussionId;

  const EcranDetailDiscussion({
    Key? key,
    required this.discussionId,
  }) : super(key: key);

  @override
  State<EcranDetailDiscussion> createState() => _EcranDetailDiscussionState();
}

class _EcranDetailDiscussionState extends State<EcranDetailDiscussion> {
  final TextEditingController _controllerMessage = TextEditingController();

  @override
  void dispose() {
    _controllerMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.grey[300]
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Message exemple'),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerMessage,
                    decoration: InputDecoration(
                      hintText: 'Écrivez un message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    // TODO: Envoyer le message
                    _controllerMessage.clear();
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
