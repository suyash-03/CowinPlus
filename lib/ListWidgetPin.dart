import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListWidgetPin extends StatelessWidget {

  final List<dynamic> sessions;
  ListWidgetPin(this.sessions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: deprecated_member_use
            SlideInLeft(
              child: FlatButton.icon(onPressed: (){
                Navigator.pop(context);
              }, icon: FaIcon(FontAwesomeIcons.backward), label: Text("")),
            ),
            Text("Available Slots",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DelaGothic',
              fontSize: 20
            ),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context , index) {
            print(sessions.length);
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 6, 5, 4),
              child: SlideInLeft(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.lightBlue,
                  child: ListTile(
                    title: Text((index+1).toString()),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(sessions[index]["name"].toString(),style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"
                        ),
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.center,
                          child: Text(sessions[index]["address"].toString(),style: TextStyle(
                            fontSize: 15,

                          ),),
                        ),
                        SizedBox(height: 5,),
                        Align(
                          alignment: Alignment.center,
                          child: Text(sessions[index]["from"].toString() + "-" + sessions[index]["to"].toString(),style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(sessions[index]["vaccine"].toString(),style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"
                          ),),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Min Age: "+sessions[index]["min_age_limit"].toString(),style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Montserrat"
                          ),),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Slots Available(1st Dose):"+sessions[index]["available_capacity_dose1"].toString() +"\n" +
                              "Slots Available(2nd Dose):" + sessions[index]["available_capacity_dose2"].toString()
                            ,style: TextStyle(
                              fontSize: 13,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
