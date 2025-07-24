// lib/presentation/bloc/document_event.dart

import 'package:equatable/equatable.dart';

abstract class DocumentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDocuments extends DocumentEvent {}
