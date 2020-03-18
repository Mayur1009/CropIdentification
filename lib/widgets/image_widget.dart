import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

import '../providers/image_object.dart';

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Card(
      margin: orientation == Orientation.portrait
          ? EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            )
          : EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: orientation == Orientation.portrait
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
            : BorderRadius.all(
                Radius.circular(15),
              ),
      ),
      child: imageObject.image == null
          ? ImageGesture(
              () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please Select an Image.'),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Okay',
                      onPressed: () =>
                          Scaffold.of(context).hideCurrentSnackBar(),
                    ),
                  ),
                );
              },
              Center(child: Text('No image selected')),
            )
          : ImageGesture(
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ImageView(
                      FileImage(
                        imageObject.image,
                      ),
                    ),
                  ),
                );
              },
              Image.file(
                imageObject.image,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}

class ImageGesture extends StatelessWidget {
  final Function _onTap;
  final Widget _child;

  ImageGesture(this._onTap, this._child);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _onTap,
      child: ClipRRect(
        borderRadius: orientation == Orientation.portrait
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
            : BorderRadius.all(
                Radius.circular(15),
              ),
        child: Container(
          height: orientation == Orientation.portrait
              ? (deviceSize.height * 0.65)
              : (deviceSize.height - 65),
          width: orientation == Orientation.portrait
              ? (deviceSize.width)
              : (deviceSize.width * 0.55),
          child: _child,
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final ImageProvider image;

  ImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: image,
    ));
  }
}
