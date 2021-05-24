import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../ListWidgetPin.dart';

class SlotsByPin extends StatefulWidget {

  @override
  _SlotsByPinState createState() => _SlotsByPinState();
}

class _SlotsByPinState extends State<SlotsByPin> {

  String pinCode="";
  List<dynamic> appointmentListDynamic=[];
  List<dynamic> sessions =[];


  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();

    DateTime _dateTimeToday= new DateTime.now();
    DateTime _dateTimeTomorrow= new DateTime.now().add(const Duration(days: 1));
    String formattedDateToday = DateFormat('dd-MM-yyyy').format(_dateTimeToday);
    String formattedDateTomorrow = DateFormat('dd-MM-yyyy').format(_dateTimeTomorrow);

    //API Request by PIN for Slots Today
    Future<List<dynamic>> getAppointmentByPinToday() async{
      var appointmentResponse = await http.get(Uri.parse
        ("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode="+pinCode+"&date="+formattedDateToday));
      Map body = await jsonDecode(appointmentResponse.body);
      appointmentListDynamic = body["sessions"];
      // print(appointmentListDynamic);
      return appointmentListDynamic;
    }
    //API Request by PIN for Slots Tomorrow
    Future<List<dynamic>> getAppointmentByPinTomorrow() async{
      var appointmentResponse = await http.get(Uri.parse
        ("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode="+pinCode+"&date="+formattedDateTomorrow));
      Map body = await jsonDecode(appointmentResponse.body);
      appointmentListDynamic = body["sessions"];
      // print(appointmentListDynamic);
      return appointmentListDynamic;
    }


    return Scaffold(
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 80,
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
                  children: [
                    SlideInLeft(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20,6,0,0),
                        child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.backward,color: Colors.white,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text("PINCODE",
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
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width/1.2,
                child: TextField(
                  //Text Field Decoration
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city_rounded),
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow[800],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Enter Your PinCode',
                    helperText: 'PINCODE should have 6 digits'
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value){
                    setState(() {
                      pinCode=value;
                      print(pinCode);
                    });
                  },
                ),
              ),
              SizedBox(height: 50,),
              
              FadeInLeft(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.yellow[500],
                    border: Border.all(color: Colors.black)
                  ),

                  child: MaterialButton(
                    onPressed: () async {
                      await getAppointmentByPinToday().then((value) {
                        setState(() {
                        });
                      });
                      sessions = appointmentListDynamic;
                      print(sessions);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ListWidgetPin(sessions)));
                      },
                    child: Text("Check for Slots Today: " + formattedDateToday),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FadeInLeft(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.yellow[500],
                      border: Border.all(color: Colors.black)
                  ),

                  child: MaterialButton(
                    onPressed: () async {
                      await getAppointmentByPinTomorrow().then((value) {
                        setState(() {
                        });
                      });
                      sessions = appointmentListDynamic;
                      print(sessions);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ListWidgetPin(sessions)));
                    },
                    child: Text("Check for Slots Tomorrow: " + formattedDateTomorrow),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/6,),
              FadeInUp(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Image.asset("assets/needle-transparent.png",
                    width: MediaQuery.of(context).size.width/1.5,
                    height: MediaQuery.of(context).size.height/2.8,
                    fit: BoxFit.cover,
                  color: Colors.grey,),
                ),
              )

            ]
          ),
        ],
      ),
    );
  }
}

