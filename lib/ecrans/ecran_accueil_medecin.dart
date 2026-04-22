import 'package:camerhealth/widgets/barre_navigation_medecin.dart';
import 'package:camerhealth/widgets/notification_icon.dart';
import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/patient.dart';
import '../widgets/carte_patient.dart';
import 'ecran_liste_discussions.dart';
import 'ecran_statistiques.dart';
import 'ecran_compte.dart';
import 'ecran_profil_patient.dart';

class EcranAccueilMedecin extends StatefulWidget {
  const EcranAccueilMedecin({super.key});

  @override
  State<EcranAccueilMedecin> createState() => _EcranAccueilMedecinState();
}

class _EcranAccueilMedecinState extends State<EcranAccueilMedecin> {
  int _selectedIndex = 0;

  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return ConstantesApp.nomApp;
      case 1:
        return 'Statistiques';
      case 2:
        return 'Discussions';
      case 3:
        return 'Compte';
      default:
        return ConstantesApp.nomApp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getPageTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/logo.png', height: 40),
        ),
        actions: [
          // Bouton recherche uniquement sur l'onglet patients
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RecherchePatientDelegate(),
                );
              },
            ),
          const NotificationIcon(),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _PatientsBody(),
          // showAppBar: false évite la double AppBar dans l'IndexedStack
          const EcranStatistiques(showAppBar: false),
          const EcranListeDiscussions(),
          const EcranCompte(),
        ],
      ),
      bottomNavigationBar: BarreNavigationMedecin(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}

// ─── Corps "Mes patients" ──────────────────────────────────────────────────

class _PatientsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mes patients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${Patient.patientsMock.length} patients enregistrés',
                  style: const TextStyle(
                    color: ConstantesApp.couleurTexteClair,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: Patient.patientsMock.length,
              itemBuilder: (context, index) {
                final patient = Patient.patientsMock[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EcranProfilPatient(patient: patient),
                      ),
                    );
                  },
                  child: CartePatient(
                    id: patient.id,
                    nom: patient.nom.split(' ').last,
                    prenom: patient.nom.split(' ').first,
                    age: 30,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Délégué de recherche ──────────────────────────────────────────────────

class RecherchePatientDelegate extends SearchDelegate<Patient?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultats = Patient.patientsMock
        .where((p) => p.nom.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildListeResultats(context, resultats);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = Patient.patientsMock
        .where((p) => p.nom.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildListeResultats(context, suggestions);
  }

  Widget _buildListeResultats(BuildContext context, List<Patient> resultats) {
    if (resultats.isEmpty) {
      return const Center(child: Text('Aucun patient trouvé'));
    }
    return ListView.builder(
      itemCount: resultats.length,
      itemBuilder: (context, index) {
        final patient = resultats[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(patient.nom),
          subtitle: Text('ID: ${patient.id}'),
          onTap: () {
            close(context, patient);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EcranProfilPatient(patient: patient),
              ),
            );
          },
        );
      },
    );
  }
}
