import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamworkapp/drawer.dart';

class homepage extends StatefulWidget {

  String email;
  homepage(this.email , {Key key}) : super(key : key);
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  String contact_number = "+91 9123456789";
  String mail = "abcde@xyz.com";
  File _image;
  final picker = ImagePicker();
  List<Photo> list = List();
  var isLoading = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _fetchData();
    getDetails(widget.email);
    super.initState();
  }

  String Name;
  String Email;

  Future getDetails(email) async {
    try {
      DocumentReference docs = Firestore.instance.collection('User').document(email);
      await docs.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          setState(() {
            Name = datasnapshot.data['Name'];
            Email = datasnapshot.data['email'];
          });
          print("Done");
        }
        else {
          print("No such User");
        }
      });
    } catch(e){
      print(e);
    }
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future getImage() async {
    try{
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
    }catch(e){
      print(e);
    }
  }

  dialPhone() async{
    var url = "tel:"+contact_number;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw "Could not call";
    }
  }

  sendMail() async{
    var url = "mailto:"+mail+"?subject=Hello There";
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw "Could not send a mail";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return null;
      },
      child: new Scaffold(
        key : _key,
        drawer: draw(Name, Email),
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon : Icon(Icons.menu) ,
            onPressed: (){
              _key.currentState.openDrawer();
            },
            color: Colors.white,),
          backgroundColor: Color(0xFF73AEF5),
          elevation: 0.0,
          title: new Text("HomePage" , style: TextStyle(
            fontWeight: FontWeight.w500 , fontFamily: 'OpenSans' , fontSize: 20.0
          ),),
          bottom: TabBar(
            unselectedLabelColor: Colors.white54,
            labelColor: Colors.white,
            tabs: [
              new Tab(
                child: Text("Contact us" , style: TextStyle(
                    fontFamily: 'OpenSans'
                ),),
              ),
              new Tab(
               child: Text("Images" , style: TextStyle(
                fontFamily: 'OpenSans'
              ),),
              ),
              new Tab(
                child: Text("View Images" , style: TextStyle(
                    fontFamily: 'OpenSans'
                ),),
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,),
          bottomOpacity: 1,
        ),
        body: TabBarView(
          children: [
            Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Contact us :",style: TextStyle(
                        fontFamily: 'OpenSans' , fontSize: 20.0,fontWeight: FontWeight.w700,color: Colors.white
                    ),),
                  ),
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Phone Number : ",style: TextStyle(
                          fontFamily: 'OpenSans' , fontSize: 20.0,fontWeight: FontWeight.w700,color: Colors.white
                        ),),
                      GestureDetector(
                        onTap: (){
                          dialPhone();
                        },
                        child: Text(contact_number,style: TextStyle(
                          decoration: TextDecoration.underline,
                            fontFamily: 'OpenSans' , fontSize: 20.0,fontWeight: FontWeight.w700,color: Colors.white
                        ),),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Email : ",style: TextStyle(
                          fontFamily: 'OpenSans' , fontSize: 20.0,fontWeight: FontWeight.w700,color: Colors.white
                      ),),
                      GestureDetector(
                        onTap: (){
                          sendMail();
                        },
                        child: Text(mail,style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'OpenSans' , fontSize: 20.0,fontWeight: FontWeight.w700,color: Colors.white
                        ),),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
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
              child: (_image == null) ? Center(
                child:  Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  width: MediaQuery.of(context).size.width*0.8,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      getImage();
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.photo ,size: 22.0, color: Color(0xFF527DAA) ),
                        SizedBox(width: 4.0,),
                        Text(
                          'Gallery',
                          style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans'
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ): GestureDetector(
                onTap: (){
                  setState(() {
                    _image = null;
                  });
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal : 30.0 , vertical: 150.0),
                      child: Image.file(_image , fit: BoxFit.cover,)
                  ),
                ),
              )
            ),
            Container(
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
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context , index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 20.0),
                        width: MediaQuery.of(context).size.width,
                       height: 200,
                       child : Image.network(
                          list[index].Url,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text("ID", style: TextStyle(
                              decoration: TextDecoration.underline,
                                fontFamily: 'OpenSans' , fontSize: 20.0 , color: Colors.white,fontWeight: FontWeight.w700
                            ),),
                            Text( " : "+ list[index].ID.toString() , style: TextStyle(
                              fontFamily: 'OpenSans' , fontSize: 20.0 , color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.0 , vertical: 3.0),
                        child:  Row(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                          children: <Widget>[
                            Text("TITLE", style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'OpenSans' , fontSize: 20.0 , color: Colors.white,fontWeight: FontWeight.w700
                            ),),
                            Flexible(
                              child: Text( " : "+ list[index].title , style: TextStyle(
                                  fontFamily: 'OpenSans' , fontSize: 20.0 , color: Colors.white
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
          controller: _tabController,),
      ),
    );
  }
}

class Photo {
  final int ID;
  final String title;
  final String Url;
  Photo._({this.ID , this.title, this.Url});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      ID : json['id'],
      title: json['title'],
      Url: json['url'],
    );
  }
}
