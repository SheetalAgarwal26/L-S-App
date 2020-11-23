import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task4/screen/home.dart';

class Command extends StatefulWidget {
  @override
  _CommandState createState() => _CommandState();
}

class _CommandState extends State<Command> {
 var msgtextcontroller = TextEditingController();
  var fordatabase = FirebaseFirestore.instance;
  var authentication = FirebaseAuth.instance;
  var cmd;
  var webdata;

  call() async {
    try {
      var url = 'http://192.168.43.218/cgi-bin/web.py?x=${cmd}';
      var r = await http.get(url);
      webdata = r.body;
      await fordatabase.collection("LinuxCommand").add({
        "$cmd": webdata,
        "cmd": "$cmd",
        "output": webdata,
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Terminal",style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25)),
        leading: IconButton(
            icon: Icon(Icons.account_box,color: Colors.white,
                        size: 50.0,),
            onPressed: () async {
              print("user is now signed off");
              await authentication.signOut();
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed:
                         ()  {  Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()),
                                            );
                                          },)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/l.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "LINUX TERMINAL",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        
                          onChanged: (value) {
                            cmd = value;
                          },
                          autocorrect: false,
                          controller: msgtextcontroller,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          cursorColor: Colors.white,
                          cursorWidth: 4.0,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              hintText: "Enter command",
                              helperStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(
                                  fontSize: 19.0, color: Colors.white),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "  [root@localhost ~]#  ",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow),
                                ),
                              ))),
                    ),
                     SizedBox(
                      height: 0.1,
                    ),
                    Container(
                      child: MaterialButton(
                        elevation: 20.0,
                        height: 35,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        color: Colors.yellow[400],
                        onPressed: () {
                          msgtextcontroller.clear();
                          call();
                        },
                        child: Text("RUN",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 340.0,
                      height: 400.0,
                      color: Colors.black.withOpacity(0.5),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int i) {
                            return StreamBuilder<QuerySnapshot>(
                              builder: (context, snapshot) {
                                print('new data comes');
                                var msg = snapshot.data.docs;
                                List<Widget> y = [];
                                for (var d in msg) {
                                  var command = d.data()['cmd'];
                                  var finaloutput = d.data()['output'];
                                  var msgwid = Text(
                                    "[root@localhost ~]# $command\n$finaloutput",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19.0),
                                  );
                                  y.add(msgwid);
                                }
                                print(y);
                                return Container(
                                  child: Column(
                                    children: y,
                                  ),
                                );
                              },
                              stream: fordatabase
                                  .collection("LinuxCommand")
                                  .snapshots(),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
