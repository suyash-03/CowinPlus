import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:cowin_plus/Screens/State&City/choose_city.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../StateCityForm.dart';

class SlotsByCity extends StatefulWidget {

  @override
  _SlotsByCityState createState() => _SlotsByCityState();
}

class _SlotsByCityState extends State<SlotsByCity> {

  List<dynamic> statesListFinal;
  int stateId;


  Future<List<dynamic>> getStateList() async
  {
    List<dynamic> stateListDynamic = [];
    var stateResponse = await http.get(Uri.
    parse("https://cdn-api.co-vin.in/api/v2/admin/location/states"));
    Map body = await jsonDecode(stateResponse.body);
    stateListDynamic = body["states"];
    statesListFinal = stateListDynamic;
    return statesListFinal;
  }

  @override
  Widget build(BuildContext context) {
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
                ],),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: FaIcon(
                    FontAwesomeIcons.backward, color: Colors.white,)
                      , onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Choose Your State',
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
              future: getStateList(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: statesListFinal.length,
                      itemBuilder: (context, index) {
                        return SlideInLeft(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    statesListFinal[index]["state_name"]),
                                onTap: () {
                                  setState(() {
                                    stateId =
                                    statesListFinal[index]["state_id"];
                                    print(stateId);
                                  }
                                  );
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => SelectCity(stateId)));
                                  },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                else if (snapshot.hasData == false) {
                  return CircularProgressIndicator();
                }
                else {
                  return Text("Can't Get Data");
                }
              }
          )
        ],
      ),
    );
  }
}

