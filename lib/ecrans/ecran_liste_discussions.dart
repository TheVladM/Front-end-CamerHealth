import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fournisseurs/fournisseur_chat.dart';
import '../constantes/constantes_app.dart';
import 'ecran_detail_discussion.dart';

class EcranListeDiscussions extends StatelessWidget {
  const EcranListeDiscussions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'),
        elevation: 0,
      ),
      body: Consumer<FournisseurChat>(
        builder: (context, chatProvider, _) {
          final discussions = chatProvider.getApercusDiscussions();
          
          if (discussions.isEmpty) {
            return const Center(
              child: Text('Aucune discussion'),
            );
          }
          
          return ListView.builder(
            itemCount: discussions.length,
            itemBuilder: (context, index) {
              final discussion = discussions[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: ConstantesApp.couleurPrimaire.withOpacity(0.1),
                  child: Text(
                    discussion['nom'][0],
                    style: const TextStyle(
                      color: ConstantesApp.couleurPrimaire,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      discussion['nom'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (discussion['estEnLigne'] == true) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                subtitle: Text(
                  discussion['dernierMessage'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ConstantesApp.couleurTexteClair,
                  ),
                ),
                trailing: Text(
                  discussion['heure'],
                  style: TextStyle(
                    color: ConstantesApp.couleurTexteClair,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EcranDetailDiscussion(
                        discussionId: discussion['id'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
