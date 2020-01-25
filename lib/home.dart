import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slate_test/drawer_pages/bookmarks.dart';
import 'package:slate_test/drawer_pages/contact_us.dart';
import 'package:slate_test/ui/routes.dart';
import 'package:slate_test/ui/screen_util.dart';
import 'package:slate_test/ui/signin.dart';
import 'package:slate_test/ui/test.dart';

import 'package:slate_test/drawer_pages/my_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_crop/image_crop.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slate_test/drawer_pages/feed_back.dart';

class HomePage extends StatefulWidget {

    String _email;
    HomePage(this._email);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    bool loggedIn=false;

    File image;
    final cropKey = GlobalKey<CropState>();


    Future picker() async{
      //print('Picker is called');
      File img=await ImagePicker.pickImage(source: ImageSource.gallery);
      //print(img.path);
      if(img!=null){
          setState(() {
              // Called to update the UI when we select the image.
              image=img;
          });
      }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text('HomePage'),
        ),
        drawer: Drawer(
            child: ListView(
                children: <Widget>[
                    UserAccountsDrawerHeader(
                        accountEmail: Text(widget._email),
                        accountName: Text('Hello'),
                        currentAccountPicture: GestureDetector(
                            onTap: (){
                                if(image==null){
                                    picker();
                                }
                            } ,
                          child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: ClipOval(
                                  child: SizedBox(
                                      width: 70.0,
                                      height: 70.0,
                                      child: (image==null)?Icon(Icons.add_a_photo):Image.file(image,fit: BoxFit.fill,),
                                  ),
                              ),
                              //child: image==null?Icon(Icons.add_a_photo):Image.file(image),
                          ),
                        ),
                    ),
                    ListTile(
                        title: Row(
                        children: <Widget>[
                            Icon(Icons.account_circle),
                            Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                            Text('My profile',style: TextStyle(fontSize: 20.0),),
                        ],
                    ),

                    onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                        }

                    ),
                    ListTile(
                        title: Row(
                            children: <Widget>[
                                Icon(Icons.bookmark_border),
                                Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                                Text('Bookmarks',style: TextStyle(fontSize: 20.0),),
                            ],
                        ),

                        onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks()));
                        }

                    ),
                    ListTile(
                        title: Row(
                            children: <Widget>[
                                Icon(Icons.feedback),
                                Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                                Text('Feedback',style: TextStyle(fontSize: 20.0),),
                            ],
                        ),

                        onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
                        }

                    ),
                    ListTile(
                        title: Row(
                            children: <Widget>[
                                Icon(Icons.email),
                                Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                                Text('Contact Us',style: TextStyle(fontSize: 20.0),),
                            ],
                        ),

                        onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                        }

                    ),

                    ListTile(
                        title: Row(
                            children: <Widget>[
                                Icon(Icons.lock),
                                Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                                Text('Sign out',style: TextStyle(fontSize: 20.0),),
                            ],
                        ),

                        onTap: (){
                            _signOut();
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                        }

                    ),

                    /*_createDrawerItem(icon: Icons.account_circle,text: 'My Profile',
                        onTap: ()=>
                            Navigator.pushReplacementNamed(context,my_profile)
                    ),
                    _createDrawerItem(icon: Icons.contacts,text: 'Contacts',),
                    _createDrawerItem(icon: Icons.bookmark,text: 'Bookmarks',),
                    _createDrawerItem(icon: Icons.feedback,text: 'Feedback',),
                    _createDrawerItem(icon: Icons.mail_outline,text: 'About Us',),*/

                ],
            ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: <Widget>[
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue[200],
                        child: Container(
                            width: MediaQuery.of(context).size.width ,
                            height: MediaQuery.of(context).size.height*0.7,
                            //child: Center(child:Text('I am a ROW'),),
                        ),
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue[600],
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.7,

                        ),
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.blue[200],
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.7,

                        ),
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.blue[700],
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.7,

                        ),
                    )
                ],
            ),

        )
         ,
    );

    /*Scaffold loginScaffold =new Scaffold(
        appBar: new AppBar(title:Text('Login')),
    );*/
  }

  Widget _createDrawerItem({IconData icon, String text,GestureTapCallback onTap}){ // Unused.
        return ListTile(
          title: Row(
              children: <Widget>[
                  Icon(icon),
                  Padding(padding: EdgeInsets.only(left:Constant.screenWidthTenth)),
                  Text(text,style: TextStyle(fontSize: 20.0),),
              ],
          ),
            onTap: onTap
        );
  }

  final FirebaseAuth firebaseAuth= FirebaseAuth.instance;

  /*Future<Null> _function() async{
      SharedPreferences prefs;
      prefs= await SharedPreferences.getInstance();
      this.setState((){
         if(prefs.getString("username")!=null){
             loggedIn= true;
         }else{
             loggedIn= false;
         }
      });
  }*/

  void _signOut() async{
        await firebaseAuth.signOut();
        runApp(
          new MaterialApp(
              home: new SignIn(),
          )
        );
  }
}
