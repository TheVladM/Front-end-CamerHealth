import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/patient.dart';
import '../modeles/medecin.dart';
import 'ecran_visualisation_rapport.dart';

class EcranRapportMedecin extends StatefulWidget {
  final Patient patient;
  final Medecin medecin;

  const EcranRapportMedecin({
    Key? key,
    required this.patient,
    required this.medecin,
  }) : super(key: key);

  @override
  State<EcranRapportMedecin> createState() => _EcranRapportMedecinState();
}

class _EcranRapportMedecinState extends State<EcranRapportMedecin> {
  final _formKey = GlobalKey<FormState>();
  final _observationsController = TextEditingController();
  final _resultatsController = TextEditingController();
  final _conclusionsController = TextEditingController();
  
  List<Map<String, String>> _ordonnances = [];
  final _nomMedicamentController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequenceController = TextEditingController();

  @override
  void dispose() {
    _observationsController.dispose();
    _resultatsController.dispose();
    _conclusionsController.dispose();
    _nomMedicamentController.dispose();
    _dosageController.dispose();
    _frequenceController.dispose();
    super.dispose();
  }

  void _ajouterOrdonnance() {
    if (_nomMedicamentController.text.isNotEmpty &&
        _dosageController.text.isNotEmpty &&
        _frequenceController.text.isNotEmpty) {
      setState(() {
        _ordonnances.add({
          'nom': _nomMedicamentController.text,
          'dosage': _dosageController.text,
          'frequence': _frequenceController.text,
        });
      });
      _nomMedicamentController.clear();
      _dosageController.clear();
      _frequenceController.clear();
      Navigator.pop(context);
    }
  }

  void _supprimerOrdonnance(int index) {
    setState(() {
      _ordonnances.removeAt(index);
    });
  }

  void _visualiserRapport() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EcranVisualisationRapport(
          patient: widget.patient,
          medecin: widget.medecin,
          observations: _observationsController.text,
          resultats: _resultatsController.text,
          conclusions: _conclusionsController.text,
          ordonnances: _ordonnances,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapport Médical'),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Infos Patient ──────────────────────────────────
                _buildSection(
                  'Informations du Patient',
                  [
                    _buildInfoLine('Nom', widget.patient.nom),
                    _buildInfoLine('ID Patient', widget.patient.id),
                    _buildInfoLine('Groupe Sanguin', 'B positif'),
                    _buildInfoLine('Allergies', 'Pénicilline, Arachides'),
                  ],
                ),

                const SizedBox(height: 24),

                // ─── Infos Médecin ──────────────────────────────────
                _buildSection(
                  'Informations du Médecin',
                  [
                    _buildInfoLine('Nom', 'Dr. ${widget.medecin.nom}'),
                    _buildInfoLine('Spécialité', widget.medecin.specialisation?.nom ?? 'Spécialiste'),
                    _buildInfoLine('Email', widget.medecin.email),
                    _buildInfoLine('Téléphone', widget.medecin.telephone),
                  ],
                ),

                const SizedBox(height: 24),

                // ─── Observations ───────────────────────────────────
                _buildFormSection(
                  'Observations',
                  TextFormField(
                    controller: _observationsController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Décrivez vos observations...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Les observations sont requises';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ─── Résultats ──────────────────────────────────────
                _buildFormSection(
                  'Résultats',
                  TextFormField(
                    controller: _resultatsController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Décrivez les résultats des examens...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Les résultats sont requis';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ─── Conclusions ────────────────────────────────────
                _buildFormSection(
                  'Conclusions',
                  TextFormField(
                    controller: _conclusionsController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Décrivez vos conclusions...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Les conclusions sont requises';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ─── Ordonnances ────────────────────────────────────
                Text(
                  'Ordonnances (Optionnel)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ConstantesApp.couleurTexteFonce,
                  ),
                ),
                const SizedBox(height: 12),

                if (_ordonnances.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: List.generate(
                        _ordonnances.length,
                        (index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _ordonnances[index]['nom'] ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${_ordonnances[index]['dosage']} - ${_ordonnances[index]['frequence']}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _supprimerOrdonnance(index),
                                ),
                              ],
                            ),
                            if (index < _ordonnances.length - 1)
                              Divider(color: Colors.grey[300]),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // Bouton Ajouter Ordonnance
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _afficherDialogOrdonnance(),
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter une Ordonnance'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: ConstantesApp.couleurTexteFonce,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ─── Boutons d'action ───────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Annuler'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _visualiserRapport,
                        icon: const Icon(Icons.preview),
                        label: const Text('Visualiser'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantesApp.couleurPrimaire,
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

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String titre, List<Widget> contenu) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ConstantesApp.couleurPrimaire, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ConstantesApp.couleurPrimaire,
            ),
          ),
          const SizedBox(height: 12),
          ...contenu,
        ],
      ),
    );
  }

  Widget _buildFormSection(String titre, Widget contenu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titre,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ConstantesApp.couleurTexteFonce,
          ),
        ),
        const SizedBox(height: 12),
        contenu,
      ],
    );
  }

  Widget _buildInfoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 14,
                color: ConstantesApp.couleurTexteFonce,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _afficherDialogOrdonnance() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une Ordonnance'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomMedicamentController,
                decoration: InputDecoration(
                  labelText: 'Nom du médicament',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _dosageController,
                decoration: InputDecoration(
                  labelText: 'Dosage (ex: 500mg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _frequenceController,
                decoration: InputDecoration(
                  labelText: 'Fréquence (ex: 2x par jour)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: _ajouterOrdonnance,
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantesApp.couleurPrimaire,
            ),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
