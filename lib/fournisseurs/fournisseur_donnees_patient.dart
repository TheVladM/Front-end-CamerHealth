import 'package:flutter/material.dart';

/// Fournisseur partagé pour les données physiques du patient
/// (poids, taille) — utilisé à la fois dans les antécédents et les données vitales.
class FournisseurDonneesPatient extends ChangeNotifier {
  double? _poids; // kg
  double? _taille; // cm

  double? get poids => _poids;
  double? get taille => _taille;

  String get poidsAffiche =>
      _poids != null ? '${_poids!.toStringAsFixed(0)}' : '--';
  String get tailleAffichee =>
      _taille != null ? '${_taille!.toStringAsFixed(0)}' : '--';

  void mettreAJour({double? poids, double? taille}) {
    if (poids != null) _poids = poids;
    if (taille != null) _taille = taille;
    notifyListeners();
  }
}
