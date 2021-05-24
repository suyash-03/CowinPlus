import 'package:cowin_plus/Screens/sign_in.dart';
import 'package:cowin_plus/Wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cowin_plus/Authentication/by_google.dart';
import 'package:provider/provider.dart';

import 'Screens/HomePage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInWithGoogle>(context);

    //Create Stream Builder for FirebaseAuth.instance
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.hasData)
              {
                return HomePage();
              }
              else if(provider.isSigningIn){
                return CircularProgressIndicator();
              }
              else{
                return SignInPage();
              }

            }
        ),
      ),
    );
  }
}
