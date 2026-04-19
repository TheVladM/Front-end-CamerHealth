import 'package:flutter/material.dart';

/// Écran pour enregistrer et visualiser les données vitales

class EcranDonneesVitales extends StatefulWidget {
  const EcranDonneesVitales({Key? key}) : super(key: key);

  @override
  State<EcranDonneesVitales> createState() => _EcranDonneesVitalesState();
}

class _EcranDonneesVitalesState extends State<EcranDonneesVitales> {
  final TextEditingController _controllerTension = TextEditingController();
  final TextEditingController _controllerTemperature = TextEditingController();
  final TextEditingController _controllerPouls = TextEditingController();
  final TextEditingController _controllerPoids = TextEditingController();

  @override
  void dispose() {
    _controllerTension.dispose();
    _controllerTemperature.dispose();
    _controllerPouls.dispose();
    _controllerPoids.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Données Vitales'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Enregistrer vos données vitales',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controllerTension,
                decoration: InputDecoration(
                  labelText: 'Tension (ex: 120/80)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerTemperature,
                decoration: InputDecoration(
                  labelText: 'Température (°C)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerPouls,
                decoration: InputDecoration(
                  labelText: 'Pouls (bpm)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerPoids,
                decoration: InputDecoration(
                  labelText: 'Poids (kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Enregistrer les données
                  },
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
