import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged With Google',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          TextButton(onPressed: ()async{
            FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          }, child: Text("Logout",style: TextStyle(color: Colors.blue),))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile',style: TextStyle(fontSize: 40,color: Colors.black87),),
            SizedBox(height: 32,),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),

            SizedBox(height: 20,),
            Text("Name:  "+user.displayName!,style: TextStyle(color: Colors.black87,fontSize: 28),),
            SizedBox(height: 15,),
            Text("Email:  "+user.email!,style: TextStyle(color: Colors.black87,fontSize: 28),),

          ],
        ),
      )
    );

  }
}
