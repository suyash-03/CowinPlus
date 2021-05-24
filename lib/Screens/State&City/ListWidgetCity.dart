import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ListWidgetCity extends StatefulWidget {
  final String date;
  final String cityName;
  final String cityId;
  ListWidgetCity(this.date,this.cityName,this.cityId);

  @override
  _ListWidgetCityState createState() => _ListWidgetCityState();
}

class _ListWidgetCityState extends State<ListWidgetCity> {
  
  List<dynamic> appointmentListFinal;
  
  Future<List<dynamic>> showSlotsCity() async{
    List<dynamic> appointmentListDynamic=[];
    var appointmentResponse = await http.get(Uri.
    parse("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id="+widget.cityId+"&date="+widget.date));
    Map body = await jsonDecode(appointmentResponse.body);
    appointmentListDynamic=body["sessions"];
    appointmentListFinal=appointmentListDynamic;
    return appointmentListFinal;
  }
  
  @override
  Widget build(BuildContext context) {
    print(widget.cityName);
    print(widget.date);
    return Scaffold(
      body: Column( children: <Widget>[
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
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: FaIcon(
                  FontAwesomeIcons.backward, color: Colors.white,),
                    onPressed: () {
                  Navigator.pop(context);
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Centres in ${widget.cityName}',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontFamily: 'DelaGothic',
                    shadows: <Shadow>[
                      Shadow(
                          color: Colors.purple,
                          offset: Offset(2, 2)
                      )
                    ]
                ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        FutureBuilder(
          future: showSlotsCity(),
          builder: (context,AsyncSnapshot<List> snapshot){
            if(snapshot.hasData){
              return Expanded(
                child: ListView.builder(
                  itemCount: appointmentListFinal.length,
                  itemBuilder: (context , index) {
                    print(appointmentListFinal.length);
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
                                Text(appointmentListFinal[index]["name"].toString(),style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"
                                ),
                                ),
                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(appointmentListFinal[index]["address"].toString(),style: TextStyle(
                                    fontSize: 15,
                                  ),),
                                ),
                                SizedBox(height: 5,),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(appointmentListFinal[index]["from"].toString() + "-" + appointmentListFinal[index]["to"].toString(),style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(appointmentListFinal[index]["vaccine"].toString(),style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"
                                  ),),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Min Age: "+appointmentListFinal[index]["min_age_limit"].toString(),style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Montserrat"
                                  ),),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Slots Available(1st Dose):"+appointmentListFinal[index]["available_capacity_dose1"].toString() +"\n" +
                                      "Slots Available(2nd Dose):" + appointmentListFinal[index]["available_capacity_dose2"].toString()
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
              );
            }
            else if(snapshot.data == null){
              return CircularProgressIndicator();
            }
            else{
              return Text("No Data");
            }
            },
        )
      ]
      ),
    );
  }
}

