// lib/data/repositories/document_repository_impl.dart
import 'package:livreprofs/features/documents/data/datasources/document_remote_data_source.dart';

import '../../domain/entities/document.dart';
import '../../domain/repositories/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentRemoteDataSource remoteDataSource;

  DocumentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Document>> getDocuments() async {
    return await remoteDataSource.fetchDocuments();
  }
}
