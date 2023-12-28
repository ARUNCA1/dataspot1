import 'package:dataspottest2/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custome/button.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String ?email;
  String ?password;
  bool showSpinner = false;
  bool _isHidden = true;
  bool passVisible = true;
  final SnackBar _snackBar = SnackBar(
    content: const Text('Details not correct'),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: Text("Login" ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
             SizedBox(height: 20,),
              Container(
                height: 50,
                child: TextField(

                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                  decoration: InputDecoration(
                    hintText: "email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black), //<-- SEE HERE
                    ),
                  ),),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 50,
                child: TextField(

                    obscureText: passVisible,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                  decoration: InputDecoration(
                   hintText: "password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black), //<-- SEE HERE
                    ),
                  ),),
              ),
              SizedBox(
                height: 24.0,
              ),
              Button(
                  colour: Colors.pink,
                  title: 'Log In',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      if (user != null) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          prefs.setBool('isLogin', true);
                        });

                        Navigator.pushNamed(context, 'home_screen');
                      }
                    } catch (e) {

                      if(e.toString()=="[firebase_auth/invalid-email] The email address is badly formatted."){

                       ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                      }
                      else if(e.toString()=="[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Text("Not registred yet ?"),
                 TextButton(onPressed: (){
                   Navigator.pushReplacement(
                       context, MaterialPageRoute(builder: (builder) => RegistrationScreen()));
                 }, child: Text("Create an account",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
               ],
              )
            ],
          ),
        ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

