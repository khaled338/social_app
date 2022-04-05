import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:provider/provider.dart';
import 'package:socialll_app/home_page.dart';
import 'package:socialll_app/login.dart';
import 'package:socialll_app/third_page.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);


  @override



  Widget build(BuildContext context) =>ChangeNotifierProvider(create: (context)=>GoogleSignInProvider(),
   child: MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home:HomePage(),
    ));
  }




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String userEmail = "";

  static final FacebookLogin facebookSignIn = new FacebookLogin();
   var name ="";
   var image;
  var loading=false;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(alignment: Alignment.bottomCenter,
        child:
        Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff6bceff),
                          Color(0xff6bceff)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90)
                      )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize:MainAxisSize.min ,
                    children: <Widget>[
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.person,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 32,
                              right: 32
                          ),
                          child: Text('Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 62),
                  child: Column(
                    children: <Widget>[


                      Form(
                        child: Column(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  validator:(val){
                                    return RegExp(r"^[a-zA-Z0-9.a-zA-z0-9.!#$$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9+\.[a-zA-Z]+").hasMatch(val!) ?
                                    null:"Please provide a valid email";
                                  },
                                  style: TextStyle(color: Colors.black87),


                                  decoration: new InputDecoration(

                                    contentPadding: const EdgeInsets.all(16.0),
                                    hintText: 'Email',

                                    border:  InputBorder.none,
                                    icon: Icon(Icons.email,
                                      color: Color(0xff6bceff),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none),

                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(

                                  validator:(val){
                                    return  val!.length<6 ? "Please Provide Password 6+ character":null;
                                  },
                                  style: TextStyle(color: Colors.black87),
                                  obscureText: true,

                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(16.0),
                                    hintText: 'Password',

                                    border: InputBorder.none,
                                    icon: Icon(Icons.vpn_key,
                                      color: Color(0xff6bceff),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                  ),

                                ),
                              ),
                              FlatButton(
                                onPressed: (){
                                  //forgot password screen
                                },
                                textColor: Colors.blue,
                                child: Text('Forget Password'),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),



                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text('Sign in'),
                        onPressed: () {
                        },
                      )),
                ),
                Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 20,),
                    child: RaisedButton(
                      textColor: Colors.black87,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text('Sign in with Google'),
                      onPressed: () async{
                        final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
                        provider.signInWithGoogle();
                        setState(() {

                        });

                      },
                    )),
                Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 20,),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text('Sign in with Facebook'),
                      onPressed: () =>//logInWithFacebook()



                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>ThirdPage()), (route) => false)


                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text("Don't have account?",style: TextStyle(color: Colors.black),),
                        FlatButton(
                          textColor: Colors.blue,
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )),
      ),
    );
  }


}

