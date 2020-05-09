import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
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

  Future<void> setImage(String src, BuildContext context) async {
    clear();
    setLocation();
    final imageFile = await ImagePicker.pickImage(
      source: src == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    _timeStamp = DateTime.now();
    final Directory appDir = await getApplicationDocumentsDirectory();
    print(appDir.path);
    final newimage = imageFile
        .copySync('${appDir.path}/${_timeStamp.toIso8601String()}.jpeg');
    _image = newimage;
    print(_image.path);

    notifyListeners();
    if (_image == null) return;
    var recognitions = await Tflite.runModelOnImage(
      path: _image.path,
      threshold: 0.1,
    );
    print(recognitions);
    _recognitions = recognitions;
    uploadImage(_image, context);
    notifyListeners();
  }

  Future uploadImage(File image, BuildContext context) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Test/${path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    var dow = await (await uploadTask.onComplete).ref.getDownloadURL();
    Firestore.instance.collection('root').add(
      {
        'url': dow,
        'latitude': _latitude,
        'longitude': _longitude,
        'timestamp': _timeStamp,
      },
    );
    print('File Uploaded');
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Image Uploaded.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
