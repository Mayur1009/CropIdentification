import 'package:crop_app/providers/image_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../widgets/legend.dart';

Map colors = {
  'Wheat': Colors.yellow,
  'Rice': Colors.red,
  'Maize': Colors.green,
  'Jute': Colors.purple,
  'Cotton': Colors.black,
};

class Maptab extends StatefulWidget {
  @override
  _MaptabState createState() => _MaptabState();
}

class _MaptabState extends State<Maptab> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    List<Marker> marks = [];
    var doc = Firestore.instance.collection('root').getDocuments().then((s) {
      s.documents.forEach((d) {
        if (d.data['label'] != null &&
            d.data['latitude'] != null &&
            d.data['longitude'] != null) {
          marks.add(Marker(
            point: LatLng(double.parse(d.data['latitude'].toString()),
                double.parse(d.data['longitude'].toString())),
            builder: (ctx) => new Container(
              child: Icon(
                Icons.location_on,
                color: colors[d.data['label'].toString()],
              ),
            ),
          ));
          print(
              '${double.parse(d.data['latitude'].toString())} - ${double.parse(d.data['longitude'].toString())} - ${d.data['label'].toString()} - ${colors[d.data['label'].toString()]}');
        }
      });
    });

    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          FlutterMap(
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
                markers: marks,
//                markers: [
//                  Marker(
//                    point: LatLng(21, 79),
//                    builder: (ctx) => new Container(
//                      child: Icon(
//                        Icons.location_on,
//                        color: colors['jute'],
//                      ),
//                    ),
//                  ),
//                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Legend(),
          ),
          Positioned(
            top: deviceSize.height - (deviceSize.height * 0.3),
            child: Container(
              margin: EdgeInsets.all(15),
              child: RaisedButton.icon(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                onPressed: () {
                  final List<Marker> m = [];
                  Firestore.instance
                      .collection('root')
                      .getDocuments()
                      .then((s) {
                    s.documents.forEach((d) {
                      if (d.data['label'] != null &&
                          d.data['latitude'] != null &&
                          d.data['longitude'] != null) {
                        m.add(Marker(
                          point: LatLng(
                              double.parse(d.data['latitude'].toString()),
                              double.parse(d.data['longitude'].toString())),
                          builder: (ctx) => new Container(
                            child: Icon(
                              Icons.location_on,
                              color: colors[d.data['label'].toString()],
                            ),
                          ),
                        ));
                        print(
                            '${double.parse(d.data['latitude'].toString())} - ${double.parse(d.data['longitude'].toString())} - ${d.data['label'].toString()} - ${colors[d.data['label'].toString()]}');
                      }
                    });
                  });
                  setState(() {
                    marks = m;
                  });
                },
                icon: Icon(
                  Icons.refresh,
                ),
                label: Text('Refresh'),
                elevation: 10,
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
