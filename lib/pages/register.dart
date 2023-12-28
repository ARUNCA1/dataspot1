import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  ),
);

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool showSpinner = false;
  TextEditingController _email=new TextEditingController();
  TextEditingController _password=new TextEditingController();
  final SnackBar _snackBar = SnackBar(
    content: const Text('Details not correct'),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
  );  @override
  final SnackBar _snackBa = SnackBar(
    content: const Text('Make ur password very strong'),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
  );
  final SnackBar _snackB = SnackBar(
    content: const Text('Aleardy you have a account'),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.red,
  );
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: Text("Register Form" ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                    onChanged: (value) {

                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black), //<-- SEE HERE
                      ),
                    ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        email = value;
                        //Do something with the user input.
                      },
                    decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black), //<-- SEE HERE
                      ),
                    ),),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                    onChanged: (value) {

                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: "Gender",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black), //<-- SEE HERE
                      ),
                    ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    obscureText: true,
                    controller: _password,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.black), //<-- SEE HERE
                      ),
                    ),),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(
                  colour: Colors.pink,
                  title: 'Next',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: _email.text, password:_password.text);
                      if (newUser != null) {
                        Navigator.pushNamed(context, 'home_screen');
                      }
                    } catch (e) {
                      print(e.toString()+"kkkkkkkkk");
                      if(e.toString()=="[firebase_auth/channel-error] Unable to establish connection on channel."){
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      if(e.toString()==" [firebase_auth/invalid-email] The email address is badly formatted.")
                        {
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }
                      }
                     else if(e.toString()=="[firebase_auth/weak-password] Password should be at least 6 characters"){
                        ScaffoldMessenger.of(context).showSnackBar(_snackBa);
                      }
                     else if(
                      e.toString()=="[firebase_auth/email-already-in-use] The email address is already in use by another account."
                      ){
                        ScaffoldMessenger.of(context).showSnackBar(_snackB);

                      }

                     // else if(){}
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),

    );
  }
}