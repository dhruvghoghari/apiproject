import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FakeUser extends StatefulWidget {
  const FakeUser({Key? key}) : super(key: key);

  @override
  State<FakeUser> createState() => _FakeUserState();
}

class _FakeUserState extends State<FakeUser> {

  Future<List>? alldata;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse("https://fakestoreapi.com/users");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        return json;
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
      setState(() {
        alldata=getalldata();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FakeUser"),),
      body: SafeArea(
        child: FutureBuilder(
          future: alldata,
          builder: (context,snapshots)
          {
            if(snapshots.hasData)
              {
                if(snapshots.data!.length<=0)
                  {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                else
                  {
                    return ListView.builder(
                      itemCount:snapshots.data!.length,
                      itemBuilder: (context,index)
                      {
                        return Container(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(snapshots.data![index]["name"]["firstname"].toString()+ " "+snapshots.data![index]["name"]["lastname"].toString()),
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
                                        Text(
                                              snapshots.data![index]["address"]["number"].toString() + ", " +
                                              snapshots.data![index]["address"]["street"].toString() + ", " +
                                              snapshots.data![index]["address"]["city"].toString() + ", " +
                                              snapshots.data![index]["address"]["zipcode"].toString(),
                                        )
                                      ],
                                    )
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
                                        Text(snapshots.data![index]["email"].toString()),
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
                                        Text(snapshots.data![index]["phone"].toString()),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("User Name : "+snapshots.data![index]["username"].toString()),
                                        Text("Password : "+snapshots.data![index]["password"].toString()),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  }
              }
            else
              {
                return Center(
                  child: Text("Waiting For Data..."),
                );
              }
          }
        ),
      ),
    );
  }
}
