import 'dart:async';
import 'package:flutter/material.dart';
import '../constantes/constantes_app.dart';

class EcranOuverture extends StatefulWidget {
  @override
  _EcranOuvertureState createState() => _EcranOuvertureState();
}

class _EcranOuvertureState extends State<EcranOuverture> {
  @override
  void initState() {
    super.initState();
    // Navigue vers la première page après 10 secondes
    Timer(Duration(seconds: 20), () {
      Navigator.of(context).pushReplacementNamed('/accueil'); // Remplace '/accueil' par la route de ta première page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
          // Image de fond en bas à partir du milieu
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/3.png',
              width: double.infinity,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.5, // Prend la moitié de la hauteur de l'écran
              //color: Colors.white.withOpacity(0.1),
              colorBlendMode: BlendMode.overlay,
            ),
          ),
          // Contenu principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4FC3F7),
                      Color(0xFF0D47A1),
                    ],
                    transform: GradientRotation(70 * 3.14159 / 180),
                  ).createShader(bounds),
                  child: Text(
                    ConstantesApp.nomApp,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // ⚠️ Obligatoire pour que ShaderMask fonctionne
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 110),
                //Spacer(),
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 50),
                
                // Loading avec trois points oscillants
                _LoadingDots(),
                SizedBox(height: 10),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}

// Widget pour l'animation des trois points oscillants
class _LoadingDots extends StatefulWidget {
  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // Calculer le délai pour chaque point
            final delay = index * 0.33;
            final value = ((_controller.value - delay) % 1.0 + 1.0) % 1.0;
            // Animation d'oscillation entre 0 et 1
            final opacity = (value < 0.5) ? value * 2 : 2 - (value * 2);
            final scale = 0.5 + (opacity * 0.5);

            return Transform.scale(
              scale: scale,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5 + (opacity * 0.5)),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}