import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fournisseurs/fournisseur_stats.dart';
import '../constantes/constantes_app.dart';

class EcranStatistiques extends StatelessWidget {
  /// Si false, n'affiche pas de Scaffold/AppBar propre —
  /// utile quand l'écran est intégré dans un IndexedStack.
  final bool showAppBar;

  const EcranStatistiques({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final corps = Consumer<FournisseurStats>(
      builder: (context, statsProvider, _) {
        final stats = statsProvider.statsActuelles;
        final estGlobal = statsProvider.estGlobal;

        return SingleChildScrollView(
          child: Column(
            children: [
              // ── Sélecteur Région ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildBoutonRegion(
                        context,
                        titre: ConstantesApp.statsGlobal,
                        estSelectionne: estGlobal,
                        onTap: () {
                          if (!estGlobal) statsProvider.basculerRegion();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildBoutonRegion(
                        context,
                        titre: ConstantesApp.statsCameroun,
                        estSelectionne: !estGlobal,
                        onTap: () {
                          if (estGlobal) statsProvider.basculerRegion();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ── En-tête du tableau ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Indicateur',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Total',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Hier',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              _buildLigneStat(
                'Cas confirmés',
                stats['cas'],
                couleur: ConstantesApp.couleurAlerte,
              ),
              _buildLigneStat(
                'Décès',
                stats['deces'],
                couleur: ConstantesApp.couleurErreur,
              ),
              _buildLigneStat(
                'Guérisons',
                stats['guerisons'],
                couleur: ConstantesApp.couleurSecondaire,
              ),
              _buildLigneStat(
                'Actifs',
                stats['actifs'],
                couleur: ConstantesApp.couleurPrimaire,
              ),
              _buildLigneStat(
                'Critiques',
                stats['critiques'],
                couleur: Colors.deepOrange,
              ),

              const SizedBox(height: 20),

              // ── Carte taux de guérison ────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ConstantesApp.couleurSecondaire.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ConstantesApp.couleurSecondaire.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            ConstantesApp.tauxGuerison,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: ConstantesApp.couleurSecondaire,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${stats['tauxGuerison']}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (stats['tauxGuerison'] as num) / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: ConstantesApp.couleurSecondaire,
                          minHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${stats['guerisons']} guérisons sur ${stats['cas']} cas',
                        style: TextStyle(
                          fontSize: 12,
                          color: ConstantesApp.couleurTexteClair,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Pas d'AppBar propre si utilisé dans IndexedStack
    if (!showAppBar) {
      return SafeArea(child: corps);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques'), elevation: 0),
      body: corps,
    );
  }

  Widget _buildBoutonRegion(
    BuildContext context, {
    required String titre,
    required bool estSelectionne,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: estSelectionne
              ? ConstantesApp.couleurPrimaire
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: estSelectionne
                ? ConstantesApp.couleurPrimaire
                : Colors.grey.shade300,
          ),
        ),
        child: Text(
          titre,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: estSelectionne
                ? Colors.white
                : ConstantesApp.couleurTexteFonce,
            fontWeight: estSelectionne ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLigneStat(String label, dynamic valeur, {Color? couleur}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (couleur != null)
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: couleur,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(label, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Expanded(
            child: Text(
              _formaterNombre(valeur),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              '--',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _formaterNombre(dynamic valeur) {
    if (valeur is int) {
      if (valeur >= 1000000) {
        return '${(valeur / 1000000).toStringAsFixed(1)}M';
      } else if (valeur >= 1000) {
        return '${(valeur / 1000).toStringAsFixed(1)}k';
      }
    }
    return valeur.toString();
  }
}
