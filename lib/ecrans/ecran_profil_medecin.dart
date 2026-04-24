import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/medecin.dart';
import 'ecran_informations_medecin.dart';

class EcranProfilMedecin extends StatelessWidget {
  final Medecin medecin;

  const EcranProfilMedecin({
    Key? key,
    required this.medecin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ConstantesApp.couleurPrimaire  ,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EcranInformationsMedecin(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.edit,
                  color: ConstantesApp.couleurPrimaire,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ─── Section photo et informations ──────────────────────
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Stack(
                  children: [
                    // Photo de profil - Plan arrière
                    Positioned.fill(
                      child: Image(
                        image: AssetImage(medecin.photoUrl ?? 'assets/doc1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Overlay dégradé - Plan arrière
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Informations du médecin - Plan avant
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Nom
                            Text(
                              ' ${medecin.nom}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            // Spécialité
                            Text(
                              medecin.specialisation?.nom ?? 'Spécialiste',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            // Ligne séparatrice
                            Container(
                              width: 60,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Section About ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ConstantesApp.couleurTexteFonce,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      medecin.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: ConstantesApp.couleurTexteClair,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),

              // ─── Section Information supplémentaire ─────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection('Experience', '${medecin.experience} years'),
                    const SizedBox(height: 16),
                    _buildInfoSection('Note', '${medecin.note}/5'),
                    const SizedBox(height: 16),
                    _buildInfoSection('Adresse', medecin.adresse),
                    const SizedBox(height: 16),
                    _buildInfoSection('Langue', medecin.langue),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ConstantesApp.couleurTexteClair,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ConstantesApp.couleurTexteFonce,
          ),
        ),
      ],
    );
  }
}
