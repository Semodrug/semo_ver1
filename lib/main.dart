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

import './page/home_add_button_stack.dart'; //add dan

import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  // TODO(Salakar): Firebase should be initialized via a FutureBuilder or a StatefulWidget,

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  /*
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '내 약이 궁금할 땐',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),      home: MyHomePage(title: '이약모약'),
    );
  }
*/
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IYMY',
        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        home: MyHomePage(),
        initialRoute: '/signIn', //############CONNECT
        routes: {
          '/signIn': (context) => SignInPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.teal[100],
                  //Colors.teal[50],
                  Colors.teal[200]
                ])),
          ), //grada
        ),
        body: Container(
          height: 700,
          width: double.infinity,
          child: FlatButton(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "내 약이 궁금할 땐",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "이약모약",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/signIn');
            },
          ),

          /*
          Center(
//            child:
//              Container(
//                child: Padding(
//                  padding: EdgeInsets.all(20),
                  child: Container(
                    height: 500,
                    width: double.infinity,
                    child: FlatButton(
                      child: Column(
                       children: <Widget>[
                          Center(
                            child:
                            Text("이약모약", textAlign: TextAlign.center,
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),),
                         // ),
                        ],
                      ),
                      onPressed: () { Navigator.pushNamed(context, '/signIn');},

                    ),
                  ),
*/
//                ),
//              )
        ));
  }
}

/*
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

*/
