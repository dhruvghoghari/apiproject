import 'dart:convert';
import 'dart:io';
import 'package:apiproject/Login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreatAccount extends StatefulWidget {
  const CreatAccount({Key? key}) : super(key: key);

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 100.0),
                    Text("Creat Account",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: " Name",
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
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: " Email",
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
                    controller: _cpassword,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                  onPressed: () async{

                    var nm = _name.text.toString();
                    var em = _email.text.toString();
                    var pass = _password.text.toString();
                    var cpass = _cpassword.text.toString();


                    if(nm.length<=0)
                      {
                        var snackbar = SnackBar(
                          content: Text("Enter Name"),
                          duration: Duration(seconds:3),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(textColor:Colors.white,label: "Close",onPressed: (){}),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    else if(em.length<=0)
                    {
                      var snackbar = SnackBar(
                        content: Text("Enter Email"),
                        duration: Duration(seconds:3),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(textColor:Colors.white,label: "Close",onPressed: (){}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else if(pass.length<=0)
                    {
                      var snackbar = SnackBar(
                        content: Text("Enter Password"),
                        duration: Duration(seconds:3),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(textColor:Colors.white,label: "Close",onPressed: (){}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else if(cpass.length<=0)
                    {
                      var snackbar = SnackBar(
                        content: Text("Enter Confirm Password"),
                        duration: Duration(seconds:3),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(textColor:Colors.white,label: "Close",onPressed: (){}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else if (pass != cpass)
                    {
                      var snackbar = SnackBar(
                        content: Text("Password and Confirm Password Do Not Match"),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                        elevation: 5.0,
                        action: SnackBarAction(textColor: Colors.white, label: "Close",
                          onPressed: () {
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else
                    {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("PassLogin", "Yes");
                      prefs.setString("cpass", cpass);

                      //API
                      String os = Platform.operatingSystem;

                      Uri url = Uri.parse("https://begratefulapp.ca/api/register");
                      var params = {
                        "name": nm,
                        "email":em,
                        "password":pass,
                        "confirm_password":cpass,
                        "device_token":prefs.getString("token"),
                        "device_os":os,
                        "version_type":"openness",
                        "group":"2",
                        "version":"1",
                        "time_zone":"IST",
                        "ip_address": "103.232.125.6"
                      };

                      var headers = {
                        "Content-Type":"application/json"
                    };

                      var response = await http.post(url ,body: jsonEncode(params),headers:headers );

                    if (response.statusCode == 200)
                    {
                    var json = jsonDecode(response.body.toString());
                    if (json["result"] == "success") {

                    var message = json["message"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(message, style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,)
                    );}

                    else
                    {
                    var message = json["message"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(message,style: TextStyle(color: Colors.white),), backgroundColor: Colors.red,));
                    }
                    }
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen())
                    );

                      }
                    },
                  child: Text("register", style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
