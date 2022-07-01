import 'package:flutter/material.dart';

import 'main_page.dart';

void main() => runApp(const BluetoothApplication());

class BluetoothApplication extends StatelessWidget {
  const BluetoothApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}
