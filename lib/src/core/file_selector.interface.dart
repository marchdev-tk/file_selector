// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'file.dart';

abstract class FileSelectorInterface {
  Future<File> pickFile({
    FileType type = FileType.any,
    String confirmButtonText,
  });

  Future<List<File>> pickMultipleFiles({
    List<FileType> types = const [FileType.any],
    String confirmButtonText,
  });
}
