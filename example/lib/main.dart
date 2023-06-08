import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paulonia_remote_conf/constants.dart';
import 'package:paulonia_remote_conf/paulonia_remote_conf.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PauloniaRemoteConf.init({
    "Test": 5,
    "Test 2": "Test"
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is a test value: ' + PauloniaRemoteConf.get("Test", PRCType.INT).toString(),
            ),
            Text(
              "This is other test: " + PauloniaRemoteConf.get("Test 2", PRCType.STRING).toString(),
            ),
            Text(
              'This is an other test value: ' + PauloniaRemoteConf.getValue("Test").asString(),
            ),
          ],
        ),
      ),
    );
  }
}
