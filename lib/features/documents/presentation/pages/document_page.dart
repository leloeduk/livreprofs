// // lib/presentation/pages/document_list_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:livreprofs/features/documents/presentation/pages/pdf.dart';
// import '../../domain/entities/document.dart';
// import '../bloc/document_bloc.dart';
// import '../bloc/document_event.dart';
// import '../bloc/document_state.dart';
// import 'package:pdfx/pdfx.dart';

// class DocumentListPage extends StatelessWidget {
//   const DocumentListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Documents")),
//       body: BlocBuilder<DocumentBloc, DocumentState>(
//         builder: (context, state) {
//           if (state is DocumentLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is DocumentLoaded) {
//             return ListView.builder(
//               itemCount: state.documents.length,
//               itemBuilder: (context, index) {
//                 final doc = state.documents[index];
//                 return ListTile(
//                   title: Text(doc.titre),
//                   subtitle: Text(doc.matiere.nom),
//                   trailing: Icon(Icons.picture_as_pdf, color: Colors.red),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => PdfViewerPage(pdfUrl: doc.fichierUrl),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else if (state is DocumentError) {
//             return Center(child: Text('Erreur: ${state.message}'));
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
