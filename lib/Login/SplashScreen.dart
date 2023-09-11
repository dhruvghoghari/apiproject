import 'package:apiproject/Login/HomePage.dart';
import 'package:apiproject/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  logindata() async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
      {
        Navigator.pop(context);
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage()));
      }
    else
      {
        Navigator.pop(context);
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginScreen())
        );
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds:2),(){
      setState(() {
        logindata();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           Expanded(child: Image.asset("img/Splash.png",fit: BoxFit.cover,)),
          ],
        ),
      ),
    );
  }
}
