class AntecedentsMedicaux {
  final String? groupeSanguin;
  final double? poids;
  final double? taille;
  final String? allergies;
  final String? maladiesChroniques;
  final String? medicaments;
  final String? antecedentsFamiliaux;
  final String? interventionsChirurgicales;
  final bool fumeur;
  final bool alcool;
  final bool activitePhysique;

  AntecedentsMedicaux({
    this.groupeSanguin,
    this.poids,
    this.taille,
    this.allergies,
    this.maladiesChroniques,
    this.medicaments,
    this.antecedentsFamiliaux,
    this.interventionsChirurgicales,
    this.fumeur = false,
    this.alcool = false,
    this.activitePhysique = false,
  });

  // Copier avec modifications
  AntecedentsMedicaux copyWith({
    String? groupeSanguin,
    double? poids,
    double? taille,
    String? allergies,
    String? maladiesChroniques,
    String? medicaments,
    String? antecedentsFamiliaux,
    String? interventionsChirurgicales,
    bool? fumeur,
    bool? alcool,
    bool? activitePhysique,
  }) {
    return AntecedentsMedicaux(
      groupeSanguin: groupeSanguin ?? this.groupeSanguin,
      poids: poids ?? this.poids,
      taille: taille ?? this.taille,
      allergies: allergies ?? this.allergies,
      maladiesChroniques: maladiesChroniques ?? this.maladiesChroniques,
      medicaments: medicaments ?? this.medicaments,
      antecedentsFamiliaux: antecedentsFamiliaux ?? this.antecedentsFamiliaux,
      interventionsChirurgicales: interventionsChirurgicales ?? this.interventionsChirurgicales,
      fumeur: fumeur ?? this.fumeur,
      alcool: alcool ?? this.alcool,
      activitePhysique: activitePhysique ?? this.activitePhysique,
    );
  }
}
