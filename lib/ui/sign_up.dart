import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {

      // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: <Widget>[
                    Container(
                      child: Opacity(
                          opacity: 0.1,
                          child: FittedBox(
                              fit: BoxFit.fill,
                            child: Image(
                                image: AssetImage('assets/images/background.png'),
                                //fit: BoxFit.contain,
                                //width: MediaQuery.of(context).size.width*1.0,
                                //height: MediaQuery.of(context).size.height*1.1,
                            ),
                          ),
                      ),
                    ),
                  /*Stack(
                      children: <Widget>[
                          ListView(

                          )
                      ],
                  )*/
              ],
          ),
        ),
    );
  }
}
