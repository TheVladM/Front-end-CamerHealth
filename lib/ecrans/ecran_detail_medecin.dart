import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/medecin.dart';

class EcranDetailMedecin extends StatelessWidget {
  final Medecin medecin;

  const EcranDetailMedecin({Key? key, required this.medecin}) : super(key: key);

  ImageProvider _getImageProvider(String? photoUrl) {
    if (photoUrl != null && photoUrl.startsWith('assets/')) {
      return AssetImage(photoUrl);
    }
    return NetworkImage(
      photoUrl ?? 'https://placehold.co/400x250/1A73E8/FFFFFF?text=Dr',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ─── AppBar avec bouton retour ────────────────────────────────────────
      appBar: AppBar(
        title: Text(
          medecin.nom,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Photo du médecin ──────────────────────────────────────────
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _getImageProvider(medecin.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Dégradé en bas de l'image
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Nom + Spécialité ────────────────────────────────────
                  Text(
                    medecin.nom,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medecin.specialisation?.nom ?? 'Spécialité inconnue',
                    style: TextStyle(
                      fontSize: 15,
                      color: ConstantesApp.couleurPrimaire,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Stats (note, expérience, adresse) ──────────────────
                  Row(
                    children: [
                      _buildStatChip(
                        Icons.star,
                        '${medecin.note}',
                        Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      _buildStatChip(
                        Icons.work_outline,
                        '${medecin.experience} ans',
                        ConstantesApp.couleurPrimaire,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildStatChip(
                          Icons.location_on_outlined,
                          medecin.adresse,
                          ConstantesApp.couleurSecondaire,
                          ellipsis: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Description ─────────────────────────────────────────
                  const Text(
                    'À propos',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medecin.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: ConstantesApp.couleurTexteClair,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Contact ─────────────────────────────────────────────
                  const Text(
                    'Contact',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildContactTile(
                    Icons.phone_outlined,
                    medecin.telephone,
                    ConstantesApp.couleurSecondaire,
                  ),
                  const SizedBox(height: 8),
                  _buildContactTile(
                    Icons.email_outlined,
                    medecin.email,
                    ConstantesApp.couleurPrimaire,
                  ),
                  const SizedBox(height: 28),

                  // ── Paiement ────────────────────────────────────────────
                  const Text(
                    'Mode de paiement',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBoutonPaiement(
                          context,
                          'assets/orange.png',
                          Colors.orange,
                          'Orange Money',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildBoutonPaiement(
                          context,
                          'assets/mtn.png',
                          Colors.yellow.shade700,
                          'MTN Money',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Bouton prendre RDV ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Prise de RDV — fonctionnalité à venir',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text(
                        'Prendre un rendez-vous',
                        style: TextStyle(fontSize: 16),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(
    IconData icon,
    String label,
    Color color, {
    bool ellipsis = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: ellipsis ? MainAxisSize.min : MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          ellipsis
              ? Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoutonPaiement(
    BuildContext context,
    String asset,
    Color borderColor,
    String label,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paiement $label — à implémenter')),
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
