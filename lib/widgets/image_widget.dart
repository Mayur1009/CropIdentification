import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';

import '../providers/image_object.dart';

class ImageWidget extends StatelessWidget {
  final String address;

  ImageWidget(this.address);

  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: imageObject.image == null
          ? GestureDetector(
              onTap: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please Select image.'),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Okay',
                      onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                    ),
                  ),
                );
              },
              child: Container(
                height: 400,
                width: 300,
                margin: const EdgeInsets.all(10),
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
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      child: Image.file(
                        imageObject.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Container(
                    color: Colors.blue[300],
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                        ),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              '${imageObject.address}',
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
