import 'package:flutter/material.dart';
import '../modeles/medecin.dart';

class HeaderMedecinProfile extends StatelessWidget {
  final Medecin medecin;
  final VoidCallback? onTap;

  const HeaderMedecinProfile({
    Key? key,
    required this.medecin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${medecin.nom}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                medecin.specialisation?.nom ?? 'Spécialiste',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(medecin.photoUrl ?? 'assets/doc1.jpg'),
          ),
        ],
      ),
    );
  }
}
