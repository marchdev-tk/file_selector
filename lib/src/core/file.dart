// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:meta/meta.dart';

/// Descriptor of the file.
///
/// The File class contains:
///  * `name` field - name of the file
///  * `path` field - path of the file
///  * `bytes` field - content of the file presented as a byte array
///  * `fileExtension` getter - extension of the file
///  * `type` getter - MIME type of the file
class File {
  /// Constructs instance of the [File]
  const File({
    @required this.name,
    this.path,
    @required this.bytes,
  })  : assert(name != null),
        assert(bytes != null);

  /// File name.
  final String name;

  /// Path of the file.
  final String path;

  /// File contents presented as a byte array.
  final Uint8List bytes;

  /// Get the extension of the file.
  String get fileExtension => name.split('.').last;

  /// Get the MIME type of the file.
  String get type => FileType.getTypeFromExtension(fileExtension);
}

/// Descriptor of the file type, it consists of MIME type and all
/// acceptable file extensions.
///
/// [_id] is an identifier of the [FileType], it is used only to
/// compare two different file types.
class FileType implements Comparable<FileType> {
  /// Creates a FileType.
  const FileType(this._id, this._type, this._extensions);

  /// Get a MIME type from file extension.
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

  final int _id;
  final String _type;
  final String _extensions;

  /// MIME type string.
  String get type => _type;

  /// Accepted file extension, if there are multiple acceptable file
  /// extesions, they are seperated by `|`.
  String get fileExtensions => _extensions;

  /// Returns `true` if current MIME type [type] is an image,
  /// otherwise - `false`.
  bool get isImage => _type.startsWith('image/');

  /// Returns `true` if current MIME type [type] is a video,
  /// otherwise - `false`.
  bool get isVideo => _type.startsWith('video/');

  /// Represents `any` file type.
  static final any = FileType(
    0,
    '*/*',
    img._extensions + video._extensions + pdf._extensions,
  );

  /// Represents `any image` file type.
  static const img = FileType(
    1,
    'image/*',
    'png|'
        'jpg|jpeg|jpe|jif|jfif|jfi|'
        'gif|'
        'bmp',
  );

  /// Represents `png` file type.
  static const png = FileType(1, 'image/png', 'png');

  /// Represents `jpg` file type.
  static const jpg = FileType(1, 'image/jpg', 'jpg|jpeg|jpe|jif|jfif|jfi');

  /// Represents `gif` file type.
  static const gif = FileType(1, 'image/gif', 'gif');

  /// Represents `bmp` file type.
  static const bmp = FileType(1, 'image/bmp', 'bmp');

  /// Represents `pdf` file type.
  static const pdf = FileType(2, 'application/pdf', 'pdf');

  /// Represents `any video` file type.
  static const video = FileType(
    3,
    'video/*',
    'mpg|mpeg|mp1|mp2|mp3|m1v|mpv|m1a|m2a|mpa'
        'mp4'
        'ogg|ogv|oga|ogx|spx|opus|ogm'
        'webm'
        'wmv'
        'flv'
        '3gpp|3gp'
        '3gpp2|3g2',
  );

  /// Represents `mpeg` file type.
  static const mpeg =
      FileType(3, 'video/mpeg', 'mpg|mpeg|mp1|mp2|mp3|m1v|mpv|m1a|m2a|mpa');

  /// Represents `mp4` file type.
  static const mp4 = FileType(3, 'video/mp4', 'mp4');

  /// Represents `ogg` file type.
  static const ogg = FileType(3, 'video/ogg', 'ogg|ogv|oga|ogx|spx|opus|ogm');

  /// Represents `webm` file type.
  static const webm = FileType(3, 'video/webm', 'webm');

  /// Represents `x-ms-wmv` file type.
  static const wmv = FileType(3, 'video/x-ms-wmv', 'wmv');

  /// Represents `x-flv` file type.
  static const flv = FileType(3, 'video/x-flv', 'flv');

  /// Represents `3gpp` file type.
  static const threeGpp = FileType(3, 'video/3gpp', '3gpp|3gp');

  /// Represents `3gpp2` file type.
  static const threeGpp2 = FileType(3, 'video/3gpp2', '3gpp2|3g2');

  /// Represents `any image or video` file type.
  static final media = FileType(
    4,
    '*/*',
    img._extensions + video._extensions,
  );

// video/quicktime: QuickTime

  // TODO: add more types

  /// Returns MIME type of [this] [FileType].
  @override
  String toString() => type;

  @override
  int compareTo(FileType other) => other._id == _id
      ? 0
      : other._id > _id
          ? 1
          : -1;

  /// Creates copy of [this] with new values, if the present.
  FileType copyWith({int id, String type, String fileExtension}) =>
      FileType(id ?? _id, type ?? _type, fileExtension ?? _extensions);
}
