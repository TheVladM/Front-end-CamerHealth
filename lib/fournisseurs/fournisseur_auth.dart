import 'package:flutter/material.dart';
import '../modeles/utilisateur.dart';

class FournisseurAuth extends ChangeNotifier {
  Utilisateur? _utilisateurActuel;
  bool _estConnecte = false;
  RoleUtilisateur _roleUtilisateur = RoleUtilisateur.patient;

  Utilisateur? get utilisateurActuel => _utilisateurActuel;
  bool get estConnecte => _estConnecte;
  RoleUtilisateur get roleUtilisateur => _roleUtilisateur;

  /// Simule une connexion et affecte le rôle utilisateur sélectionné.
  Future<bool> connexion(String email, String motDePasse, RoleUtilisateur role) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _utilisateurActuel = Utilisateur(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      nomUtilisateur: email.split('@').first,
      email: email,
      role: role,
    );
    _roleUtilisateur = role;
    _estConnecte = true;
    notifyListeners();
    return true;
  }

  Future<bool> inscription(String nomUtilisateur, String email, String motDePasse, RoleUtilisateur role) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    _utilisateurActuel = Utilisateur(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      nomUtilisateur: nomUtilisateur,
      email: email,
      role: role,
    );
    _roleUtilisateur = role;
    _estConnecte = true;
    notifyListeners();
    return true;
  }

  void deconnexion() {
    _utilisateurActuel = null;
    _estConnecte = false;
    notifyListeners();
  }

  void mettreAJourPhoto(String url) {
    if (_utilisateurActuel != null) {
      _utilisateurActuel = Utilisateur(
        id: _utilisateurActuel!.id,
        nomUtilisateur: _utilisateurActuel!.nomUtilisateur,
        email: _utilisateurActuel!.email,
        role: _utilisateurActuel!.role,
        photoUrl: url,
      );
      notifyListeners();
    }
  }

  void mettreAJourProfil(String nomUtilisateur, String email) {
    if (_utilisateurActuel != null) {
      _utilisateurActuel = Utilisateur(
        id: _utilisateurActuel!.id,
        nomUtilisateur: nomUtilisateur,
        email: email,
        role: _utilisateurActuel!.role,
        photoUrl: _utilisateurActuel!.photoUrl,
      );
      notifyListeners();
    }
  }

  Future<bool> changerMotDePasse(String nouveauMotDePasse) async {
    // Simule le changement de mot de passe
    await Future.delayed(const Duration(milliseconds: 500));
    // Dans une vraie app, on ferait un appel API
    return true;
  }
}
