import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constantes/constantes_app.dart';
import '../fournisseurs/fournisseur_donnees_patient.dart';

class EcranAntecedentsMedicaux extends StatefulWidget {
  const EcranAntecedentsMedicaux({super.key});

  @override
  State<EcranAntecedentsMedicaux> createState() =>
      _EcranAntecedentsMedicauxState();
}

class _EcranAntecedentsMedicauxState extends State<EcranAntecedentsMedicaux> {
  final _formKey = GlobalKey<FormState>();

  final _allergiesController = TextEditingController();
  final _maladiesChroniquesController = TextEditingController();
  final _medicamentsController = TextEditingController();
  final _antecedentsFamiliauxController = TextEditingController();
  final _interventionsChirurgicalesController = TextEditingController();
  final _poidsController = TextEditingController();
  final _tailleController = TextEditingController();

  // Groupe sanguin — OPTIONNEL
  String? _groupeSanguinSelectionne;
  static const List<String> _groupesSanguins = [
    'A+',
    'A−',
    'B+',
    'B−',
    'AB+',
    'AB−',
    'O+',
    'O−',
  ];

  bool _fumeur = false;
  bool _alcool = false;
  bool _activitePhysique = false;

  @override
  void initState() {
    super.initState();
    // Pré-remplir poids/taille depuis le fournisseur partagé
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final donnees = context.read<FournisseurDonneesPatient>();
      if (donnees.poids != null) {
        _poidsController.text = donnees.poids!.toStringAsFixed(0);
      }
      if (donnees.taille != null) {
        _tailleController.text = donnees.taille!.toStringAsFixed(0);
      }
    });
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _maladiesChroniquesController.dispose();
    _medicamentsController.dispose();
    _antecedentsFamiliauxController.dispose();
    _interventionsChirurgicalesController.dispose();
    _poidsController.dispose();
    _tailleController.dispose();
    super.dispose();
  }

  void _sauvegarderAntecedents() {
    if (!_formKey.currentState!.validate()) return;

    // Synchroniser poids/taille avec le fournisseur partagé
    final donnees = context.read<FournisseurDonneesPatient>();
    final p = double.tryParse(_poidsController.text);
    final t = double.tryParse(_tailleController.text);
    if (p != null || t != null) {
      donnees.mettreAJour(poids: p, taille: t);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Antécédents médicaux sauvegardés')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antécédents Médicaux'),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Veuillez remplir vos antécédents médicaux',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),

                // ── Groupe sanguin — OPTIONNEL ─────────────────────────
                Row(
                  children: [
                    _buildSectionTitre('Groupe sanguin'),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Optionnel',
                        style: TextStyle(
                          fontSize: 11,
                          color: ConstantesApp.couleurTexteClair,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _groupeSanguinSelectionne,
                  decoration: _inputDecoration(
                    'Sélectionnez votre groupe sanguin',
                  ),
                  items: _groupesSanguins
                      .map((gs) => DropdownMenuItem(value: gs, child: Text(gs)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _groupeSanguinSelectionne = val),
                  // Pas de validator : champ optionnel
                ),
                const SizedBox(height: 16),

                // ── Poids & Taille — synchronisés avec données vitales ──
                Row(
                  children: [
                    _buildSectionTitre('Poids & Taille'),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.sync,
                      size: 14,
                      color: ConstantesApp.couleurPrimaire,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Données vitales',
                      style: TextStyle(
                        fontSize: 11,
                        color: ConstantesApp.couleurPrimaire,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _poidsController,
                        decoration: _inputDecoration(
                          'Ex: 70',
                        ).copyWith(labelText: 'Poids', suffixText: 'kg'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) return null;
                          final n = int.tryParse(val);
                          if (n == null || n < 20 || n > 300) return 'Invalide';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _tailleController,
                        decoration: _inputDecoration(
                          'Ex: 175',
                        ).copyWith(labelText: 'Taille', suffixText: 'cm'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (val) {
                          if (val == null || val.isEmpty) return null;
                          final n = int.tryParse(val);
                          if (n == null || n < 50 || n > 250) return 'Invalide';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                _buildSectionTitre('Allergies'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _allergiesController,
                  decoration: _inputDecoration('Ex: Pénicilline, arachides...'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                _buildSectionTitre('Maladies chroniques'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _maladiesChroniquesController,
                  decoration: _inputDecoration('Ex: Diabète, hypertension...'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                _buildSectionTitre('Médicaments actuels'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _medicamentsController,
                  decoration: _inputDecoration(
                    'Liste des médicaments que vous prenez',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                _buildSectionTitre('Antécédents familiaux'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _antecedentsFamiliauxController,
                  decoration: _inputDecoration(
                    'Ex: Cancer, maladies cardiaques...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                _buildSectionTitre('Interventions chirurgicales'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _interventionsChirurgicalesController,
                  decoration: _inputDecoration('Liste des opérations subies'),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                _buildSectionTitre('Habitudes de vie'),
                const SizedBox(height: 8),
                _buildCheckTile(
                  'Fumeur',
                  Icons.smoking_rooms,
                  _fumeur,
                  (v) => setState(() => _fumeur = v ?? false),
                ),
                _buildCheckTile(
                  'Consommation d\'alcool',
                  Icons.liquor,
                  _alcool,
                  (v) => setState(() => _alcool = v ?? false),
                ),
                _buildCheckTile(
                  'Activité physique régulière',
                  Icons.directions_run,
                  _activitePhysique,
                  (v) => setState(() => _activitePhysique = v ?? false),
                ),
                const SizedBox(height: 28),

                ElevatedButton(
                  onPressed: _sauvegarderAntecedents,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantesApp.couleurPrimaire,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitre(String titre) => Text(
    titre,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );

  Widget _buildCheckTile(
    String label,
    IconData icon,
    bool value,
    void Function(bool?) onChanged,
  ) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.grey.shade200),
    ),
    child: CheckboxListTile(
      secondary: Icon(icon, color: ConstantesApp.couleurPrimaire),
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: ConstantesApp.couleurPrimaire,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
