import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yukon/repository/file_repository.dart';

class FileService {
  final fileRepository = FileRepository();
  Future<File?> getStatement(String url) async {
    log('get statement');
    log(url);
    File? file = await fileRepository.downloadFileFromUrl(url, null);
    return file;
  }

  Future openFile(File? file) async {
    log('opening file');
    if (file == null) {
      log('file is empty');
      return;
    }
    log(file.path);
    OpenFile.open(file.path);
  }

  Future<String?> readPdfFile(File? file) async {
    try {
      Uint8List bytes = file!.readAsBytesSync();
      final ByteData data = ByteData.view(bytes.buffer);
      PdfDocument document = PdfDocument(
          inputBytes:
              data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

      PdfTextExtractor extractor = PdfTextExtractor(document);
      return extractor.extractText();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  String extractPrimaryAccountNumber(String text) {
    const startText = 'Primary Account Number:';
    final startIndex = text.indexOf(startText) + startText.length;
    final endIndex = startIndex + 9;
    return text.substring(startIndex, endIndex);
  }
}
