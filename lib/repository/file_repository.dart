import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileRepository {
  Future<File?> downloadFileFromUrl(String url, String? name) async {
    log('downloading file from url');
    try {
      final storage = await getApplicationDocumentsDirectory();
      final fileName = name ?? url.split('/').last;
      final file = File('${storage.path}/$fileName');

      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        log('file saved');
        return file;
      } else {
        log(response.statusMessage ?? 'no message');
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
