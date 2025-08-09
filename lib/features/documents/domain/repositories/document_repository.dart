import '../entities/document.dart';

abstract class DocumentRepository {
  Future<List<Document>> getDocuments();
}
