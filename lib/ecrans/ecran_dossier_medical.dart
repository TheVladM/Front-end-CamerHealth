import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constantes/constantes_app.dart';
import '../modeles/patient.dart';
import '../fournisseurs/fournisseur_antecedents_medicaux.dart';

class EcranDossierMedical extends StatelessWidget {
  final Patient patient;

  const EcranDossierMedical({super.key, required this.patient});

  Widget _buildInfoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: ConstantesApp.couleurTexteClair,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: ConstantesApp.couleurTexteFonce,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: ConstantesApp.couleurPrimaire,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: ConstantesApp.couleurTexteFonce,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitItem(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: ConstantesApp.couleurTexteFonce,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dossier Médical - ${patient.nom}'),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Consumer<FournisseurAntecedentsMedicaux>(
            builder: (context, antecedentsProvider, _) {
              final antecedents = antecedentsProvider.obtenirAntecedents(patient.id);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informations du patient
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ConstantesApp.couleurPrimaire, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informations du Patient',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoLine('Nom', patient.nom),
                        _buildInfoLine('ID', patient.id),
                        _buildInfoLine('Groupe Sanguin', antecedents?.groupeSanguin ?? 'Non renseigné'),
                        _buildInfoLine('Poids', antecedents?.poids != null ? '${antecedents?.poids?.toStringAsFixed(0) ?? '0'} kg' : 'Non renseigné'),
                        _buildInfoLine('Taille', antecedents?.taille != null ? '${antecedents?.taille?.toStringAsFixed(0) ?? '0'} cm' : 'Non renseigné'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Allergies
                  if (antecedents?.allergies != null && antecedents!.allergies!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Allergies',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red[300]!, width: 1),
                          ),
                          child: _buildBulletPoint(antecedents.allergies!),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // Antécédents médicaux
                  if (antecedents?.maladiesChroniques != null && antecedents!.maladiesChroniques!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Antécédents Médicaux',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBulletPoint(antecedents.maladiesChroniques!),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // Antécédents familiaux
                  if (antecedents?.antecedentsFamiliaux != null && antecedents!.antecedentsFamiliaux!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Antécédents Familiaux',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _buildBulletPoint(antecedents.antecedentsFamiliaux!),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // Interventions chirurgicales
                  if (antecedents?.interventionsChirurgicales != null && antecedents!.interventionsChirurgicales!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interventions Chirurgicales',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _buildBulletPoint(antecedents.interventionsChirurgicales!),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // Traitements actuels
                  if (antecedents?.medicaments != null && antecedents!.medicaments!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Traitements Actuels',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _buildBulletPoint(antecedents.medicaments!),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // Habitudes de vie
                  if (antecedents != null && (antecedents.fumeur || antecedents.alcool || antecedents.activitePhysique))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Habitudes de Vie',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantesApp.couleurTexteFonce,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (antecedents.fumeur)
                                _buildHabitItem('Fumeur', Icons.smoking_rooms, Colors.orange),
                              if (antecedents.alcool)
                                _buildHabitItem('Consommation d\'alcool', Icons.liquor, Colors.red),
                              if (antecedents.activitePhysique)
                                _buildHabitItem('Activité physique régulière', Icons.directions_run, Colors.green),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),

                  if (antecedents == null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Aucun antécédent médical renseigné',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
