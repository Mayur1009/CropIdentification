import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

import '../widgets/image_widget.dart';
import '../providers/image_object.dart';

class MyHomePage extends StatelessWidget {
  Future<void> _getImageAndLocation(src, Function setObject) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
    LocationData _locationData = await location.getLocation();
    final _imageFile = await ImagePicker.pickImage(
      source: src,
    );

    final coord =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    final _address = await Geocoder.local.findAddressesFromCoordinates(coord);
    var _first = _address.first;
    print(
        '\n\n\n' + '${_first.featureName} : ${_first.addressLine}' + '\n\n\n');

    setObject(_imageFile, _locationData.latitude, _locationData.longitude,
        _first.addressLine);
  }

  @override
  Widget build(BuildContext context) {
    final imageObject = Provider.of<ImageObject>(context, listen: false);
    String address;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Identification App'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Change theme'),
                value: 'theme',
              )
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (selectedValue){

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ImageWidget(address),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  elevation: 10,
                  onPressed: () {
                    _getImageAndLocation(
                        ImageSource.camera, imageObject.setObject);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Take Picture'),
                ),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  elevation: 10,
                  onPressed: () {
                    _getImageAndLocation(
                        ImageSource.gallery, imageObject.setObject);
                  },
                  icon: Icon(Icons.photo),
                  label: Text('Open Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
