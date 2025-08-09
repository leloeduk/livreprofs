import 'package:livreprofs/features/documents/domain/entities/document.dart';

import '../../domain/repositories/document_repository.dart';
import '../datasources/document_remote_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentRemoteDataSource remoteDataSource;

  DocumentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Document>> getDocuments() async {
    return await remoteDataSource.fetchDocuments();
  }
}
