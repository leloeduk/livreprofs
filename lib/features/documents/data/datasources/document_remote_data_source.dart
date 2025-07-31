import 'package:dio/dio.dart';
import '../models/document_model.dart';

abstract class DocumentRemoteDataSource {
  /// Récupère la liste des documents depuis l'API
  Future<List<DocumentModel>> fetchDocuments();
}

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final Dio dio;

  DocumentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DocumentModel>> fetchDocuments() async {
    try {
      final response = await dio.get(
        'http://127.0.0.1:8000//api/documents/',
      ); // adapte l'URL API ici
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((json) => DocumentModel.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors du chargement des documents');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}
