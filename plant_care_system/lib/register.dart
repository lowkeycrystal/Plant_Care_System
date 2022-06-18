// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_care_system/shared/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'main.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

void main() {
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register New Plant',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 242, 201),
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are sure to close page?'),
                  content: const Text(
                      'You will lose any data you input once you close this page.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          title: const Text('Register New Plant',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 64, 38),
                fontWeight: FontWeight.bold,
              )),
          elevation: 0,
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  bool _isLoading = false;

  var plantName = '';
  var plantVariety = '';
  var plantSpecie = '';
  var plantAge = 0;
  var plantHeight = 0;
  var numOfLeaves = 0;
  var shortDesc = '';
  var plantId = '';

  final _formKey = GlobalKey<FormState>();
  List<String> varieties = [
    'Alocasia',
    'Anthurium',
    'Calathea',
    'Monstera',
    'Philodendron',
    'Rhaphidophora'
  ];
  List<String> alocasiaSpecies = [
    'Alocasia Azlanii',
    'Alocasia Black Velvet',
    'Alocasia Lutea Golden',
    'Alocasia Pink Dragon',
    'Alocasia Polly',
    'Alocasia Purple Sword'
  ];
  List<String> anthuriumSpecies = [
    'Anthurium Big and Bold',
    'Anthurium Pink',
    'Anthurium Red',
    'Anthurium Ruffles'
  ];
  List<String> calatheaSpecies = [
    'Calathea Beauty Star',
    'Calathea Dottie',
    'Calathea Freddie',
    'Calathea Medallion',
    'Calathea Misto',
    'Calathea Musaica',
    'Goeppertia Orbifolia',
    'Calathea Peacock',
    'Calathea Pinstripe',
    'Calathea Rattlesnake',
    'Calathea Rosy Roseo',
    'Calathea Vittata',
    'Calathea White Flame',
    'Calathea Zebra'
  ];
  List<String> monsteraSpecies = [
    'Monstera',
    'Monstera Adansonii',
    'Monstera sp. (Peru)',
    'Monstera Dubia'
  ];
  List<String> philodendronSpecies = [
    'Philodendron Birkin',
    'Philodendron Brandi',
    'Philodendron Brasil',
    'Philodendron Heartleaf',
    'Philodendron Hope Selloum',
    'Philodendron Lemon Lime',
    'Philodendron Little Hope',
    'Philodendron Micans Velvet',
    'Philodendron Pink Princess',
    'Philodendron Prince of Orange',
    'Philodendron Shangri La',
    'Philodendron Velvet',
    'Philodendron Xanadu'
  ];
  List<String> rhaphidophoraSpecies = ['Rhaphidophora'];
  List<String> species = [];
  String? _selectedVarieties;
  String? _selectedSpecies;
  String pnforward = '';
  String pidforward = '';

// This will set the text value

  @override
  Widget build(BuildContext context) {
    CollectionReference plants =
        FirebaseFirestore.instance.collection('PLANTS');
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//Plant Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Plant Name',
                    hintText: 'ex. Plant 1, Anthurium 1, etc...',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    plantName = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 199, 217, 137),
                  ),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Plant Variety',
                      hintText: 'Select Plant Variety',
                    ),
                    value: _selectedVarieties,
                    items: varieties.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (varieties) {
                      if (varieties == 'Alocasia') {
                        species = alocasiaSpecies;
                      } else if (varieties == 'Anthurium') {
                        species = anthuriumSpecies;
                      } else if (varieties == 'Calathea') {
                        species = calatheaSpecies;
                      } else if (varieties == 'Monstera') {
                        species = monsteraSpecies;
                      } else if (varieties == 'Philodendron') {
                        species = philodendronSpecies;
                      } else if (varieties == 'Rhaphidophora') {
                        species = rhaphidophoraSpecies;
                      } else {
                        species = [];
                      }
                      setState(() {
                        _selectedSpecies = null;
                        _selectedVarieties = varieties;
                      });
                      plantVariety = varieties!;
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: const Color.fromARGB(255, 199, 217, 137),
                  ),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Plant Specie',
                      hintText: 'Select Plant Specie',
                    ),
                    value: _selectedSpecies,
                    items: species.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? specie) {
                      setState(() {
                        plantSpecie = specie!;
                      });
                    },
                  ),
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Plant Height (inches)',
                        hintText: 'Enter plant height',
                      ),
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontFamily: 'AvenirLight'),
                      onChanged: (value) {
                        plantHeight = int.parse(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 32, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty.';
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Plant Age (months)',
                        hintText: 'Enter plant age',
                      ),
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontFamily: 'AvenirLight'),
                      onChanged: (value) {
                        plantAge = int.parse(value);
                      },
                    ),
                  ),
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Number of Leaves',
                    hintText: 'Count the number of leaves',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    numOfLeaves = int.parse(value);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: TextFormField(
                  maxLines: 4,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Short Description',
                    hintText: 'Tell something about your plant...',
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  onChanged: (value) {
                    shortDesc = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Save and Generate QR Code',
                              style: TextStyle(fontSize: 20),
                            ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: const Color.fromARGB(255, 199, 217, 137),
                        primary: const Color.fromARGB(255, 18, 64, 38),
                        elevation: 20,
                        minimumSize: const Size(410, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        setState(() {
                          const uuid = Uuid();

                          plantId = uuid.v4(
                              //v5
                              // Uuid.NAMESPACE_URL,
                              // plantName +
                              //     plantVariety +
                              //     plantSpecie +
                              //     shortDesc +
                              //     '$plantAge' +
                              //     '$plantHeight' +
                              //     '$numOfLeaves'
                              );
                        });
                        if (_formKey.currentState!.validate()) {
                          //add to database
                          plants.add({
                            'Plant_Name': plantName,
                            'Plant_Variety': plantVariety,
                            'Plant_Specie': plantSpecie,
                            'Plant_Height': plantHeight,
                            'Plant_Age': plantAge,
                            'Num_of_Leaves': numOfLeaves,
                            'Short_Desc': shortDesc,
                            'Plant_Id': plantId,
                          });
                          // .then((value) => print('User is added'))
                          // .catchError((error) =>
                          //     print('Failed to add user: $error'));

                          //loading
                          setState(() => _isLoading = true);
                          await Future.delayed(const Duration(seconds: 2));

                          //proceed
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Downloadqr(
                                    pnforward: plantName,
                                    pidforward: plantId,
                                  )));
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}

class Downloadqr extends StatefulWidget {
  final String pnforward;
  final String pidforward;
  const Downloadqr(
      {Key? key, required this.pnforward, required this.pidforward})
      : super(key: key);

  @override
  DownloadqrState createState() {
    return DownloadqrState();
  }
}

class DownloadqrState extends State<Downloadqr> {
  final key = GlobalKey();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 229, 242, 201),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 18, 64, 38),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.done_outlined,
                    size: 40,
                    color: Color.fromARGB(255, 144, 191, 73),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
                child: Text(
                  widget.pnforward + " is Registered Succesfully!",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontFamily: 'AvenirLight',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(70, 5, 70, 20),
                child: Text(
                  "Save and Print QR Code using the button below.",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontFamily: 'AvenirLight'),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              RepaintBoundary(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: QrImage(
                      data: widget.pidforward,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 18, 64, 38),
                    ),
                  )),
              const SizedBox(height: 50),
              ElevatedButton(
                child: const Text(
                  'Share or Save QR Code',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 199, 217, 137),
                  primary: const Color.fromARGB(255, 18, 64, 38),
                  elevation: 20,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () async {
                  try {
                    RenderRepaintBoundary boundary = key.currentContext!
                        .findRenderObject() as RenderRepaintBoundary;
//captures qr image
                    var image = await boundary.toImage();

                    ByteData? byteData =
                        await image.toByteData(format: ImageByteFormat.png);

                    Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                    final appDir = await getApplicationDocumentsDirectory();
//current time
                    // var datetime = DateTime.now();
                    var nameQrSave = widget.pnforward;
//qr image file creation
                    file =
                        await File('${appDir.path}/$nameQrSave.png').create();
//appending data
                    await file?.writeAsBytes(pngBytes);
//Shares QR image
                    await Share.shareFiles(
                      [file!.path],
                      mimeTypes: ["image/png"],
                      text: "Share the QR Code",
                    );
                  } catch (e) {
                    // ignore: avoid_print
                    print(e.toString());
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  'Register Another Plant',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 18, 64, 38),
                  primary: const Color.fromARGB(255, 144, 191, 73),
                  elevation: 20,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text(
                  'Exit',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromARGB(255, 18, 64, 38),
                  primary: const Color.fromARGB(255, 144, 191, 73),
                  elevation: 20,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
              ),
            ]))));
  }
}
