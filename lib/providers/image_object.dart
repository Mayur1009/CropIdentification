import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';

class ImageObject with ChangeNotifier {
  File _image;
  double _latitude;
  double _longitude;
  DateTime _timeStamp;
  String _address;

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


  void setObject(File image, double lat, double long, String add) {
    _image = image;
    _latitude = lat;
    _longitude = long;
    _address = add;
    _timeStamp = DateTime.now();
    notifyListeners();
  }
}
