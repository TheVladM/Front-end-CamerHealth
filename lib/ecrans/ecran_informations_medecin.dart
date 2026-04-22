import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constantes/constantes_app.dart';

class EcranInformationsMedecin extends StatefulWidget {
  const EcranInformationsMedecin({super.key});

  @override
  State<EcranInformationsMedecin> createState() =>
      _EcranInformationsMedecinState();
}

class _EcranInformationsMedecinState extends State<EcranInformationsMedecin> {
  final _formKey = GlobalKey<FormState>();

  final _numeroOrdreController = TextEditingController();
  final _hopitalController = TextEditingController();
  final _experienceController = TextEditingController();
  final _biographieController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();

  String? _specialiteSelectionnee;
  bool _disponible = true;
  bool _teleconsultation = false;

  static const List<String> _specialites = [
    'Généraliste',
    'Cardiologue',
    'Dentiste',
    'Dermatologue',
    'Endocrinologue',
    'Gastroentérologue',
    'Gynécologue',
    'Neurologue',
    'Ophtalmologue',
    'ORL',
    'Pédiatre',
    'Pneumologue',
    'Psychiatre',
    'Rhumatologue',
    'Pharmacien',
    'Autre',
  ];

  @override
  void dispose() {
    _numeroOrdreController.dispose();
    _hopitalController.dispose();
    _experienceController.dispose();
    _biographieController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  void _sauvegarder() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Informations professionnelles sauvegardées'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations du médecin'),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
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
                  'Renseignez vos informations professionnelles',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),

                // ── Spécialité (dropdown) ──────────────────────────────
                _buildSectionTitre('Spécialité médicale'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _specialiteSelectionnee,
                  decoration: _inputDecoration('Sélectionnez votre spécialité'),
                  items: _specialites
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _specialiteSelectionnee = val),
                  validator: (val) => val == null
                      ? 'Veuillez sélectionner une spécialité'
                      : null,
                ),
                const SizedBox(height: 16),

                // ── Numéro d'ordre ─────────────────────────────────────
                _buildSectionTitre('Numéro d\'ordre médical'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _numeroOrdreController,
                  decoration: _inputDecoration('Ex: CM-2024-001234'),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),

                // ── Années d'expérience ────────────────────────────────
                _buildSectionTitre('Années d\'expérience'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _experienceController,
                  decoration: _inputDecoration('Ex: 10'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Champ requis';
                    final n = int.tryParse(val);
                    if (n == null || n < 0 || n > 60) {
                      return 'Valeur invalide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // ── Hôpital / Clinique ─────────────────────────────────
                _buildSectionTitre('Hôpital / Clinique d\'exercice'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _hopitalController,
                  decoration: _inputDecoration(
                    'Ex: Hôpital Central de Yaoundé',
                  ),
                  validator: (val) =>
                      (val == null || val.isEmpty) ? 'Champ requis' : null,
                ),
                const SizedBox(height: 16),

                // ── Adresse du cabinet ─────────────────────────────────
                _buildSectionTitre('Adresse du cabinet'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _adresseController,
                  decoration: _inputDecoration('Ex: Bastos, Yaoundé'),
                ),
                const SizedBox(height: 16),

                // ── Téléphone professionnel ────────────────────────────
                _buildSectionTitre('Téléphone professionnel'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _telephoneController,
                  decoration: _inputDecoration('Ex: 699 000 000'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // ── Biographie / Présentation ──────────────────────────
                _buildSectionTitre('Biographie / Présentation'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _biographieController,
                  decoration: _inputDecoration(
                    'Présentez-vous en quelques lignes...',
                  ),
                  maxLines: 4,
                  maxLength: 500,
                ),
                const SizedBox(height: 12),

                // ── Options de disponibilité ───────────────────────────
                _buildSectionTitre('Disponibilité'),
                const SizedBox(height: 8),
                _buildSwitchTile(
                  'Disponible pour consultation',
                  Icons.event_available,
                  _disponible,
                  (v) => setState(() => _disponible = v),
                ),
                _buildSwitchTile(
                  'Téléconsultation disponible',
                  Icons.video_call,
                  _teleconsultation,
                  (v) => setState(() => _teleconsultation = v),
                ),
                const SizedBox(height: 28),

                // ── Bouton sauvegarder ─────────────────────────────────
                ElevatedButton(
                  onPressed: _sauvegarder,
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

  // ─── Helpers UI ────────────────────────────────────────────────────────────

  Widget _buildSectionTitre(String titre) {
    return Text(
      titre,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _buildSwitchTile(
    String label,
    IconData icon,
    bool value,
    void Function(bool) onChanged,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: ConstantesApp.couleurPrimaire),
        title: Text(label),
        value: value,
        onChanged: onChanged,
        activeColor: ConstantesApp.couleurPrimaire,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
