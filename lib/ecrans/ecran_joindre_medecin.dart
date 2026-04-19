import 'package:flutter/material.dart';

/// Écran pour joindre un médecin

class EcranJoindreMedecin extends StatelessWidget {
  const EcranJoindreMedecin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joindre un Médecin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Trouvez un médecin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher un médecin...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text('Dr. Médecin ${index + 1}'),
                      subtitle: const Text('Cardiologue'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // TODO: Joindre le médecin
                        },
                        child: const Text('Joindre'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
