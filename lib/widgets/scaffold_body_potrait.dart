import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../widgets/image_widget.dart';
import '../widgets/location_widget.dart';
import '../providers/image_object.dart';
import '../widgets/button.dart';


class PotraitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ImageWidget(),
        LocationWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Button(label: 'Take Picture', icon: Icons.camera, imgSrc: 'camera',),
            Button(label: 'Open Gallery', icon: Icons.photo, imgSrc: 'gallery',),
          ],
        ),
      ],
    );
  }
}
