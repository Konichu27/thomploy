import 'package:flutter/material.dart';

class IconConverter {
  // Convert IconData to String
  static String iconToString(IconData icon) {
    return icon.codePoint.toString();
  }

  // Convert String to IconData
  static IconData stringToIcon(String codePoint) {
    return IconData(
      int.parse(codePoint),
      fontFamily: 'MaterialIcons',
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Icon Converter Example')),
        body: Center(
          child: IconConverterExample(),
        ),
      ),
    );
  }
}

class IconConverterExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.home;
    String iconString = IconConverter.iconToString(icon);
    IconData convertedIcon = IconConverter.stringToIcon(iconString);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Original Icon:'),
        Icon(icon),
        SizedBox(height: 20),
        Text('Icon as String: $iconString'),
        SizedBox(height: 20),
        Text('Converted Icon:'),
        Icon(convertedIcon),
      ],
    );
  }
}
