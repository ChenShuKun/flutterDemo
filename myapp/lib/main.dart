import 'package:flutter/material.dart';
import 'package:myapp/home/home.dart';
// import 'package:myapp/study/data_table.dart';
// import 'package:myapp/study/study.dart';
// import 'package:myapp/study/Hero.dart';
import 'package:myapp/tools/tips.dart';

void main() {
  runApp(const MyApp());
  Tips.configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      builder: Tips.easyLoadingInit(),
      // home: const StudyClass(),
      home: const HomeDemo(),
    );
  }
}
