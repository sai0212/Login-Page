//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:loginpage/main.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("User Logged In"),
      new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
      CircleAvatar(
        backgroundImage: NetworkImage('http://www.fillmurray.com/300/300'),
        radius: 60.0,
      ),
      new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
      SignInButton(Buttons.Google, text: 'Sign Out', onPressed: () async {
        bool signOut =  await logout();
        if (signOut) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
      }),
    ])));
  }

  Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    return true;
  }
}

/*class ProfileScreen extends StatelessWidget {
  final  detailsUser;

  ProfileScreen({key, required this.detailsUser}) : super(key: key);

  @override

  Widget build(BuildContext context) {
        final GoogleSignIn _gSignIn = GoogleSignIn();


        return Scaffold(
          appBar: AppBar(
            title: Text(detailsUser.userName),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20.0,
                  color: Colors.white,

                ),
                onPressed: () {
                  _gSignIn.signOut();
                  print("Sign out");
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(detailsUser.photoURL),
                  radius: 50.0,
                ),
                SizedBox(height:10.0),
                Text(
                  "Name :" + detailsUser.userName,
                ),
                Text(
                  "Name :" + detailsUser.userEmail,
                ),
                
                
              ]
            )
          )
        );
  
 }
  }*/
