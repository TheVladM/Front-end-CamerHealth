class Message {
  final String id;
  final String expediteurId;
  final String destinataireId;
  final String contenu;
  final DateTime horodatage;
  final bool estLu;

  Message({
    required this.id,
    required this.expediteurId,
    required this.destinataireId,
    required this.contenu,
    required this.horodatage,
    this.estLu = false,
  });

  String get tempsRelatif {
    final maintenant = DateTime.now();
    final difference = maintenant.difference(horodatage);
    if (difference.inDays > 0) {
      return '${difference.inDays}j';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min';
    } else {
      return 'maintenant';
    }
  }
}
