enum RoleUtilisateur {
  patient,
  medecin,
}

class Utilisateur {
  final String id;
  final String nomUtilisateur;
  final String email;
  final RoleUtilisateur role;
  final String? photoUrl;

  Utilisateur({
    required this.id,
    required this.nomUtilisateur,
    required this.email,
    required this.role,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': nomUtilisateur,
      'email': email,
      'role': role.name,
      'photoUrl': photoUrl,
    };
  }

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nomUtilisateur: json['username'],
      email: json['email'],
      role: json['role'] == 'patient' ? RoleUtilisateur.patient : RoleUtilisateur.medecin,
      photoUrl: json['photoUrl'],
    );
  }
}
