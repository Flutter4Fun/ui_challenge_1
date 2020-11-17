import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_challenge_1/ui_challenge_1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: UiChallenge1(),
      ),
    );
  }

}