// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:async';
import 'dart:typed_data';

import 'package:flinq/flinq.dart';

import '../core/file.dart';
import '../core/file_selector.interface.dart';

class FileSelectorWeb extends FileSelectorInterface {
  FileSelectorWeb() {
    final body = html.querySelector('body');
    body.appendHtml(
      '<input id="fileselector" type="file" style="display: none" />',
      treeSanitizer: html.NodeTreeSanitizer.trusted,
    );
  }

  Future<Uint8List> _getBytes(html.File file) {
    final completer = Completer<Uint8List>();
    final reader = html.FileReader();
    reader.onLoad.listen((_) async {
      final Uint8List bytes = reader.result;
      completer.complete(bytes);
    });
    reader.readAsArrayBuffer(file);
    return completer.future;
  }

  Future<List<html.File>> _getFiles(String type) async {
    final html.InputElement uploadInput = html.querySelector('#fileselector');
    uploadInput.value = '';
    uploadInput.accept = type;
    uploadInput.click();
    await uploadInput.onChange.first;
    return uploadInput.files;
  }

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) async {
    final files = await _getFiles(type.type);

    if (files.length != 1) {
      return null;
    }

    final file = files[0];

    return File(
      name: file.name,
      path: file.relativePath,
      bytes: await _getBytes(file),
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) async {
    String type = '*/*';
    if (types.length == 1) {
      type = types[0].type;
    } else if (types.every((type) => type.isImage)) {
      type = FileType.img.type;
    }

    final files = await _getFiles(type);

    return files.mapList(
      (file) => File(
        name: file.name,
        path: file.relativePath,
      ),
    );
  }
}
