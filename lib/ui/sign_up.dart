import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slate_test/home.dart';
import 'package:slate_test/ui/login_component.dart';
import 'package:slate_test/ui/signin.dart';
import 'logo_widget.dart';
import 'screen_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

    String _email,_password;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

      // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        key: _key,
        appBar: AppBar(
            title: Text( 'Profile Information',
                style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey,
            automaticallyImplyLeading: false,
        ),
        body: Form(
            key: _formKey,
          child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                    BackgroundImageWidget(
                        // Loads the background image.
                    ),
                  ListView(
                      children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.only(left:Constant.screenWidthTenth, right: Constant.screenWidthTenth),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Email',
                                        ),
                                        validator: (String value){
                                            if (!RegExp(
                                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                .hasMatch(value)){
                                                return "This is not a valid email";
                                            }
                                        },
                                        onSaved: (value)=> _email=value,
                                    ),
                          ),
                          Container(
                              height: Constant.sizeMedium,
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:Constant.screenWidthTenth, right: Constant.screenWidthTenth),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                  ),
                                  validator: (value){
                                      if(value.length<5){
                                          return 'Password must be more than 4 characters';
                                      }
                                  },
                                  onSaved: (value)=> _password=value,
                              ),
                          ),
                          RaisedButton(
                              onPressed: (){
                                  signUp();
                              },
                              child: Text('Sign Up!'),
                          ),

                      ],
                  )
              ],
          ),
        ),
    );
  }

    Future<void> signUp() async {
      final formState = _formKey.currentState;
      if(formState.validate()){
          formState.save();
          try{
              AuthResult result =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
              FirebaseUser user= result.user;
              //await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));

          } catch(e){
                print(e.message);
                final snackbar =SnackBar(content: Text('Something is wrong',
                    style: TextStyle(color: Colors.red),
                ),
                    duration: Duration(milliseconds: 1000),
                );
                _key.currentState.showSnackBar(snackbar);
          }

      }

    }
}
