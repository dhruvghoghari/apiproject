import 'dart:convert';
import 'package:apiproject/StudentModel/EditProducts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';
import 'Products.dart';

class ProductwithModel extends StatefulWidget {
  const ProductwithModel({Key? key}) : super(key: key);

  @override
  State<ProductwithModel> createState() => _ProductwithModelState();
}

class _ProductwithModelState extends State<ProductwithModel> {

  List<Products>? alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json["data"].map<Products>((obj) => Products.fromJson(obj)).toList();
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
      appBar: AppBar(title: Text("All Products"),),
        body: (alldata==null)?Center(child: Text("Waiting..."),):ListView.builder(
          itemCount: alldata!.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(alldata![index].pname.toString()),
                subtitle: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async{

                        var pid = alldata![index].pid.toString();
                       
                        Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/deleteProductNormal.php");
                        var params = {
                          "pid":pid
                        };
                        var response = await http.post(url,body: params);
                        if(response.statusCode==200)
                          {
                            var json = jsonDecode(response.body.toString());
                            if(json["status"]=="true")
                              {
                                var message = json["message"].toString();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                getdata();
                              }
                            else
                              {
                                var message = json["message"].toString();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                              }
                          }
                      },
                    ),  // delete
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async{

                        var pid = alldata![index].pid.toString();

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditProducts(
                             pid:pid,
                            ))
                        );

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => EditProducts(
                        //       obj: alldata![index],
                        //     ))
                        // );
                      },
                    ),  // Edit
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("₹." +alldata![index].price.toString()),
                      SizedBox(height:5.0),
                      Text(alldata![index].qty.toString()),
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
