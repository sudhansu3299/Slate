 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:slate_test/ui/splash_screen.dart';
import 'UI/sign_up.dart';
import 'UI/signin.dart';

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

/*class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {

  final Firestore _db= Firestore.instance;
  final FirebaseMessaging _fcm =FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message)async{
        print("onMessage: $message");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;

  }
}*/

