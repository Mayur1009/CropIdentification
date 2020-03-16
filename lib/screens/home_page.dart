import 'package:flutter/material.dart';

import '../widgets/image_widget.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Identification App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ImageWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                elevation: 10,
                onPressed: null,
                icon: Icon(Icons.camera),
                label: Text('Take Picture'),
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                elevation: 10,
                onPressed: null,
                icon: Icon(Icons.photo),
                label: Text('Open Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
