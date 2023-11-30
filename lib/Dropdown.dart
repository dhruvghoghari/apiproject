import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:apiproject/AboutScreen.dart';
import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dropdown extends StatefulWidget {
  @override
  State<Dropdown> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dropdown> {
  List<Product>? alldata;

  var selected="";

  getdata() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json.map<Product>((obj) => Product.fromJson(obj)).toList();
        selected = alldata!.first!.id.toString();
      });
    } else {
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
      appBar: AppBar(title: Text("Dropdown")),
      body: (alldata == null) ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          children: [
            Text("Footer"),
            Container(
              child: DropdownButton(
                value: selected,
                onChanged: (val){
                  setState(() {
                    selected=val!;
                  });
                },
                items: alldata!.map((obj){
                  return DropdownMenuItem(
                    child:Text(obj.title.toString()),
                    value: obj.id.toString(),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(onPressed: (){
              print("Selected : "+selected);
            }, child: Text("Click")),
            Container(
              child: Column(
                children: alldata!.map((obj){
                  return Container(
                    child: Text(obj.title.toString()),
                  );
                }).toList(),
              ),
            ),
            Text("Footer")
          ],
        ),
      )
          // : ListView.builder(
          //     itemCount: alldata!.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(alldata![index].title.toString()),
          //         subtitle: Text(alldata![index].rating!.rate.toString()),
          //         onTap: () {
          //           Navigator.of(context).push(MaterialPageRoute(
          //               builder: (context) => AboutScreen(
          //                     obj: alldata![index],
          //                   )));
          //         },
          //       );
          //     },
          //   ),
    );
  }
}
