import 'package:flutter/material.dart';

class Document {
  final String id;
  final String title;
  final String subject;
  final DateTime date;
  final String fileType;
  final String author;
  final Color cardColor;

  Document({
    required this.id,
    required this.title,
    required this.subject,
    required this.date,
    required this.fileType,
    this.author = "Anonyme",
    required this.cardColor,
  });
}
