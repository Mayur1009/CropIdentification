import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  void clear() {
    _image = null;
    _latitude = null;
    _longitude = null;
    _timeStamp = null;
    _address = null;
    _recognitions = null;
    print('\n\tData Cleared\n');
    notifyListeners();
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
    clear();
    setLocation();
    final imageFile = await ImagePicker.pickImage(
      source: src == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    _timeStamp = DateTime.now();
    final Directory appDir = await getApplicationDocumentsDirectory();
    print(appDir.path);
    final newimage = imageFile.copySync('${appDir.path}/${_timeStamp.toIso8601String()}.jpeg');
    _image = newimage;
    print(_image.path);

    notifyListeners();
    if (_image == null) return;
    var recognitions = await Tflite.runModelOnImage(
      path: _image.path,
      threshold: 0.5,
    );
    print(recognitions);
    _recognitions = recognitions;
    uploadImage(_image);
    notifyListeners();
  }

  Future uploadImage(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Test/${path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
  }
}
