import 'package:flutter/material.dart';
import '../modeles/antecedents_medicaux.dart';

class FournisseurAntecedentsMedicaux extends ChangeNotifier {
  Map<String, AntecedentsMedicaux> _antecedentsMedicaux = {};

  FournisseurAntecedentsMedicaux() {
    // Données mock pour test
    _antecedentsMedicaux = {
      '1': AntecedentsMedicaux(
        groupeSanguin: 'O+',
        poids: 75.5,
        taille: 180.0,
        allergies: 'Pénicilline, Arachides',
        maladiesChroniques: 'Diabète de type 2, Hypertension artérielle',
        medicaments: 'Metformine 500mg 2x/jour, Losartan 50mg 1x/jour',
        antecedentsFamiliaux: 'Père: Infarctus du myocarde, Mère: Diabète',
        interventionsChirurgicales: 'Appendicectomie (2015)',
        fumeur: false,
        alcool: false,
        activitePhysique: true,
      ),
      '2': AntecedentsMedicaux(
        groupeSanguin: 'A-',
        poids: 68.0,
        taille: 175.0,
        allergies: 'Sulfamides',
        maladiesChroniques: 'Asthme allergique',
        medicaments: 'Albuterol inhalateur au besoin',
        antecedentsFamiliaux: 'Mère: Asthme',
        interventionsChirurgicales: 'Aucune',
        fumeur: false,
        alcool: false,
        activitePhysique: true,
      ),
      '3': AntecedentsMedicaux(
        groupeSanguin: 'B+',
        poids: 82.0,
        taille: 185.0,
        allergies: 'Aucune connue',
        maladiesChroniques: 'Cholestérol élevé',
        medicaments: 'Atorvastatine 20mg 1x/jour',
        antecedentsFamiliaux: 'Père: Cholestérol, Grand-père: AVC',
        interventionsChirurgicales: 'Chirurgie de la vésicule biliaire (2018)',
        fumeur: false,
        alcool: true,
        activitePhysique: false,
      ),
    };
  }

  AntecedentsMedicaux? obtenirAntecedents(String patientId) {
    return _antecedentsMedicaux[patientId];
  }

  void sauvegarderAntecedents(String patientId, AntecedentsMedicaux antecedents) {
    _antecedentsMedicaux[patientId] = antecedents;
    notifyListeners();
  }

  void mettreAJourAntecedents(String patientId, AntecedentsMedicaux antecedents) {
    _antecedentsMedicaux[patientId] = antecedents;
    notifyListeners();
  }

  bool existeAntecedents(String patientId) {
    return _antecedentsMedicaux.containsKey(patientId);
  }
}
