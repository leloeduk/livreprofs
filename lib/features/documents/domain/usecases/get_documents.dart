import '../entities/document.dart';
import '../repositories/document_repository.dart';

class GetDocuments {
  final DocumentRepository repository;

  GetDocuments(this.repository);

  Future<List<Document>> call() async {
    return await repository.getDocuments();
  }
}
