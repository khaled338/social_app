import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:socialll_app/main.dart';




class ThirdPage extends StatefulWidget {

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  final user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = "";
   var  image;
  String email="";
  var loading=false;
  var facebookLogin = FacebookLogin();
  void _logInWithFacebook ()async {
    setState(() {
      loading = true;
    });
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();

      final userData = await FacebookAuth.getInstance().getUserData();
      final facebookAuthCredintial = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredintial);

      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name']
      });
      final FacebookLoginResult result =
      await FacebookLogin().logIn(['email']);
      final FacebookAccessToken accessToken = result.accessToken;
      var  url =
       Uri.parse(  'https://graph.facebook.com/v13.0/me?fields=name,first_name,last_name,email,picture&access_token=${accessToken.token}');
      http.Response graphResponse = await http.get(url);
      var profile = json.decode(graphResponse.body);
      setState(() {
        image=profile['picture']['data']['url'];
        name=profile['name'];
        email=profile['email'];
      });

    } on FirebaseAuthException catch (e) {
      var title = '';
      switch (e.code) {
        case 'account-exists-with-different-credintial':
          title = 'this account exists-with a diffferent sign in provider';
          break;
        case'invalid-credintial':
          title = 'unknown error has occurred';
          break;
        case 'operation-not-allowed':
          title = 'this operation not allowed';
          break;
        case 'user-disabled':
          title = 'this user you tried to log into is disabled';
          break;
        case 'user-not-found':
          title = 'this user you tried to log into was not found';
          break;
      }
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('log in with facebook failed'),
            content: Text(title),
            actions: [TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('ok'))
            ],
          ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  Future<void> signOut() async {

    await facebookLogin.logOut();
    await FirebaseAuth.instance.signOut();

  }
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    _logInWithFacebook();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(


          title: const Text('Logged With Facebook',style: TextStyle(color: Colors.white),),

          centerTitle: true,
          backgroundColor: Colors.grey[900],
          actions: [

            TextButton(onPressed: ()async{
             await FacebookAuth.i.logOut();
             await FacebookLogin().logOut();
              signOut();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Login Screen',)), (route) => false);
              setState(() {

              });

            }, child: Text("Logout",style: TextStyle(color: Colors.blue),))
          ],
        ),
        body:

        Container(
          alignment: Alignment.center,
          color: Colors.lightBlueAccent,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(loading) ...[
         const SizedBox(height: 15,),
         const Center(child: const CircularProgressIndicator()),

              ],
              if(!loading) ...[
              Text('Profile',style: TextStyle(fontSize: 40,color: Colors.black87),),
              SizedBox(height: 32,),
            image!=null ?
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image),
            ):Container(),

              SizedBox(height: 20,),
              Text("Name:  "+name,style: TextStyle(color: Colors.black87,fontSize: 28),),
              SizedBox(height: 15,),

              Text("Email:  "+email,style: TextStyle(color: Colors.black87,fontSize: 28),),



            ],
      ],
          ),
        )
    );
  }
}
