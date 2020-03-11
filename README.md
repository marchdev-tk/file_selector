# file_selector

![Build](https://github.com/marchdev-tk/file_selector/workflows/build/badge.svg)
![GitHub](https://img.shields.io/github/license/marchdev-tk/file_selector)
![GitHub stars](https://img.shields.io/github/stars/marchdev-tk/file_selector?style=social)

## Getting Started

In order to use this plugin, add dependency in the `pubspec.yaml`:

```yaml
file_selector:
    git:
      url: https://github.com/marchdev-tk/file_selector
```

Add an import to dart file:

```dart
import 'package:file_selector/file_selector.dart';
```

### Samples

Web sample:

![Web Sample](../assets/fs_web.gif?raw=true)

Mobile sample:

![Mobile Sample](../assets/fs_mobile.gif?raw=true)

### To pick single file use:

```dart
final File file = await FileSelector().pickFile(
    type: FileType.img,
    confirmButtonText: 'Select',
);
```

where: 

* `confirmButtonText` (works only on `Desktop`) if set, changes default confirmation text on file picker popup;

* `type` represents the group of required types of specific type, could be one of the following:
    * `any` or `*/*`
    * `img` or `image/*`
        * `png` or `image/png`
        * `jpg` or `image/jpeg`
        * `gif` or `image/gif`
        * `bmp` or `image/bmp`
    * `pdf` or `application/pdf`

### To pick multiple file use:

```dart
final List<File> files = await FileSelector().pickFiles(
    types: [FileType.png, FileType.bmp],
    confirmButtonText: 'Select',
);
```

The only difference of `pickFiles` method from `pickFile` is that multiple files could be selected same as multiple `types`.

### Return type `File` contains folowing fields:

* `name` of the file
* `path` to the file, for Web it is empty
* `bytes` array of bytes

## Feature requests and Bug reports

Feel free to post a feature requests or report a bug [here](https://github.com/marchdev-tk/file_selector/issues).
