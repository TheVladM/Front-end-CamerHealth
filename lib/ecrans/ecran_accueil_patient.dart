import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constantes/constantes_app.dart';
import '../fournisseurs/fournisseur_auth.dart';
import '../widgets/menu_lateral.dart';
import 'ecran_statistiques.dart';
import 'ecran_prevention.dart';
import 'ecran_symptomes.dart';
import 'ecran_donnees_vitales.dart';
import 'ecran_joindre_medecin.dart';
import 'ecran_rapport.dart';
import 'ecran_compte.dart';
import 'ecran_liste_discussions.dart';

class EcranAccueilPatient extends StatefulWidget {
  const EcranAccueilPatient({super.key});

  @override
  State<EcranAccueilPatient> createState() => _EcranAccueilPatientState();
}

class _EcranAccueilPatientState extends State<EcranAccueilPatient> {
  int _selectedIndex = 0;

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ConstantesApp.messageBienvenue,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ConstantesApp.salutation,
                style: TextStyle(
                  fontSize: 16,
                  color: ConstantesApp.couleurTexteClair,
                ),
              ),
              const SizedBox(height: 24),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildCarteFonction(
                    context,
                    icone: Icons.assignment,
                    titre: 'Rapport du cas',
                    couleur: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranRapport()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.bar_chart,
                    titre: 'Statistiques COVID-19',
                    couleur: Colors.orange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranStatistiques()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.shield,
                    titre: 'Prévention COVID-19',
                    couleur: Colors.green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranPrevention()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.favorite,
                    titre: 'Données vitales',
                    couleur: Colors.red,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranDonneesVitales()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.sick,
                    titre: 'Symptômes COVID-19',
                    couleur: Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranSymptomes()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.medical_services,
                    titre: 'Joindre un médecin',
                    couleur: Colors.teal,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranJoindreMedecin()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.settings,
                    titre: 'Réglages du compte',
                    couleur: Colors.grey,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranCompte()),
                    ),
                  ),
                  _buildCarteFonction(
                    context,
                    icone: Icons.chat,
                    titre: 'Discussions',
                    couleur: Colors.indigo,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EcranListeDiscussions()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return const Center(child: Text('Statistiques'));
      case 2:
        return const Center(child: Text('Discussions'));
      case 3:
        return const Center(child: Text('Compte'));
      default:
        return const Center(child: Text('Accueil'));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate if needed
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranStatistiques()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranListeDiscussions()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranCompte()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MenuLateral(
        onMenuItemSelected: (item) {
          final authProvider = Provider.of<FournisseurAuth>(context, listen: false);
          switch (item) {
            case 'accueil':
              setState(() {
                _selectedIndex = 0;
              });
              break;
            case 'donnees_vitales':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcranDonneesVitales()),
              );
              break;
            case 'discussions':
              setState(() {
                _selectedIndex = 2;
              });
              break;
            case 'statistiques':
              setState(() {
                _selectedIndex = 1;
              });
              break;
            case 'joindre_medecin':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcranJoindreMedecin()),
              );
              break;
            case 'symptomes':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcranSymptomes()),
              );
              break;
            case 'prevention':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcranPrevention()),
              );
              break;
            case 'compte':
              setState(() {
                _selectedIndex = 3;
              });
              break;
            case 'deconnexion':
              authProvider.deconnexion();
              break;
          }
        },
      ),
      body: _getBodyWidget(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Discussions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Compte',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ConstantesApp.couleurPrimaire,
        backgroundColor: ConstantesApp.couleurPrimaire,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _buildCarteFonction(
    BuildContext context, {
    required IconData icone,
    required String titre,
    required Color couleur,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: couleur.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, size: 32, color: couleur),
            ),
            const SizedBox(height: 12),
            Text(
              titre,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
