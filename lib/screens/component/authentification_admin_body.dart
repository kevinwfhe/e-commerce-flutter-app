import 'package:flutter/material.dart';

import 'package:csi5112group1project/screens/admin_screen.dart';

class AuthentificationAdminBody extends StatelessWidget {

  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('images/logo.jpg')),
            ),
          ),

          const Padding(
              padding: EdgeInsets.only(top: 10.0),
          ),

            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(225, 240, 240, 240),
                        width: 1.0
                      ),
                    ),
                  ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border:InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                child: Center(
                  child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(225, 240, 240, 240),
                            width: 1.0
                          ),
                        ),
                      ),
                    child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: ' Authentification Code',
                                    labelStyle: TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                                    border:InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                            ),
                            RaisedButton(
                              child: Text("Send Code"),
                              onPressed:(){}
                            ),
                        ],
                    ),
                ),
            ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20),
              child: Center(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AdminScreen()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}