import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/location_widget.dart';
import '../providers/image_object.dart';

class ImageWidgetLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);

    Size deviceSize = MediaQuery.of(context).size;

    return Container(
      width: (deviceSize.width * 0.55),
      height: (deviceSize.height),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
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
                        child: Image.file(
                          imageObject.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
