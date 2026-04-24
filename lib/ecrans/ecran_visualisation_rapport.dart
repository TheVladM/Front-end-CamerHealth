import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/patient.dart';
import '../modeles/medecin.dart';

class EcranVisualisationRapport extends StatelessWidget {
  final Patient patient;
  final Medecin medecin;
  final String observations;
  final String resultats;
  final String conclusions;
  final List<Map<String, String>> ordonnances;

  const EcranVisualisationRapport({
    Key? key,
    required this.patient,
    required this.medecin,
    required this.observations,
    required this.resultats,
    required this.conclusions,
    required this.ordonnances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualisation du Rapport'),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── En-tête du Rapport ─────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ConstantesApp.couleurPrimaire,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'RAPPORT MÉDICAL',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ConstantesApp.couleurPrimaire,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CamerHealth',
                      style: const TextStyle(
                        fontSize: 14,
                        color: ConstantesApp.couleurTexteClair,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Divider(color: ConstantesApp.couleurPrimaire, thickness: 2),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              DateTime.now().toString().split(' ')[0],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Référence:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'RAP-${patient.id}-${DateTime.now().year}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ─── Informations Patient ───────────────────────────
              _buildSection(
                'INFORMATIONS DU PATIENT',
                [
                  _buildReportLine('Nom du Patient:', patient.nom),
                  _buildReportLine('ID Patient:', patient.id),
                  _buildReportLine('Groupe Sanguin:', 'B positif'),
                  _buildReportLine('Allergies:', 'Pénicilline, Arachides'),
                ],
              ),

              const SizedBox(height: 24),

              // ─── Informations Médecin ───────────────────────────
              _buildSection(
                'INFORMATIONS DU MÉDECIN',
                [
                  _buildReportLine('Nom du Médecin:', 'Dr. ${medecin.nom}'),
                  _buildReportLine('Spécialité:', medecin.specialisation?.nom ?? 'Spécialiste'),
                  _buildReportLine('Email:', medecin.email),
                  _buildReportLine('Téléphone:', medecin.telephone),
                  _buildReportLine('Adresse:', medecin.adresse),
                ],
              ),

              const SizedBox(height: 24),

              // ─── Observations ───────────────────────────────────
              _buildSection(
                'OBSERVATIONS',
                [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      observations,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: ConstantesApp.couleurTexteFonce,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ─── Résultats ──────────────────────────────────────
              _buildSection(
                'RÉSULTATS',
                [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      resultats,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: ConstantesApp.couleurTexteFonce,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ─── Conclusions ────────────────────────────────────
              _buildSection(
                'CONCLUSIONS',
                [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      conclusions,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: ConstantesApp.couleurTexteFonce,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ─── Ordonnances ────────────────────────────────────
              if (ordonnances.isNotEmpty)
                _buildSection(
                  'ORDONNANCES',
                  [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: List.generate(
                          ordonnances.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${index + 1}. ${ordonnances[index]['nom']}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: ConstantesApp.couleurTexteFonce,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Dosage: ${ordonnances[index]['dosage']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ConstantesApp.couleurTexteClair,
                                ),
                              ),
                              Text(
                                'Fréquence: ${ordonnances[index]['frequence']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ConstantesApp.couleurTexteClair,
                                ),
                              ),
                              if (index < ordonnances.length - 1)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(color: Colors.grey[300]),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // ─── Signature du Médecin ───────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey[400]!, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Signature du Médecin',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateTime.now().toString().split(' ')[0],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ─── Boutons d'action ───────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Retour'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Rapport sauvegardé avec succès'),
                            backgroundColor: ConstantesApp.couleurSecondaire,
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Sauvegarder'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ConstantesApp.couleurSecondaire,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Bouton Envoyer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rapport envoyé au patient'),
                        backgroundColor: ConstantesApp.couleurPrimaire,
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Envoyer au Patient'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFB8C00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String titre, List<Widget> contenu) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ConstantesApp.couleurPrimaire,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contenu,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ConstantesApp.couleurTexteFonce,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: ConstantesApp.couleurTexteClair,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
