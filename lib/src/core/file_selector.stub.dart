// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'file.dart';
import 'file_selector.interface.dart';

class FileSelector implements FileSelectorInterface {
  const FileSelector._();

  factory FileSelector() => _instance;

  static FileSelector _instance = FileSelector._();

  @override
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  }) =>
      throw UnimplementedError();

  @override
  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  }) =>
      throw UnimplementedError();
}
