import 'package:flutter/material.dart';

import '../widgets/image_widget.dart';
import '../widgets/location_widget.dart';
import '../widgets/button.dart';

class PotraitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ImageWidget(),
        LocationWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Button(
              label: 'Take Picture',
              icon: Icons.camera,
              imgSrc: 'camera',
            ),
            Button(
              label: 'Open Gallery',
              icon: Icons.photo,
              imgSrc: 'gallery',
            ),
          ],
        ),
      ],
    );
  }
}
