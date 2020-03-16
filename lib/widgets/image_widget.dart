import 'package:flutter/material.dart';


class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.red,
      width: 300,
      height: 300,
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text('No Image'),
      ),
    );
  }
}
