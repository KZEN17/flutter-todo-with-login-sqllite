import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: ListView(children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/ic_launcher.png'),
                    fit: BoxFit.contain),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.purpleAccent,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 15.0),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.purpleAccent,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Text(
                          'Back',
                          style: TextStyle(
                              color: Colors.purpleAccent, fontSize: 15.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.purpleAccent,
                    ),
                    child: TextField(
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.purpleAccent,
                          ),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white54)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.purpleAccent,
                    ),
                    child: TextField(
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.purpleAccent,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white54)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.purpleAccent,
                    ),
                    child: TextField(
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.purpleAccent,
                          ),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.white54)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.purpleAccent,
                        primaryColorDark: Colors.purpleAccent),
                    child: TextField(
                      style:
                          TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.purpleAccent,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white54)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          activeColor: Colors.purpleAccent,
                          value: checkBoxValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          }),
                      Text(
                        'I agree with the Terms & Conditions',
                        style: TextStyle(color: Colors.white30),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40.0,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: RaisedButton(
              onPressed: () {},
              color: Colors.purpleAccent,
              child: Text("SIGN UP", style: TextStyle(color: Colors.white, ),),
            ),
          ),
          SizedBox(height: 15.0,),
          Center(
            child: Text(
              "Powered by KZEN",
              style: TextStyle(color: Colors.white30),
              textAlign: TextAlign.center,
            ),
          )
        ]));
  }
}
