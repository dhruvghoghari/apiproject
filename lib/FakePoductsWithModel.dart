import 'dart:convert';
import 'package:apiproject/AboutScreen.dart';
import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FakePoductsWithModel extends StatefulWidget {

  @override
  State<FakePoductsWithModel> createState() => _FakePoductsWithModelState();
}
class _FakePoductsWithModelState extends State<FakePoductsWithModel> {


  List<Product>? alldata;

  getdata() async
  {
    Uri url= Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json.map<Product>((obj)=>Product.fromJson(obj)).toList();
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
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product With Model"),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator()):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
        {
          return ListTile(
            title: Text(alldata![index].title.toString()),
            subtitle: Text(alldata![index].rating!.rate.toString()),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>AboutScreen(
                  obj: alldata![index],
                ))
              );
            },
          );
        },
      ),
    );
  }
}
