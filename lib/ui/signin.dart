import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slate_test/ui/forgot_password.dart';
import 'package:slate_test/ui/routes.dart';
import 'screen_util.dart';
import 'login_component.dart';
import 'package:slate_test/home.dart';
import 'sign_up.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


    ///TODO Cloud Messaging for Notifications
    // final FirebaseMessaging _messaging =FirebaseMessaging();


    String _email,_password;
    bool isLoading =false;

    final _formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();
    var _key =new GlobalKey<ScaffoldState>();

    final Map<String, dynamic> formData={'email':null, 'password':null};

    final focusPassword = FocusNode();

    // bool _autoValidate =false;

    bool _obscureText =true;
    void _toggle(){  // To toggle the visibility of password field
        setState(() {
            _obscureText=!_obscureText;
        });
    }

    @override
    Widget build(BuildContext context) {
        return SafeArea(
          child: Scaffold(
              key: _scaffoldkey,
              body: Form(
                  key: _formKey,
                  // autovalidate: _autoValidate, /// Of No USE...
                  child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                          /*Container(
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
                          ),*/
                          BackgroundImageWidget(
                              //color: Colors.white,

                          ),

                          /*Material(
                            type: MaterialType.transparency,
                            child: ListView(),
                          ),*/

                          ListView(
                              children: <Widget>[
                                  Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(2.0, Constant.sizeXXXL, 2.0, 20.0),
                                        child: Image(
                                            image: AssetImage('assets/images/logo.png'),
                                        ),
                                      ),
                                  ),
                                  Container(
                                      height: Constant.sizeMedium,
                                  ),
                                    Padding(
                                      padding: EdgeInsets.only(left:Constant.screenWidthTenth, right: Constant.screenWidthTenth),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Constant.sizeExtraSmall,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.green
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                           child: TextFormField(
                                        decoration: InputDecoration(
                                              icon: Icon(Icons.mail_outline),
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                                              hintText: 'type your email-id',
                                              hintStyle: TextStyle(fontStyle: FontStyle.italic,
                                                  fontSize: 13.0,
                                                  color: Colors.grey),
                                        ),
                                        validator: (String value){
                                              if (!RegExp(
                                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                  .hasMatch(value)){
                                                  return "This is not a valid email";
                                              }


                                        },

                                        onSaved: (String value){
                                              formData['email']=value;
                                              _email=value;
                                        },

                                        textInputAction: TextInputAction.next, // will show next instead of return button in keyboard
                                        onFieldSubmitted: (v){
                                              FocusScope.of(context).requestFocus(focusPassword);
                                        },
                                  ),
                                         ),
                                    ),
                                // Container 1,
                                  Container(
                                      height: Constant.sizeXXL,
                                  ),

                                  /*Column(
                                      children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.all(20.0),
                                          ),*/
                                          Padding(
                                            padding: EdgeInsets.only(left: Constant.screenWidthTenth,right: Constant.screenWidthTenth),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: Constant.sizeExtraSmall
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.green
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                ),

                                                child: TextFormField(
                                                    obscureText: _obscureText,
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons.lock),
                                                        suffixIcon: IconButton(
                                                            icon: Icon(
                                                                _obscureText ? Icons.visibility:Icons.visibility_off,
                                                                color: Theme.of(context).primaryColorDark,
                                                            ),
                                                            onPressed: (){
                                                                _toggle();
                                                            },
                                                        ),
                                                        labelText: 'Password',
                                                        labelStyle: TextStyle(
                                                            fontWeight: FontWeight.bold, fontSize: 22.0),
                                                        hintText: 'type your password',
                                                        hintStyle: TextStyle(fontStyle: FontStyle.italic,
                                                            fontSize: 13.0,
                                                            color: Colors.grey),
                                                    ),
                                                    validator: (String value)=>
                                                        (value.isEmpty) ? "Not valid":null
                                                    ,

                                                    onSaved:(String value){
                                                        formData['password']=value;
                                                        _password= value;
                                                    },

                                                    focusNode: focusPassword, //focusPassword is just a global instance of FocusNode and it refers t o the password field
                                                    onFieldSubmitted: (v){
                                                        _submitForm();
                                                    },
                                                ),
                                            ),
                                          ),
                                     // ],
                                  //), // Container 2
                                  Container(
                                      height: Constant.sizeLarge,
                                  ),

                                      Center(
                                          child: RaisedButton(
                                              onPressed: () {
                                                  _scaffoldkey.currentState.showSnackBar(
                                                      new SnackBar( content:
                                                      new Row(
                                                          children: <Widget>[
                                                              new CircularProgressIndicator(),
                                                              new Text("  Signing-In...")
                                                          ],
                                                      ),
                                                      ));
                                                  _submitForm();
                                              },

                                              color: Colors.blue,
                                              child: Text('Login',
                                                  style: TextStyle(fontWeight: FontWeight.bold,
                                                      fontSize: 25.0,
                                                      color: Colors.white),
                                              ),
                                          ),
                                      ),
                                   // Container 3
                                  Container(
                                      height: Constant.sizeMedium,
                                  ),

                                  Padding(
                                      padding: EdgeInsets.only(left: Constant.screenWidthFourth),
                                    child: Row(
                                      children: <Widget>[
                                          Text('New to Slate?',
                                                    style: TextStyle(
                                                        color: Colors.black, fontSize: 16.0,
                                                    ),
                                                ),

                                             InkWell(
                                              child: Text('Sign Up Now!',
                                              style: TextStyle(
                                                  color: Colors.blueAccent, fontSize: 16.0,decoration: TextDecoration.underline
                                                  ),
                                              ),
                                                 onTap: (){
                                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                                                     // AppRoutes.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
                                                 },
                                            ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: Constant.sizeMedium,
                                  ),
                                  Center(
                                    child: InkWell(
                                        child: Text('Forgot password?',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0,decoration: TextDecoration.underline
                                            ),
                                        ),
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                                            // AppRoutes.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
                                        },
                                    ),
                                  ),

                              ],
                          ),
                      ],
                  ),
              )
          ),
        );
    }

    Future<void> _submitForm() async{
        print('Submitting Form');
        if(_formKey.currentState.validate()){
            _formKey.currentState.save();  // onSaved is called
            print('Form is validated!');
            print(formData);
            try{
                AuthResult result =await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                FirebaseUser user= result.user;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(_email)));
                // HomePage(_email)
                //return CircularProgressIndicator();

            }catch(e){
                print(e.message);
                final snackbar=SnackBar(content: Text('wrong password',
                    style: TextStyle(color: Colors.red),
                ),
                    duration: Duration(milliseconds: 1000),
                );
                Scaffold.of(context).showSnackBar(snackbar);
            }
        }
    }

}
