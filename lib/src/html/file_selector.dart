// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';

import '../core/file.dart';
import 'file_selector.web.dart';
import '../core/file_selector.interface.dart';

/// Allows to pick one or several files.
///
/// Implemetation of [FileSelectorInterface].
///
/// It consists of:
///  * `pickFile` - for picking only one file
///  * `pickMultipleFiles` - for picking several files
class FileSelector implements FileSelectorInterface {
  factory FileSelector() => _instance;
  const FileSelector._();
  static const FileSelector _instance = FileSelector._();

  static FileSelectorInterface _interface;

  FileSelectorInterface _fileSelectorFactory() {
    if (_interface != null) {
      return _interface;
    }

    if (kIsWeb) {
      return FileSelectorWeb();
    }

    return null;
  }

  @override
  Future<File> pickFile({
    FileType type,
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickFile(
        type: type ?? FileType.any,
        confirmButtonText: confirmButtonText,
      );

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types,
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickMultipleFiles(
        types: types ?? [FileType.any],
        confirmButtonText: confirmButtonText,
      );
}
