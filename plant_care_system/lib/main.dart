import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_care_system/bluetooth/main.dart';
import 'package:plant_care_system/scanner.dart';
import 'register.dart';
import 'firebase_options.dart';
import 'package:line_icons/line_icons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final appTitle = 'Plant App';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 242, 201),
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: <Color>[
                Color.fromARGB(255, 18, 64, 38),
                Color.fromARGB(255, 18, 60, 12)
              ]))),
          title: const Text('Home',
              style: TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 18, 64, 38),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 50,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                        Color.fromARGB(255, 18, 64, 38),
                        Color.fromARGB(255, 18, 64, 38)
                      ])),
                  child: null,
                ),
              ),
              ListTile(
                leading: const Icon(LineIcons.home,
                    color: Color.fromARGB(255, 199, 217, 137)),
                title: const Text('Home',
                    style:
                        TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(LineIcons.seedling,
                    color: Color.fromARGB(255, 199, 217, 137)),
                title: const Text('Supported Plants',
                    style:
                        TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(LineIcons.tools,
                    color: Color.fromARGB(255, 199, 217, 137)),
                title: const Text('How It Works',
                    style:
                        TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(LineIcons.infoCircle,
                    color: Color.fromARGB(255, 199, 217, 137)),
                title: const Text('About',
                    style:
                        TextStyle(color: Color.fromARGB(255, 199, 217, 137))),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Container(
                    width: 300.0,
                    height: 300.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo2.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    child: const Text(
                      'Scan QR Code',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: const Color.fromARGB(255, 199, 217, 137),
                        primary: const Color.fromARGB(255, 18, 64, 38),
                        elevation: 20,
                        minimumSize: const Size(300, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 110)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantScanner()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Register A Plant',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: const Color.fromARGB(255, 199, 217, 137),
                        primary: const Color.fromARGB(255, 18, 64, 38),
                        elevation: 20,
                        minimumSize: const Size(250, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Connect Bluetooth',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: const Color.fromARGB(255, 199, 217, 137),
                        primary: const Color.fromARGB(255, 18, 64, 38),
                        elevation: 20,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 88)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BluetoothApplication()),
                      );
                    },
                  ),
                ]),
          ),
        ));
  }
}
