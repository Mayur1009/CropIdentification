import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: Colors.white54,
        height: 125,
        width: 75,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                Text('Cotton'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text('Rice'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
                Text('Maize'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.purple,
                ),
                Text('Jute'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.yellow,
                ),
                Text('Wheat'),
              ],
            ),
          ],
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }
}
