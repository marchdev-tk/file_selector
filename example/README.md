# file_selector_example

Demonstrates how to use the file_selector package.

## Usage

```dart
import 'package:flutter/material.dart';

import 'package:file_selector/file_selector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desktop Plugins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedFile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desktop Plugins'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: () async {
                final file = await FileSelector().pickFile(
                  type: FileType.img,
                );

                setState(() => _selectedFile = file == null
                    ? 'SELECTION CANCELED'
                    : 'NAME: ${file.name}\nPATH: ${file.path}\nBYTES: ${file.bytes.take(10)}...');
              },
              child: Text('Select file'),
            ),
          ),
          Center(child: Text(_selectedFile)),
        ],
      ),
    );
  }
}
```

## Getting Started

For help getting started with Flutter, view 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
