import 'package:flutter/material.dart';
import 'package:todoflutter/screens/signUp.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/ic_launcher.png'),
                      fit: BoxFit.contain),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    style:
                    TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.white60,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.purpleAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.purpleAccent)),
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white54)),
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
                  child: TextField(
                    style:
                    TextStyle(color: Colors.purpleAccent, fontSize: 15.0),
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.white60,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.purpleAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.purpleAccent)),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white54)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.purpleAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 5.0, fontSize: 15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUp()));
              },
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.white30),
                    children: [
                      TextSpan(text: ' SIGN UP', style: TextStyle(color: Colors.white))
                    ]
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120.0,
          ),
          Center(
            child: Text(
              "Designed and developed by KZEN",
              style: TextStyle(color: Colors.white30),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}