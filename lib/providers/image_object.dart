import 'dart:io';

class ImageObject {
  final File image;
  final String latitude;
  final String longitude;
  final String timestamp;

  ImageObject({
    this.image,
    this.latitude,
    this.longitude,
    this.timestamp,
  });
}
