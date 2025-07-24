// lib/presentation/bloc/document_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'document_event.dart';
import 'document_state.dart';
import '../../domain/usecases/get_documents.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetDocuments getDocuments;

  DocumentBloc(this.getDocuments) : super(DocumentInitial()) {
    on<LoadDocuments>((event, emit) async {
      emit(DocumentLoading());
      try {
        final documents = await getDocuments();
        emit(DocumentLoaded(documents));
      } catch (e) {
        emit(DocumentError(e.toString()));
      }
    });
  }
}
