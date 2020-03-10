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
