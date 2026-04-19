import 'package:flutter/material.dart';
import '../modeles/message.dart';

class FournisseurChat extends ChangeNotifier {
  final Map<String, List<Message>> _conversations = {
    'NANTIA Axel': [
      Message(
        id: '1',
        expediteurId: 'medecin',
        destinataireId: 'patient',
        contenu: 'Suivez ce traitement encore une journée.',
        horodatage: DateTime.now().subtract(const Duration(hours: 9)),
        estLu: true,
      ),
      Message(
        id: '2',
        expediteurId: 'patient',
        destinataireId: 'medecin',
        contenu: 'Okay docteur.',
        horodatage: DateTime.now().subtract(const Duration(hours: 8, minutes: 51)),
        estLu: true,
      ),
      Message(
        id: '3',
        expediteurId: 'patient',
        destinataireId: 'medecin',
        contenu: 'Bonjour docteur. Mon test est négatif !',
        horodatage: DateTime.now().subtract(const Duration(hours: 3)),
        estLu: true,
      ),
      Message(
        id: '4',
        expediteurId: 'medecin',
        destinataireId: 'patient',
        contenu: 'Merci docteur',
        horodatage: DateTime.now().subtract(const Duration(hours: 2, minutes: 50)),
        estLu: true,
      ),
    ],
    'Tresor Brunel': [
      Message(
        id: '5',
        expediteurId: 'medecin',
        destinataireId: 'patient',
        contenu: 'Ok',
        horodatage: DateTime.now().subtract(const Duration(hours: 5)),
        estLu: true,
      ),
    ],
    'Doumbe Cedric': [
      Message(
        id: '6',
        expediteurId: 'medecin',
        destinataireId: 'patient',
        contenu: 'Ok Doc. J\'attends l\'entretien',
        horodatage: DateTime.now().subtract(const Duration(hours: 7, minutes: 30)),
        estLu: true,
      ),
    ],
  };

  List<Map<String, dynamic>> getApercusDiscussions() {
    return _conversations.entries.map((entry) {
      final dernierMessage = entry.value.last;
      return {
        'nom': entry.key,
        'dernierMessage': dernierMessage.contenu,
        'heure': dernierMessage.tempsRelatif,
        'estEnLigne': entry.key == 'NANTIA Axel',
      };
    }).toList();
  }

  List<Message> getMessages(String nomContact) {
    return _conversations[nomContact] ?? [];
  }

  void envoyerMessage(String nomContact, String contenu, {bool estDeMedecin = true}) {
    final nouveauMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      expediteurId: estDeMedecin ? 'medecin' : 'patient',
      destinataireId: estDeMedecin ? 'patient' : 'medecin',
      contenu: contenu,
      horodatage: DateTime.now(),
      estLu: true,
    );
    
    if (_conversations.containsKey(nomContact)) {
      _conversations[nomContact]!.add(nouveauMessage);
    } else {
      _conversations[nomContact] = [nouveauMessage];
    }
    notifyListeners();
  }
}
