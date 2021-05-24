import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';

import 'ListWidgetCity.dart';

class SelectCity extends StatefulWidget {
  final int stateId;
  SelectCity(this.stateId);

  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {

  List<dynamic> cityListFinal;
  int cityId;

  Future<List> getCityList() async{
    List<dynamic> cityListDynamic =[];
    var cityResponse = await http.get(Uri.parse("https://cdn-api.co-vin.in/api/v2/admin/location/districts/"+"${widget.stateId}"));
    Map body = await jsonDecode(cityResponse.body);
    cityListDynamic=body["districts"];
    cityListFinal=cityListDynamic;
    return cityListFinal;
  }

  @override
  Widget build(BuildContext context) {

    DateTime _dateTimeToday= new DateTime.now();
    DateTime _dateTimeTomorrow= new DateTime.now().add(const Duration(days: 1));
    String formattedDateToday = DateFormat('dd-MM-yyyy').format(_dateTimeToday);
    String formattedDateTomorrow = DateFormat('dd-MM-yyyy').format(_dateTimeTomorrow);

    return Scaffold(
      body: Column(
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
                ],
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: FaIcon(FontAwesomeIcons.backward,color: Colors.white,),
                      onPressed: (){
                    Navigator.pop(context);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                  child: Text('Choose Your City',
                    style: TextStyle(
                    fontSize: 23,
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
                ),],
            ),
          ),
          SizedBox(height: 10,),
          FutureBuilder(
              future: getCityList(),
              builder: (context,AsyncSnapshot<List> snapshot){
                if(snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: cityListFinal.length,
                      itemBuilder: (context, index) {
                        return SlideInLeft(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10,2,10,2),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    cityListFinal[index]["district_name"]),
                                onTap: () {
                                  setState(() {
                                    cityId = cityListFinal[index]["district_id"];
                                    print(cityId);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCity(stateId)));
                                  }
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          title: Text('Pick a Date'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("$formattedDateToday",
                                              style: TextStyle(
                                                color: Colors.blue
                                              ),),
                                              onPressed: (){
                                                Navigator.push(context,
                                                MaterialPageRoute(builder: (context)=>ListWidgetCity(formattedDateToday,cityListFinal[index]["district_name"],cityId.toString()))
                                                );
                                                },
                                            ),
                                            TextButton(
                                              child: Text("$formattedDateTomorrow",
                                              style: TextStyle(
                                                color: Colors.blue
                                              ),),
                                              onPressed: (){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=>ListWidgetCity(formattedDateTomorrow,cityListFinal[index]["district_name"],cityId.toString()))
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                  },
                              ),
                            ),
                          ),
                        );
                        },
                    ),
                  );
                }
                else if(snapshot.hasData == false){
                  return CircularProgressIndicator();
                }
                else{
                  return Text("Can't Get Data");
                }
              }
              )
        ]
      )
    );
  }
}
