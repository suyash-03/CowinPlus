import 'package:animate_do/animate_do.dart';
import 'package:cowin_plus/Authentication/by_google.dart';
import 'package:cowin_plus/Screens/State&City/slots_by_city.dart';
import 'package:cowin_plus/Screens/slots_by_pin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInWithGoogle>(context);


    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.yellow[800],
                      Colors.yellow[700],
                      Colors.yellow[600],
                      Colors.yellow[400],
                    ],),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SlideInLeft(
                      child: Container(
                        child: CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text('Cowin +',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'DelaGothic',
                              shadows: <Shadow> [
                                Shadow(
                                    color: Colors.purple,
                                    offset: Offset(2,2)
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    SlideInRight(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                        child: FlatButton.icon(onPressed: (){
                          provider.SignOutGoogle(context);
                        },
                            icon: FaIcon(FontAwesomeIcons.signOutAlt,color: Colors.red,size: 40,),
                            label: Text('')),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              FadeInUp(
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black)
                  ),
                  child: FlatButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> SlotsByPin()));
                  },
                      child: Text("Enter your \nPIN",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Montserrat'
                        ),)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FadeInUp(
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black)
                  ),
                  child: FlatButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> SlotsByCity()));
                  },
                      child: Text("Choose your \nSTATE and CITY",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat'
                        ),)
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height/4,),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,0,10,0),
            child: Center(
                child: Text("Hi ${FirebaseAuth.instance.currentUser.displayName} help Curb the Spread of Covid 19 by quickly getting vaccinated",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontFamily: 'Montserrat'
                ),)
            ),
          )

        ],

      ),
    );
  }

}


