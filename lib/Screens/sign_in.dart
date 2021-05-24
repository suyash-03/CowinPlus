import 'package:animate_do/animate_do.dart';
import 'package:cowin_plus/Authentication/by_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInWithGoogle>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        //Gradient Background
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
          )
        ),

        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/4,),
            FadeInLeft(
              child: Text('Cowin +',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: 'DelaGothic',
                shadows: <Shadow> [
                  Shadow(
                    color: Colors.purple,
                    offset: Offset(5,6)
                  )

                ]
              ),),
            ),
            SizedBox(height: 20,),
            FadeInLeft(
              child: Text('Sign In to Continue',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'Montserrat'
              ),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/6,),

            FadeInLeft(

              child: SignInButtonBuilder(backgroundColor: Colors.deepPurpleAccent,
                onPressed: (){
                provider.SignInGoogle(context);
                },
                text: 'Sign In With Google',
                icon: FontAwesomeIcons.google,
                height: 50,
              ),
            ),



          ],
        ),
      ),
    );
  }
}
