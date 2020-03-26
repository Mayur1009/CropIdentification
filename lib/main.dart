import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import './screens/home_page.dart';
import './providers/image_object.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primarySwatch: Colors.indigo,
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) {
          return ChangeNotifierProvider(
            create: (ctx) => ImageObject(),
            child: new MaterialApp(
              title: 'Crop Identification',
              theme: theme,
              home: new MyHomePage(),
            ),
          );
        }
    );

  }
}
