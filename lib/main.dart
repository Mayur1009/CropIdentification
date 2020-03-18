import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_page.dart';
import './providers/image_object.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageObject(),
      child: MaterialApp(
        title: 'Crop Identification',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// TODO: Make the ImageWidget tapable and open a image viewer on tapped.
// TODO: **Not so imp** Try to implement gallery as a tab in homepage.
