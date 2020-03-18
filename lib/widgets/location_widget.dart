import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_object.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Card(
      margin: EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      color: Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: orientation == Orientation.portrait
            ? BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            : BorderRadius.all(
                Radius.circular(15),
              ),
      ),
      child: Container(
        height: 50,
        child: FlatButton.icon(
          onPressed: () {
            print('Location Button pressed');
            imageObject.setLocation();
          },
          icon: Icon(Icons.location_on),
          label: Expanded(
            child: Text(
              imageObject.address != null
                  ? '${imageObject.address}'
                  : 'Press the location icon to the left.',
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
