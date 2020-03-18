import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';

import '../widgets/location_widget.dart';
import '../providers/image_object.dart';

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);
    final Size deviceSize = MediaQuery.of(context).size;
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
          ? GestureDetector(
              onTap: () {
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
              child: Container(
                height: orientation == Orientation.portrait
                    ? (deviceSize.height * 0.65)
                    : (deviceSize.height - 65),
                width: orientation == Orientation.portrait
                    ? (deviceSize.width)
                    : (deviceSize.width * 0.55),
                child: Center(
                  child: Text('No image selected'),
                ),
              ),
            )
          : Column(
              children: <Widget>[
                GestureDetector(
                  onLongPress: () {},
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
                      child: Image.file(
                        imageObject.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
