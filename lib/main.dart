import 'package:flutter/material.dart';
import 'package:flutter_sample_app/screens/user_name_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(primaryColor: Colors.white),
        home: UserNameScreen());
  }
}
