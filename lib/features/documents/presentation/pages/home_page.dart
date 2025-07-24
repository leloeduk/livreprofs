import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/document_bloc.dart';
import '../bloc/document_event.dart';
import '../bloc/document_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DocumentBloc _documentBloc;

  @override
  void initState() {
    super.initState();
    _documentBloc = BlocProvider.of<DocumentBloc>(context);
    _documentBloc.add(LoadDocuments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espace Partage Scolaire')),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DocumentLoaded) {
            final documents = state.documents;
            if (documents.isEmpty) {
              return const Center(child: Text('Aucun document trouvé'));
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final doc = documents[index];
                return ListTile(
                  title: Text(doc.title),
                  subtitle: Text(doc.subject),
                  onTap: () {
                    // Naviguer vers détail document
                  },
                );
              },
            );
          } else if (state is DocumentError) {
            return Center(child: Text('Erreur: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
