// lib/domain/repositories/document_repository.dart

import '../entities/document.dart';

abstract class DocumentRepository {
  Future<List<Document>> getDocuments();
}
