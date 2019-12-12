import 'package:flutter/material.dart';
import 'package:slate_test/ui/splash_screen.dart';
import 'UI/sign_up.dart';
import 'UI/forms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: SplashScreen(),
    );
  }
}
