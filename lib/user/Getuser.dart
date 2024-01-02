import 'dart:convert';
import 'package:apiproject/models/currentuser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GetUser extends StatefulWidget {

  @override
  State<GetUser> createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {

  List<currentUser>? allData;

   getUser() async
  {
    Uri url = Uri.parse("https://dummyjson.com/carts");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        allData = json["products"].map<currentUser>((obj) => currentUser.fromJson(obj)).toList();
      });

    }
    else
    {
      return [];
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        shrinkWrap: true,
        itemCount: allData!.length,
        itemBuilder: (context,index)
        {
          return Container(
            child: Column(
              children: [
                Text(allData![index].title.toString()),
                Image.network(allData![index].thumbnail.toString()),
                Text(allData![index].price.toString()),
                Text(allData![index].quantity.toString()),
                Text(allData![index].discountPercentage.toString()),
                Text(allData![index].id.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
