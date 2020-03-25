import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

import '../widgets/scaffold_body_potrait.dart';
import '../widgets/scaffold_body_landscape.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _busy = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _busy = true;

    loadModel().then((_) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/tflite/converted_model.tflite",
        labels: "assets/tflite/labels_ben.txt",);
      print(res);
    } on PlatformException {
      print('Failed to load moedel.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery
        .of(context)
        .orientation;
    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme
              .of(context)
              .brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Identification App',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) =>
            [
              PopupMenuItem(
                child: const Text('Change theme'),
                value: 'theme',
              )
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (selectedValue) {
              if (selectedValue == 'theme') {
                changeBrightness();
              }
            },
          ),
        ],
      ),
      body: orientation == Orientation.portrait
          ? SingleChildScrollView(child: PotraitBody())
          : LandscapeBody(),
    );
  }
}
