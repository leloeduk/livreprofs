import 'package:flutter/material.dart';
import 'package:livreprofs/features/documents/domain/entities/document.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';

class DocumentDetailPage extends StatefulWidget {
  final Document document;

  const DocumentDetailPage({super.key, required this.document});

  @override
  _DocumentDetailPageState createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  PDFDocument? _pdfDocument;
  bool _isLoading = false;
  bool _isDownloading = false;
  double _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
    _loadPdfPreview();
  }

  Future<void> _loadPdfPreview() async {
    if (widget.document.typeFichier.toLowerCase() != 'pdf') return;

    setState(() => _isLoading = true);
    try {
      final document = await PDFDocument.fromURL(widget.document.fichierUrl);
      setState(() => _pdfDocument = document);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de charger l\'aperçu: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _downloadFile() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    try {
      // Vérifier les permissions
      if (await Permission.storage.request().isGranted) {
        final dir = await getExternalStorageDirectory();
        final savePath = '${dir?.path}/${widget.document.titre}.pdf';

        final taskId = await FlutterDownloader.enqueue(
          url: widget.document.fichierUrl,
          savedDir: dir!.path,
          fileName: '${widget.document.titre}.pdf',
          showNotification: true,
          openFileFromNotification: true,
        );

        FlutterDownloader.registerCallback((id, status, progress) {
          if (taskId == id) {
            setState(() => _downloadProgress = progress.toDouble());
            if (status == DownloadTaskStatus.complete) {
              setState(() => _isDownloading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Téléchargement terminé: $savePath')),
              );
            }
          }
        });
      }
    } catch (e) {
      setState(() => _isDownloading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur de téléchargement: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.document.titre),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareDocument(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Carte d'information
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDocumentHeader(),
                    const SizedBox(height: 16),
                    _buildDocumentInfo(),
                    const SizedBox(height: 16),
                    _buildDownloadButton(),
                    if (_isDownloading) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _downloadProgress / 100,
                        backgroundColor: Colors.grey[300],
                        color: Colors.deepPurple,
                      ),
                      Text('${_downloadProgress.toStringAsFixed(1)}%'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Aperçu PDF
            if (widget.document.typeFichier.toLowerCase() == 'pdf')
              Expanded(child: _buildPdfPreview()),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentHeader() {
    return Row(
      children: [
        Icon(
          widget.document.typeFichier.toLowerCase() == "pdf"
              ? Icons.picture_as_pdf
              : Icons.insert_drive_file,
          color: Colors.deepPurple,
          size: 40,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.document.titre,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Matière : ${widget.document.matiere['nom']}",
          style: TextStyle(
            fontSize: 16,
            color: Color(
              int.parse(
                widget.document.matiere['couleur'].replaceFirst('#', '0xff'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Auteur : ${widget.document.author}",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          "Date : ${_formatDate(widget.document.dateUpload)}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          "Téléchargements : ${widget.document.nombreTelechargements}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.download, color: Colors.white),
        label: Text(
          _isDownloading ? 'Téléchargement...' : 'Télécharger',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: _isDownloading ? null : _downloadFile,
      ),
    );
  }

  Widget _buildPdfPreview() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _pdfDocument != null
        ? PDFViewer(
            document: _pdfDocument!,
            zoomSteps: 1,
            showPicker: false,
            showNavigation: true,
            scrollDirection: Axis.vertical,
          )
        : Center(
            child: Text(
              'Aperçu non disponible',
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _shareDocument() async {
    // Implémentez le partage avec le package share_plus
    // await Share.share('Regardez ce document: ${widget.document.titre}\n${widget.document.fichierUrl}');
  }
}
