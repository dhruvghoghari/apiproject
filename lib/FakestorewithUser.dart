import 'dart:convert';
import 'package:apiproject/UserDetail.dart';
import 'package:apiproject/models/MainUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FakestorewithUser extends StatefulWidget {
  const FakestorewithUser({Key? key}) : super(key: key);

  @override
  State<FakestorewithUser> createState() => _FakestorewithUserState();
}

class _FakestorewithUserState extends State<FakestorewithUser> {

  List<MainUser>? alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://fakestoreapi.com/users");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json.map<MainUser>((obj)=>MainUser.fromJson(obj)).toList();
      });
    }
    else
      {
        return[];
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FakestorewithUser"),),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
          {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserDetail(
                    obj: alldata![index]
                  ))
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Center(
                    //   child: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage: AssetImage("img/logo.webp"),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(alldata![index].name!.firstname.toString() +" "+alldata![index].name!.lastname.toString()),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.location_pin, color: Colors.white),
                              ),
                              SizedBox(width: 5.0),
                              Column(
                                children: [
                                  Text(alldata![index].address!.number.toString() + " , "+
                                      alldata![index].address!.street.toString()  + " , "+
                                      alldata![index].address!.city.toString()    + " , "+
                                      alldata![index].address!.zipcode.toString()
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.email_outlined, color: Colors.white),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(alldata![index].email.toString()),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.phone_android, color: Colors.white),
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(alldata![index].phone.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(alldata![index].username.toString()),
                                  Text(alldata![index].password.toString()),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
