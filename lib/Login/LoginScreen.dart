import 'dart:convert';
import 'dart:io';
import 'package:apiproject/Login/CreatAccount.dart';
import 'package:apiproject/Login/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "User Name",
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _password,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.lock_open_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {

                var username = _name.text.toString();
                var password = _password.text.toString();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String os = Platform.operatingSystem;

                Uri url = Uri.parse("https://begratefulapp.ca/api/login");
                var params = {
                  "name": username,
                  "password": password,
                  "device_token": prefs.getString("token"),
                  "device_os": os
                };

                var headers = {
                  "Content-Type": "application/json"
                };

                var response = await http.post(url, body: jsonEncode(params), headers: headers);

                if (response.statusCode == 200)
                {
                  var json = jsonDecode(response.body.toString());
                  if (json["result"] == "success") {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("islogin", "yes");


                    var id = json["data"]["id"].toString();
                    var name = json["data"]["name"].toString();
                    var email = json["data"]["email"].toString();
                    var token = json["data"]["user_session_token"].toString();


                    prefs.setString("id", id);
                    prefs.setString("name", name);
                    prefs.setString("email", email);
                    prefs.setString("user_session_token", token);



                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage())
                    );

                    var message = json["message"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message, style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,)
                    );
                  }
                  else
                  {
                    var message = json["message"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message, style: TextStyle(color: Colors.white),), backgroundColor: Colors.red,)
                    );
                  }
                }
              },
              child: Text("Login", style: TextStyle(fontSize: 20.0),
              ),
            ),
            
            SizedBox(height: 10.0),
            Text("OR",style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 90.0),
                Text("Don't Have Account?",style: TextStyle(
                    fontSize: 15.0,
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreatAccount())
                    );
                  },
                  child: Text("Create Account",style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
