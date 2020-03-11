// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';

import '../core/file.dart';
import 'file_selector.web.dart';
import '../core/file_selector.interface.dart';

class FileSelector implements FileSelectorInterface {
  const FileSelector._();

  factory FileSelector() => _instance;

  static FileSelector _instance = FileSelector._();
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
    FileType type = FileType.any,
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickFile(
        type: type,
        confirmButtonText: confirmButtonText,
      );

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) =>
      _fileSelectorFactory()?.pickMultipleFiles(
        types: types,
        confirmButtonText: confirmButtonText,
      );
}
