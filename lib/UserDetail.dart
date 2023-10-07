import 'package:flutter/material.dart';
import 'models/MainUser.dart';

class UserDetail extends StatefulWidget {

 MainUser obj;
 UserDetail({required this.obj});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UserDetail"),),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text("Name : " + (widget.obj.name?.firstname ?? "") + " " + (widget.obj.name?.lastname ?? ""),
                            style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  Text("Add  : "+ widget.obj.address!.number.toString() + " , " +
                                  widget.obj.address!.street.toString() + " , " +
                                  widget.obj.address!.city.toString() + " , " +
                                  widget.obj.address!.zipcode.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                  ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 5),
                      Text("Email : " +widget.obj.email.toString()),
                      SizedBox(width: 20),
                      Icon(Icons.phone),
                      SizedBox(width: 5),
                      Text("Phone : " +widget.obj.phone.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Text("User  : " +widget.obj.username.toString()),
                      Text("Password : " +widget.obj.password.toString()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
