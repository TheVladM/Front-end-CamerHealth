import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constantes/constantes_app.dart';
import '../fournisseurs/fournisseur_auth.dart';
import '../modeles/patient.dart';
import '../widgets/carte_patient.dart';
import '../widgets/menu_lateral.dart';
import 'ecran_donnees_vitales.dart';
import 'ecran_liste_discussions.dart';
import 'ecran_statistiques.dart';
import 'ecran_prevention.dart';
import 'ecran_symptomes.dart';
import 'ecran_joindre_medecin.dart';
import 'ecran_compte.dart';

class EcranAccueilMedecin extends StatefulWidget {
  const EcranAccueilMedecin({super.key});

  @override
  State<EcranAccueilMedecin> createState() => _EcranAccueilMedecinState();
}

class _EcranAccueilMedecinState extends State<EcranAccueilMedecin> {
  int _selectedIndex = 0;

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

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Mes patients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Patients enregistrés',
                style: TextStyle(
                  color: ConstantesApp.couleurTexteClair,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: Patient.patientsMock.length,
                itemBuilder: (context, index) {
                  final patient = Patient.patientsMock[index];
                  return CartePatient(
                    id: patient.id,
                    nom: patient.nom.split(' ').last,
                    prenom: patient.nom.split(' ').first,
                    age: 30, // Valeur par défaut, à ajuster selon les besoins
                  );
                },
              ),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
