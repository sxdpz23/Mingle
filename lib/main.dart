import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:citoto/screens/mingle.dart';
import 'package:citoto/screens/login.dart';
import 'package:citoto/widgets/read-write-file.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:citoto/widgets/chats.dart';
// import 'package:citoto/screens/tests.dart';

Future<void> main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScopedModel(
      model: ChatModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final Storage _storage = Storage();
  String _value = '';

  @override
  Widget build(BuildContext context) {
    _storage.readFile().then((String value) {
      setState(() {
        _value = value;
      });
    });
    return Scaffold(
      body: (_value == '' || _value == null)
          ? Login()
          : Mingle(
              citID: _value,
            ),
    );
  }
}
