library file_selector;

export 'src/core/file.dart';
export 'src/core/file_selector.interface.dart';
export 'src/core/file_selector.stub.dart'
    if (dart.library.html) 'src/html/file_selector.dart'
    if (dart.library.io) 'src/io/file_selector.dart';
