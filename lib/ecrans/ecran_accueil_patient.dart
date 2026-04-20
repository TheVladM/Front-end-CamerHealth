import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constantes/constantes_app.dart';
import '../fournisseurs/fournisseur_auth.dart';
import 'ecran_statistiques.dart';
import 'ecran_prevention.dart';
import 'ecran_symptomes.dart';
import 'ecran_donnees_vitales.dart';
import 'ecran_joindre_medecin.dart';
import 'ecran_rapport.dart';
import 'ecran_compte.dart';
import 'ecran_liste_discussions.dart';

class EcranAccueilPatient extends StatefulWidget {
  const EcranAccueilPatient({super.key});

  @override
  State<EcranAccueilPatient> createState() => _EcranAccueilPatientState();
}

class _EcranAccueilPatientState extends State<EcranAccueilPatient> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Plus de Drawer — navigation uniquement via la bottom bar
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _AccueilBody(),
          const EcranDonneesVitales(),
          const EcranListeDiscussions(),
          const EcranCompte(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.08),
        indicatorColor: ConstantesApp.couleurPrimaire.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: ConstantesApp.couleurPrimaire,
            ),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite, color: Color(0xFFE53935)),
            label: 'Vitales',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(
              Icons.chat_bubble,
              color: ConstantesApp.couleurPrimaire,
            ),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.person,
              color: ConstantesApp.couleurPrimaire,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Corps de l'écran d'accueil patient
class _AccueilBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FournisseurAuth>(context);
    final prenom = authProvider.utilisateurActuel?.nomUtilisateur ?? 'Patient';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(prenom),
            const SizedBox(height: 20),
            _buildCapteurCard(),
            const SizedBox(height: 20),
            _buildSectionConstantesVitales(),
            const SizedBox(height: 24),
            const Text(
              'Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ConstantesApp.couleurTexteClair,
              ),
            ),
            const SizedBox(height: 12),
            _buildServicesGrid(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(String prenom) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              ConstantesApp.salutation,
              style: TextStyle(
                fontSize: 14,
                color: ConstantesApp.couleurTexteClair,
              ),
            ),
            Text(
              prenom,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        _buildNotificationBell(),
      ],
    );
  }

  Widget _buildNotificationBell() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 24,
              color: ConstantesApp.couleurSecondaire,
            ),
            onPressed: () {},
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFEA4335),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // ─── Carte Capteur IoT ─────────────────────────────────────────────────────

  Widget _buildCapteurCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ConstantesApp.couleurPrimaire.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.bluetooth,
              color: ConstantesApp.couleurPrimaire,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Google pixel watch 1',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(height: 2),
                Text(
                  'Connecté et actif',
                  style: TextStyle(
                    color: Color(0xFF34A853),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: ConstantesApp.couleurPrimaire,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ─── Constantes Vitales ────────────────────────────────────────────────────

  Widget _buildSectionConstantesVitales() {
    return Column(
      children: [
        // Titre de section + indicateur "En direct"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Constantes Vitales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34A853),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'En direct',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF34A853),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // BPM + SpO2 côte à côte
        Row(
          children: [
            Expanded(child: _buildCarteBPM()),
            const SizedBox(width: 12),
            Expanded(child: _buildCarteNbrePas()),
          ],
        ),
        const SizedBox(height: 12),
        // Température pleine largeur
        _buildCarteTemperature(),
      ],
    );
  }

  Widget _buildCarteBPM() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _carteDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconeVitale(Icons.favorite, const Color(0xFFE53935)),
              const SizedBox(width: 6),
              const Text(
                'Nbre BPM',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: ConstantesApp.couleurTexteClair,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '72',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              _badgeStatut('Normal', const Color(0xFF34A853)),
            ],
          ),
          const SizedBox(height: 10),
          // Mini courbe (sparkline statique — sera animée avec les données IoT)
          SizedBox(
            height: 28,
            child: CustomPaint(
              size: const Size(double.infinity, 28),
              painter: _SparklinePainter(color: const Color(0xFFE53935)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarteNbrePas() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _carteDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconeVitale(Icons.directions_run, const Color(0xFF00ACC1)),
              const SizedBox(width: 6),
              const Text(
                'Pas journaliers',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: ConstantesApp.couleurTexteClair,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '98',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                'pas',
                style: TextStyle(
                  fontSize: 16,
                  color: ConstantesApp.couleurTexteClair,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.98,
              backgroundColor: const Color(0xFF00ACC1).withOpacity(0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF00ACC1),
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildCarteTemperature() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _carteDecoration(),
      child: Row(
        children: [
          _iconeVitale(
            Icons.thermostat,
            const Color(0xFFFB8C00),
            size: 20,
            padding: 8,
          ),
          const SizedBox(width: 14),
          const Text(
            'Température corporelle',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ConstantesApp.couleurTexteClair,
            ),
          ),
          const Spacer(),
          const Text(
            '36.7°C',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ─── Grille de services ────────────────────────────────────────────────────

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      _ServiceItem(
        icon: Icons.assignment,
        label: 'Rapports',
        color: ConstantesApp.couleurPrimaire,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranRapport()),
        ),
      ),
      _ServiceItem(
        icon: Icons.bar_chart,
        label: 'Statistiques',
        color: const Color(0xFFFB8C00),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranStatistiques()),
        ),
      ),
      _ServiceItem(
        icon: Icons.shield,
        label: 'Prévention',
        color: ConstantesApp.couleurSecondaire,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranPrevention()),
        ),
      ),
      _ServiceItem(
        icon: Icons.sick,
        label: 'Symptômes',
        color: const Color(0xFF9C27B0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranSymptomes()),
        ),
      ),
      _ServiceItem(
        icon: Icons.medical_services,
        label: 'Médecin',
        color: const Color(0xFF00ACC1),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EcranJoindreMedecin()),
        ),
      ),
      _ServiceItem(
        icon: Icons.notifications_active,
        label: 'Alertes',
        color: ConstantesApp.couleurErreur,
        onTap: () {
          // TODO : EcranAlertes
        },
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.0,
      children: services.map(_buildCarteService).toList(),
    );
  }

  Widget _buildCarteService(_ServiceItem service) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: service.onTap,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: service.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(service.icon, color: service.color, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                service.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ConstantesApp.couleurTexteClair,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  BoxDecoration _carteDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: ConstantesApp.couleurOmbre.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _iconeVitale(
    IconData icon,
    Color color, {
    double size = 16,
    double padding = 6,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _badgeStatut(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─── Modèle interne pour les services ──────────────────────────────────────

class _ServiceItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ServiceItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

// ─── Sparkline statique (sera remplacée par des données IoT en temps réel) ──

class _SparklinePainter extends CustomPainter {
  final Color color;

  const _SparklinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Points représentant un rythme cardiaque typique (statiques pour l'instant)
    const points = [0.5, 0.45, 0.55, 0.2, 0.9, 0.3, 0.6, 0.45, 0.5];
    final path = Path();

    for (int i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * (1 - points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
