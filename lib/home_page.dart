import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialll_app/main.dart';
import 'package:socialll_app/second_screen.dart';

class HomePage extends StatelessWidget {
  @override

    Widget build(BuildContext context) =>
        Scaffold(
            body: StreamBuilder(

                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(),);
                  } else if (snapshot.hasData) {
                    return SecondPage();
                  } else if (snapshot.hasData) {
                    return Center(child: Text("some thing Wrong !"),);
                  } else {
                    return MyHomePage(title: "Login Screen",);
                  }
                }));
  }


