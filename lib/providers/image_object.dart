import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class ImageObject with ChangeNotifier {
  File _image;
  double _latitude;
  double _longitude;
  DateTime _timeStamp;
  String _address;
  List _recognitions;

  File get image {
    return _image != null ? _image : null;
  }

  double get latitude {
    return _latitude != null ? _latitude : null;
  }

  double get longitude {
    return _longitude != null ? _longitude : null;
  }

  String get address {
    return _address != null ? _address : null;
  }

  List get recognitions {
    return _recognitions != null ? _recognitions : null;
  }

  Future<void> setLocation() async {
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
    final coord =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    final address = await Geocoder.local.findAddressesFromCoordinates(coord);
    var _first = address.first;

    _latitude = _locationData.latitude;
    _longitude = _locationData.longitude;
    _address = _first.addressLine;
    notifyListeners();
  }

  Future<void> setImage(String src) async {
    final imageFile = await ImagePicker.pickImage(
      source: src == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    _image = imageFile;
    notifyListeners();
    if (_image == null) return;
    var recognitions = await Tflite.runModelOnImage(
      path: _image.path,
      threshold: 0.5,
    );
    print(recognitions);
    _recognitions = recognitions;
    _image = imageFile;
    _timeStamp = DateTime.now();
    notifyListeners();
  }
}
