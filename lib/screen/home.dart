import 'package:flutter/material.dart';
import 'package:task4/screen/registeration.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,
                       color: Colors.white,
                       size: 36.0,),
                       actions: [
            IconButton(icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 36.0,
                        ),
                        onPressed:
                         null),],
        title: Text("Linux App",style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23),),              
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo1.png'),
              SizedBox(height: 30),
              Material(
                borderRadius: BorderRadius.circular(100
                ),
                color: Colors.blue,
                child: MaterialButton(
                  minWidth: 200,
                  height: 50,
                  child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23)),
                  
                  onPressed: () {
                    Navigator.push(
                               context,
                                MaterialPageRoute(
                                builder: (context) => Register()),
                                );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}