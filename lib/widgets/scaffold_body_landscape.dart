import 'package:flutter/material.dart';

import '../widgets/image_widget.dart';
import '../widgets/location_widget.dart';
import '../widgets/button.dart';

class LandscapeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ImageWidget(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(),
              LocationWidget(),
              SizedBox(),
              SizedBox(),
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
              SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
