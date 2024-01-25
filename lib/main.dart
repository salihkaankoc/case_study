import 'package:case_study/view/home.dart';
import 'package:case_study/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

var userToken;



class _MyAppState extends State<MyApp> {
  controlUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    userToken = prefs.getString('token');
  });
}

@override
  void initState() {
    // TODO: implement initState
    controlUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Case',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/login":(context) => const LoginScreen(),
        "/home":(context) =>  HomeScreen(),
      },
      home: userToken == null ? const LoginScreen() :  HomeScreen(),
    );
  }
}
