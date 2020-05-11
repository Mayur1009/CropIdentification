import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Map colors = {
  'wheat': Colors.yellow,
  'rice' : Colors.red,
  'maize': Colors.green,
  'jute' : Colors.purple,
  'cotton': Colors.black,
};

List<Map> cotton, rice, maize, wheat, jute;

void getLocations(String label) {
  var data = Firestore.instance.collection(label).document().get();
}

class Maptab extends StatefulWidget {
  @override
  _MaptabState createState() => _MaptabState();
}

class _MaptabState extends State<Maptab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
        options: new MapOptions(
          center: LatLng(21, 79),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoibWF5dXIxMDA5IiwiYSI6ImNrYTJoN2UzNjBhNzYzbG9nOWRubGprcjkifQ.jYhknQYJUHs8y3kEKPVNNw',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(21, 79),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.location_on,
                    color: colors['jute'],
                  ),
                ),
              ),
              Marker(
                point: LatLng(22, 80),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.location_on,
                    color: colors['maize'],
                  ),
                ),
              ),
              Marker(
                point: LatLng(23, 81),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.location_on,
                    color: colors['cotton'],
                  ),
                ),
              ),
              Marker(
                point: LatLng(24, 82),
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.location_on,
                    color: colors['rice'],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
