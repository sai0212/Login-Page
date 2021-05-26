
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'home.dart';
import 'package:loginpage/home.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
   //Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.green));
  }
}

class LoginPage extends StatefulWidget {
  //final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 200));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);

    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: new AssetImage("assets/bgimage.jpg"),
          fit: BoxFit.cover,
          color: Colors.black38,
          colorBlendMode: BlendMode.darken,
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlutterLogo(
              size: _iconAnimation.value * 100,
            ),
            new Form(
                child: new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.yellow,
                  inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ))),
              child: new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0)),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.yellow.shade800),
                        labelText: "Email Address",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0)),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.yellow.shade800),
                        labelText: "Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
                    new MaterialButton(
                      height: 40.0,
                      minWidth: 200.0,
                      color: Colors.black87,
                      textColor: Colors.white,
                      child: new Text("Login"),
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen())),
                      splashColor: Colors.red,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                    ),
                    /*new MaterialButton(
                      height: 40.0,
                      minWidth: 200.0,
                      color: Colors.red.shade800,
                      textColor: Colors.white,
                      child: new Text("Sign In With Google"),
                      onPressed: signInWithGoogle,
                      splashColor: Colors.red,
                    )*/
                    SignInButton(
                      Buttons.Google,
                      onPressed: signInWithGoogle,
                    ),

                    /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())),*/
                  ],
                ),
              ),
            ))
          ],
        )
      ]),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    // ignore: unused_local_variable
    //final User? user =
        //(await FirebaseAuth.instance.signInWithCredential(credential)).user;

    //print(user);

    return await FirebaseAuth.instance.signInWithCredential(credential);

    //final User details =
       // new (user!.displayName, user.photoURL, user.email);

    /*Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ProfileScreen(detailsUser: details),
        ));*/
    //return user;
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
