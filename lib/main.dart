import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:livreprofs/features/documents/data/datasources/document_remote_data_source.dart';
import 'package:livreprofs/features/documents/data/repositories/document_repository_impl.dart';
import 'package:livreprofs/features/documents/domain/usecases/get_documents.dart';
import 'package:livreprofs/features/documents/presentation/bloc/document_bloc.dart';
import 'package:livreprofs/features/documents/presentation/bloc/document_event.dart';
import 'package:livreprofs/features/documents/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();
  final dataSource = DocumentRemoteDataSourceImpl(dio);
  final repository = DocumentRepositoryImpl(dataSource);
  final getDocuments = GetDocuments(repository);

  runApp(MyApp(getDocuments: getDocuments));
}

class MyApp extends StatelessWidget {
  final GetDocuments getDocuments;

  const MyApp({super.key, required this.getDocuments});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeloBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocProvider(
        create: (_) => DocumentBloc(getDocuments)..add(LoadDocuments()),
        child: const HomePage(),
      ),
    );
  }
}
