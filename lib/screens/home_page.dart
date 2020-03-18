import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_object.dart';
import '../widgets/scaffold_body_potrait.dart';
import '../widgets/scaffold_body_landscape.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final imageObject = Provider.of<ImageObject>(context, listen: false);

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
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Change theme'),
                value: 'theme',
              )
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (selectedValue) {},
          ),
        ],
      ),
      body: orientation == Orientation.portrait
          ? SingleChildScrollView(child : PotraitBody())
          : LandscapeBody(),
    );
  }
}
