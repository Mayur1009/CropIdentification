import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

import '../providers/image_object.dart';

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size deviceSize = MediaQuery.of(context).size;

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
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ImageGesture(
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
                if (imageObject.label != null &&
                    orientation == Orientation.portrait)
                  Container(
                      width: deviceSize.width,
                      color: Colors.black87,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        "${imageObject.label}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                  ),
                if (imageObject.label != null &&
                    orientation == Orientation.landscape)
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Container(
                      width: (deviceSize.width * 0.55),
                      height: (deviceSize.height - 65) * 0.11,
                      color: Colors.black87,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        "${imageObject.label}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
              ],
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

    return InkWell(
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
              ? (deviceSize.height * 0.62)
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
      ),
    );
  }
}
