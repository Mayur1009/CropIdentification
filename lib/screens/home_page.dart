import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import '../widgets/scaffold_body_landscape.dart';
import '../widgets/scaffold_body_potrait.dart';
import '../providers/image_object.dart';
import '../widgets/maptab.dart';

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
        model: "assets/tflite/tf_model2.tflite",
        labels: "assets/tflite/classes.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load moedel.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;
    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.art_track),
              ),
              Tab(
                icon: Icon(Icons.map),
              ),
            ],
          ),
          title: Text(
            'Crop Identification App',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: const Text('Change theme'),
                  value: 'theme',
                ),
                PopupMenuItem(
                  child: const Text('Clear'),
                  value: 'clear',
                ),
              ],
              icon: const Icon(Icons.more_vert),
              onSelected: (selectedValue) {
                if (selectedValue == 'theme') {
                  changeBrightness();
                }

                if (selectedValue == 'clear') {
                  imageObject.clear();
                }
              },
            ),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            orientation == Orientation.portrait
                ? SingleChildScrollView(child: PotraitBody())
                : LandscapeBody(),
            Maptab(),
          ],
        ),
//        orientation == Orientation.portrait
//            ? SingleChildScrollView(child: PotraitBody())
//            : LandscapeBody(),
      ),
    );
  }
}
