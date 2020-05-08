import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_object.dart';

class Button extends StatelessWidget {
  final String label;
  final IconData icon;
  final String imgSrc;

  Button({
    this.label,
    this.icon,
    this.imgSrc,
  });

  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context, listen: false);
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 10,
      onPressed: () {
        imageObject.setImage(imgSrc, context);
//        Scaffold.of(context).showSnackBar(
//          SnackBar(
//            content: Text('Image Uploaded.'),
//            duration: Duration(seconds: 3),
//            action: SnackBarAction(
//              label: 'Okay',
//              onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
//            ),
//          ),
//        );
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
