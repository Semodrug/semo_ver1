import 'package:flutter/material.dart';
import 'package:category_list/model_when_there_was_no_data/id_login.dart';

////////로그인 with 아이디/////////////

void main() async {
  // TODO(Salakar): Firebase should be initialized via a FutureBuilder or a StatefulWidget,
  // this is a quick & dirty way to initialize it with the least amount of code changes,
  // to minimise code conflicts when Auth rework lands.
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return MaterialApp( title: 'Shrine',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute, );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null; }
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true, );
  } }


class LoginPage extends StatefulWidget {
  @override _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[ SizedBox(height: 80.0),
            Column( children: <Widget>[
              Image.asset('assets/diamond.png'),
              SizedBox(height: 16.0), Text('SHRINE'), ],
            ),
            SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true, labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true, labelText: 'Password',
              ),
              obscureText: true, ),
            ButtonBar( children: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () { _usernameController.clear(); _passwordController.clear(); },
              ),
              RaisedButton(
                child: Text('NEXT'),
                onPressed: () { Navigator.pop(context); },
              ),
            ],),
          ],
        ),
      ),
    );
  }
}



///////////로그인 아이디 //////////////




class HomePage extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Text('You did it!'), ),
      resizeToAvoidBottomInset: false, ); }
}

