// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library file_selector;

export 'src/core/file.dart';
export 'src/core/file_selector.interface.dart';
export 'src/core/file_selector.stub.dart'
    if (dart.library.html) 'src/html/file_selector.dart'
    if (dart.library.io) 'src/io/file_selector.dart';
