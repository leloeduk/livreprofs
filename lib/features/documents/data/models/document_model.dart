import '../../domain/entities/document.dart';
import 'package:flutter/material.dart';

class DocumentModel extends Document {
  DocumentModel({
    required String id,
    required String title,
    required String subject,
    required DateTime date,
    required String fileType,
    String author = "Anonyme",
    required Color cardColor,
  }) : super(
         id: id,
         title: title,
         subject: subject,
         date: date,
         fileType: fileType,
         author: author,
         cardColor: cardColor,
       );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'].toString(),
      title: json['titre'],
      subject: json['matiere'],
      date: DateTime.parse(json['date_upload']),
      fileType: json['type_fichier'],
      author: json['auteur'] ?? "Anonyme",
      cardColor: _colorFromHex(json['couleur'] ?? '#1565C0'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'titre': title,
    'matiere': subject,
    'date_upload': date.toIso8601String(),
    'type_fichier': fileType,
    'auteur': author,
    'couleur': '#${cardColor.value.toRadixString(16).substring(2)}',
  };

  static Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // ajouter opacité si absente
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
