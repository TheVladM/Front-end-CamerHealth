import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';
import '../modeles/medecin.dart';
import 'ecran_detail_medecin.dart';

class EcranListeMedecins extends StatefulWidget {
  const EcranListeMedecins({Key? key}) : super(key: key);

  @override
  State<EcranListeMedecins> createState() => _EcranListeMedecinsState();
}

class _EcranListeMedecinsState extends State<EcranListeMedecins> {
  String _recherche = '';

  List<Medecin> get _medecinsFiltres {
    if (_recherche.isEmpty) return Medecin.medecinsMock;
    return Medecin.medecinsMock
        .where(
          (m) =>
              m.nom.toLowerCase().contains(_recherche.toLowerCase()) ||
              (m.specialisation?.nom.toLowerCase().contains(
                    _recherche.toLowerCase(),
                  ) ??
                  false),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Médecins disponibles',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: ConstantesApp.couleurPrimaire,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Header coloré avec barre de recherche ───────────────────────
          Container(
            color: ConstantesApp.couleurPrimaire,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trouvez le bon spécialiste',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => _recherche = val),
                    decoration: InputDecoration(
                      hintText: 'Nom, spécialité...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ConstantesApp.couleurPrimaire,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Compteur résultats ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_medecinsFiltres.length} médecin(s)',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'Trier par note',
                  style: TextStyle(
                    color: ConstantesApp.couleurPrimaire,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ── Grille médecins ─────────────────────────────────────────────
          Expanded(
            child: _medecinsFiltres.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Aucun médecin trouvé',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.72,
                        ),
                    itemCount: _medecinsFiltres.length,
                    itemBuilder: (context, index) {
                      return _CarteMedecin(
                        medecin: _medecinsFiltres[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EcranDetailMedecin(
                              medecin: _medecinsFiltres[index],
                            ),
                          ),
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

// ─── Carte médecin améliorée ───────────────────────────────────────────────

class _CarteMedecin extends StatelessWidget {
  final Medecin medecin;
  final VoidCallback onTap;

  const _CarteMedecin({required this.medecin, required this.onTap});

  ImageProvider _getImage(String? url) {
    if (url != null && url.startsWith('assets/')) return AssetImage(url);
    return NetworkImage(
      url ?? 'https://placehold.co/150x150/1A73E8/FFFFFF?text=Dr',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo avec badge note
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image(
                    image: _getImage(medecin.photoUrl),
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      color: ConstantesApp.couleurPrimaire.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: ConstantesApp.couleurPrimaire,
                      ),
                    ),
                  ),
                ),
                // Badge note
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 13),
                        const SizedBox(width: 2),
                        Text(
                          medecin.note.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Contenu texte
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medecin.nom,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    medecin.specialisation?.nom ?? '—',
                    style: TextStyle(
                      fontSize: 11,
                      color: ConstantesApp.couleurPrimaire,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 11,
                        color: ConstantesApp.couleurTexteClair,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          medecin.adresse,
                          style: TextStyle(
                            fontSize: 10,
                            color: ConstantesApp.couleurTexteClair,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Bouton consulter
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: ConstantesApp.couleurPrimaire,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Consulter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
}
