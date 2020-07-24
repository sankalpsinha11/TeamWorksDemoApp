import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teamworkapp/main.dart';
import 'package:teamworkapp/signIn.dart';

class draw extends StatefulWidget {

  String email;
  String name;
  draw(this.email , this.name , {Key key}):super(key:key);
  @override
  _drawState createState() => _drawState();
}

class _drawState extends State<draw> {

  logout(){
    FirebaseAuth.instance.signOut().then((value){
      print("Custom user logged out");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          ModalRoute.withName('/'));
    }).catchError((e){
      print(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [const Color(0xff213A50), const Color(0xff071930)],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight)
              ),
              accountName: Text(widget.name, style: TextStyle(
                color: Colors.white,fontFamily: 'Poppins',
              ),),
              accountEmail: Text(widget.email, style: TextStyle(
                color: Colors.white,fontFamily: 'Poppins',
              ),),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(
                  child: Text(
                   widget.name[0],
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                ListTile(
                  title: Text("About",style: TextStyle(color:Colors.white,fontSize: 19.0,fontFamily: 'OpenSans')),
                  leading: Icon(Icons.description,color: Colors.white,),
                  onTap: (){
                    showAboutDialog(
                      context: context ,
                      applicationIcon: FlutterLogo(),
                      applicationLegalese: "Thanks for using Team Works' App!",
                      applicationName: "Team Works",
                      applicationVersion: '1.0.0',
                    );
                  },
                ),
                ListTile(
                  title: Text("Logout",style: TextStyle(color:Colors.white,fontSize: 19.0,fontFamily: 'OpenSans')),
                  leading: Icon(Icons.exit_to_app,color: Colors.white,),
                  onTap: (){
                    logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
