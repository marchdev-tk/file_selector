// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io show File;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart' hide FileType;
import 'package:file_picker/file_picker.dart' as fp show FileType;

import '../core/file.dart';
import '../core/file_selector.interface.dart';

class FileSelectorMobile extends FileSelectorInterface {
  fp.FileType _toFilePickerFileType(FileType type) {
    if (type == FileType.media) {
      return fp.FileType.media;
    } else if (type.isImage) {
      return fp.FileType.image;
    } else if (type.isVideo) {
      return fp.FileType.video;
    } else if (type == FileType.pdf) {
      return fp.FileType.custom;
    }

    if (type.fileExtensions?.isNotEmpty == true) {
      return fp.FileType.custom;
    }

    return fp.FileType.any;
  }

  Future<Uint8List> _getBytes(String path) async =>
      Uint8List.fromList(await io.File(path).readAsBytes());

  @override
  Future<File> pickFile({
    FileType type,
    String confirmButtonText,
  }) async {
    type ??= FileType.any;

    final fpFile = _toFilePickerFileType(type);

    final file = await FilePicker.platform.pickFiles(
      type: fpFile,
      allowedExtensions:
          fpFile == fp.FileType.custom ? type.fileExtensions.split('|') : null,
    );

    if (file?.files?.isNotEmpty != true) return null;

    final _file = file.files.first;
    Uint8List bytes = _file.bytes;
    if (bytes == null) {
      bytes = await _getBytes(_file.path);
    }

    return File(
      name: _file.path.split('/').last,
      path: _file.path,
      bytes: bytes,
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types,
    String confirmButtonText,
  }) async {
    types ??= [FileType.any];

    FileType type = FileType.any;
    if (types.length == 1) {
      type = types[0];
    } else if (types.every((type) => type.isImage)) {
      type = FileType.img;
    } else if (types.every((type) => type.isVideo)) {
      type = FileType.video;
    } else if (types.every((type) => type.isVideo || type.isImage)) {
      type = FileType.media;
    } else if (types.every((type) => type == FileType.pdf)) {
      type = FileType.pdf;
    }

    final fpFile = _toFilePickerFileType(type);

    final files = await FilePicker.platform.pickFiles(
      type: fpFile,
      allowedExtensions:
          fpFile == fp.FileType.custom ? type.fileExtensions.split('|') : null,
    );

    if (files?.files?.isNotEmpty != true) return null;

    List<File> result = [];
    for (var file in files.files) {
      Uint8List bytes = file.bytes;
      if (bytes == null) {
        bytes = await _getBytes(file.path);
      }

      result.add(File(
        name: file.path.split('/').last,
        path: file.path,
        bytes: bytes,
      ));
    }

    return result;
  }
}
