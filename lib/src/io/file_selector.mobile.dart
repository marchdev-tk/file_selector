// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_picker/file_picker.dart' hide FileType;
import 'package:file_picker/file_picker.dart' as fp show FileType;

import '../core/file.dart';
import '../core/file_selector.interface.dart';

class FileSelectorMobile extends FileSelectorInterface {
  fp.FileType _toFilePickerFileType(FileType type) {
    if (type.isImage) {
      return fp.FileType.image;
    } else if (type.isVideo) {
      return fp.FileType.video;
    } else if (type == FileType.pdf) {
      return fp.FileType.custom;
    }

    return fp.FileType.any;
  }

  @override
  Future<File> pickFile({
    FileType type,
    String confirmButtonText,
  }) async {
    type ??= FileType.any;

    final file = await FilePicker.platform.pickFiles(
      type: _toFilePickerFileType(type),
      allowedExtensions: type.fileExtensions.split('|'),
    );

    if (file?.files?.isNotEmpty != true) return null;

    final _file = file.files.first;
    return File(
      name: _file.path.split('/').last,
      path: _file.path,
      bytes: _file.bytes,
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
    }

    final files = await FilePicker.platform.pickFiles(
      type: _toFilePickerFileType(type),
      allowedExtensions: type.fileExtensions.split('|'),
    );

    if (files?.files?.isNotEmpty != true) return null;

    List<File> result = [];
    for (var file in files.files) {
      result.add(File(
        name: file.path.split('/').last,
        path: file.path,
        bytes: file.bytes,
      ));
    }

    return result;
  }
}
