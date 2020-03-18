// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'file.dart';
import 'file_selector.interface.dart';

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
