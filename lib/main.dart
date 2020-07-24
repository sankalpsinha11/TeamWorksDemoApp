import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamworkapp/signIn.dart';
import 'package:teamworkapp/signupPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Works Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(fontFamily: 'OpenSans',
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(fontFamily: 'OpenSans',
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(230.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(fontFamily: 'OpenSans',
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800])),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.04,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: MediaQuery.of(context).size.width*0.87,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => new LoginScreen()
                    ));
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans'
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: MediaQuery.of(context).size.width*0.87,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new SignUpScreen()));
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue[800],
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans'
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

