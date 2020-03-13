// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

class File {
  const File({
    this.name,
    this.path,
    this.bytes,
  });

  final String name;
  final String path;
  final Uint8List bytes;

  String get fileExtension => name.split('.').last;
  String get type => FileType.getTypeFromExtension(fileExtension);
}

class FileType implements Comparable<FileType> {
  const FileType(this._id, this._type, this._extensions);

  static FileType fromFilePath(String path) {
    if (path.endsWith('pdf')) {
      return FileType.pdf;
    } else if (path.endsWith('png')) {
      return FileType.png;
    } else if (path.endsWith('jpg')) {
      return FileType.jpg;
    } else {
      return FileType.any.copyWith(
          fileExtension: path.contains('.') ? path.split('.').last : null);
    }
  }

  final int _id;
  final String _type;
  final String _extensions;

  String get type => _type;
  String get fileExtensions => _extensions;

  static const any = FileType(0, '*/*', null);

  static const img = FileType(
    1,
    'image/*',
    'png|'
        'jpg|jpeg|jpe|jif|jfif|jfi|'
        'gif|'
        'bmp',
  );
  static const png = FileType(1, 'image/png', 'png');
  static const jpg = FileType(1, 'image/jpg', 'jpg|jpeg|jpe|jif|jfif|jfi');
  static const gif = FileType(1, 'image/gif', 'gif');
  static const bmp = FileType(1, 'image/bmp', 'bmp');

  static const pdf = FileType(2, 'application/pdf', 'pdf');

  bool get isImage => _type.startsWith('image/');

  static String getTypeFromExtension(String fileExtension) {
    if (fileExtension == pdf.fileExtensions) {
      return pdf.type;
    } else if (fileExtension == png.fileExtensions) {
      return png.type;
    } else if (fileExtension == gif.fileExtensions) {
      return gif.type;
    } else if (fileExtension == bmp.fileExtensions) {
      return bmp.type;
    } else if (jpg.fileExtensions.contains(fileExtension)) {
      return jpg.type;
    }

    return any.type;
  }

  @override
  String toString() => type;

  @override
  int compareTo(FileType other) =>
      other._id == _id ? 0 : other._id > _id ? 1 : -1;

  FileType copyWith({int id, String type, String fileExtension}) =>
      FileType(id ?? _id, type ?? _type, fileExtension ?? _extensions);
}
