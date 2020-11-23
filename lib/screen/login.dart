import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/animation/fadeanimation.dart';
import 'package:task4/screen/command.dart';
import 'package:task4/screen/registeration.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  bool ssloader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: ssloader,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0xFFF206ffd),
              Color(0xFFF3280fb),
              Color(0xFFF28c3eb),
              Color(0xFFff4b5c),
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        1.1,
                        Text("Login ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFf4f7fc),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(children: [
                        SizedBox(height: 30),
                        FadeAnimation(
                            1.6,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.mail,size: 40),
                                  labelText: "Enter Email",
                                  hintText: "email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 20),
                        FadeAnimation(
                            1.9,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                obscureText: true,
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock_outline,size: 40),
                                  labelText: "Enter Password",
                                  hintText: "password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 30),
                        FadeAnimation(
                            2.5,
                            Container(
                              //color: Colors.blue,
                              child: MaterialButton(
                                splashColor: Colors.teal[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 0.3,
                            height: 50,
                            minWidth: 300,
                                  color: Colors.blue,
                                  onPressed: () async {
                                    setState(() {
                                      ssloader = true;
                                    });
                                    try {
                                      var user = await authc
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      if (user != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Command()),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Register()),
                                        );
                                      }
                                      print(user);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )),
                      ]),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
