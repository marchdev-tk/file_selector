// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flinq/flinq.dart';
import 'package:file_chooser/file_chooser.dart';

import '../core/file.dart';
import '../core/file_selector.interface.dart';

class FileSelectorDesktop extends FileSelectorInterface {
  FileTypeFilterGroup _toFileChooserFileType(FileType type) {
    String label;
    switch (type.type) {
      case '*/*':
        label = 'All';
        break;

      case 'image/*':
        label = 'Images';
        break;

      default:
        label = type.type.split('/').last.toUpperCase();
    }

    return FileTypeFilterGroup(
      label: label,
      fileExtensions:
          type.fileExtensions != null ? type.fileExtensions.split('|') : [],
    );
  }

  Future<Uint8List> _getBytes(String path) async =>
      Uint8List.fromList(await io.File(path).readAsBytes());

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) async {
    assert(() {
      if (type == null) {
        throw ArgumentError.notNull('types');
      }

      return true;
    }());
    final result = await showOpenPanel(
      canSelectDirectories: false,
      allowsMultipleSelection: false,
      confirmButtonText: confirmButtonText,
      allowedFileTypes: [_toFileChooserFileType(type)],
    );

    if (result?.canceled != false || result?.paths?.isNotEmpty != true) {
      return null;
    }

    final path = result.paths[0];

    return File(
      name: path.split(r'\').last,
      path: path,
      bytes: await _getBytes(path),
    );
  }

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) async {
    assert(() {
      if (types == null) {
        throw ArgumentError.notNull('types');
      }

      return true;
    }());

    final result = await showOpenPanel(
      canSelectDirectories: false,
      allowsMultipleSelection: false,
      confirmButtonText: confirmButtonText,
      allowedFileTypes: types.mapList((type) => _toFileChooserFileType(type)),
    );

    if (result?.canceled != false || result?.paths?.isNotEmpty != true) {
      return null;
    }

    List<File> files = [];
    for (var path in result.paths) {
      files.add(File(
        name: path.split('/').last,
        path: path,
        bytes: await _getBytes(path),
      ));
    }

    return files;
  }
}
