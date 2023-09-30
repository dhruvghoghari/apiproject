import 'package:apiproject/FakeUser.dart';
import 'package:apiproject/Login/LoginScreen.dart';
import 'package:apiproject/Login/SocialCommunity.dart';
import 'package:apiproject/Login/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FakeProduct.dart';
import 'HomeScreen.dart';
import 'UserDetail.dart';

void main()  async{
  runApp(const MyApp());
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString("token","12345678");

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
