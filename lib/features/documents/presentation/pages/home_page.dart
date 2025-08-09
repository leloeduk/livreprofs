import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/document_bloc.dart';
import '../bloc/document_event.dart';
import '../bloc/document_state.dart';
import 'document_detail_page.dart';

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

  Future<void> _refreshDocuments() async {
    _documentBloc.add(LoadDocuments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Espace Partage Scolaire',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DocumentLoaded) {
            final documents = state.documents;
            if (documents.isEmpty) {
              return const Center(child: Text('Aucun document trouvé'));
            }

            return RefreshIndicator(
              onRefresh: _refreshDocuments,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DocumentDetailPage(document: doc),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Icon(
                            doc.typeFichier.toLowerCase() == "pdf"
                                ? Icons.picture_as_pdf
                                : Icons.insert_drive_file,
                            color: Colors.deepPurple,
                            size: 28,
                          ),
                        ),
                        title: Text(
                          doc.titre,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          doc.matiere['nom'] ?? "",
                          style: TextStyle(
                            color: Color(
                              int.parse(
                                doc.matiere['couleur'].replaceFirst(
                                  '#',
                                  '0xff',
                                ),
                              ),
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is DocumentError) {
            return Center(
              child: Text(
                'Erreur : ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
