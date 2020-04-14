// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart' hide FileType;
import 'package:file_picker/file_picker.dart' as fp show FileType;

import '../core/file.dart';
import '../core/file_selector.interface.dart';

class FileSelectorMobile extends FileSelectorInterface {
  fp.FileType _toFilePickerFileType(FileType type) {
    if (type.isImage) {
      return fp.FileType.image;
    }

    switch (type) {
      case FileType.pdf:
        return fp.FileType.custom;

      case FileType.any:
      default:
        return fp.FileType.any;
    }
  }

  Future<Uint8List> _getBytes(io.File file) async =>
      Uint8List.fromList(await file.readAsBytes());

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) async {
    final file = await FilePicker.getFile(
      type: _toFilePickerFileType(type),
      allowedExtensions: type.fileExtensions.split('|'),
    );

    if (file == null) return null;

    return File(
      name: file.path.split('/').last,
      path: file.path,
      bytes: await _getBytes(file),
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) async {
    FileType type = FileType.any;
    if (types.length == 1) {
      type = types[0];
    } else if (types.every((type) => type.isImage)) {
      type = FileType.img;
    }

    final files = await FilePicker.getMultiFile(
      type: _toFilePickerFileType(type),
      allowedExtensions: type.fileExtensions.split('|'),
    );

    if (files == null) return null;

    List<File> result = [];
    for (var file in files) {
      result.add(File(
        name: file.path.split('/').last,
        path: file.path,
        bytes: await _getBytes(file),
      ));
    }

    return result;
  }
}
