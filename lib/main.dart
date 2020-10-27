/*
//로그인 전 메인
import 'package:flutter/material.dart';
import 'package:category_list/page/category.dart';
import 'package:category_list/page/drugListPage.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ranking',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      //home: new HomePage(),
      home: new CategoryMenu(),
    );
  }
}

*/

//이메일로 로그인
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './login/register_page.dart';
import './login/signin_page.dart';
import './page/home.dart';

import './page/home_add_button_stack.dart';//add dan

import 'package:google_sign_in/google_sign_in.dart';


void main() async {
  // TODO(Salakar): Firebase should be initialized via a FutureBuilder or a StatefulWidget,
 // runApp(MyApp());
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
      '/': (context) => MyApp(),
      // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
      '/pressButtonNewPage': (context) => OverlayWithHole(),
      '/HomeDrug' : (context) => HomeDrugPage(),
    },
  ));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with Email',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),      home: MyHomePage(title: 'Login with Email'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.android),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeDrugPage()//
                  //CategoryMenu()
                ));

            //Navigator.pushNamed(context, '/HomeDrug');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text('회원가입', style: TextStyle(color: Colors.white),),
              color: Colors.teal[400],              onPressed: () => _pushPage(context, RegisterPage()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: const Text('이메일로 로그인', style: TextStyle(color: Colors.white),),
              color: Colors.teal[400],
              onPressed: () => _pushPage(context, SignInPage()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

/*
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
*/

}



