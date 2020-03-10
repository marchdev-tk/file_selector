import 'dart:io';

import '../core/file.dart';
import 'file_selector.mobile.dart';
import 'file_selector.desktop.dart';
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

    if (Platform.isAndroid || Platform.isIOS) {
      return FileSelectorMobile();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return FileSelectorDesktop();
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
