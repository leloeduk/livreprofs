// lib/presentation/bloc/document_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/document.dart';

abstract class DocumentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentLoaded extends DocumentState {
  final List<Document> documents;

  DocumentLoaded(this.documents);

  @override
  List<Object?> get props => [documents];
}

class DocumentError extends DocumentState {
  final String message;

  DocumentError(this.message);

  @override
  List<Object?> get props => [message];
}
