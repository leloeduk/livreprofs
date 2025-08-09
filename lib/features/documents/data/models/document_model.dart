import '../../domain/entities/document.dart';

class DocumentModel extends Document {
  DocumentModel({
    required super.id,
    required super.titre,
    required super.fichierUrl,
    required super.matiere,
    required super.typeFichier,
    super.author,
    required super.dateUpload,
    required super.nombreTelechargements,
  });

  /// Factory pour convertir un JSON en modèle
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as int,
      titre: json['titre'] as String,
      fichierUrl: json['fichier_url'] as String, // snake_case corrigé
      matiere: Map<String, dynamic>.from(json['matiere'] ?? {}),
      typeFichier: json['type_fichier'] as String, // snake_case corrigé
      author: json['auteur'] ?? "Anonyme", // snake_case corrigé
      dateUpload: json['date_upload'] as String, // snake_case corrigé
      nombreTelechargements:
          json['nombre_telechargements'] as int, // snake_case corrigé
    );
  }

  /// Méthode pour convertir le modèle en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'fichierUrl': fichierUrl,
      'matiere': matiere,
      'typeFichier': typeFichier,
      'author': author,
      'dateUpload': dateUpload,
      'nombreTelechargements': nombreTelechargements,
    };
  }
}
