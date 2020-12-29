// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'file.dart';

/// Interface of available [FileSelector] operations.
///
/// It consists of:
///  * `pickFile` - for picking only one file
///  * `pickMultipleFiles` - for picking several files
abstract class FileSelectorInterface {
  /// Picking anly one file.
  ///
  /// `type` is a descriptor of the file type (MIME type and
  /// acceptable extensions)
  /// 
  /// Default `type` is [FileType.any].
  ///
  /// `confirmButtonText` replaces complete button title
  /// (works only on desktop platforms).
  Future<File> pickFile({
    FileType type,
    String confirmButtonText,
  });

  /// Picking several files.
  ///
  /// `types` is a [List] of descriptors of the file types (MIME
  /// type and acceptable extensions)
  /// 
  /// Default `types` are list of [FileType.any].
  ///
  /// `confirmButtonText` replaces complete button title
  /// (works only on desktop platforms).
  Future<List<File>> pickMultipleFiles({
    List<FileType> types,
    String confirmButtonText,
  });
}
