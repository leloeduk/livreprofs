class Document {
  final int id;
  final String titre;
  final String fichierUrl;
  final Map<String, dynamic> matiere;
  final String typeFichier;
  final String author;
  final String dateUpload;
  final int nombreTelechargements;

  Document({
    required this.id,
    required this.titre,
    required this.fichierUrl,
    required this.matiere,
    required this.typeFichier,
    this.author = "Anonyme",
    required this.dateUpload,
    required this.nombreTelechargements,
  });
}
