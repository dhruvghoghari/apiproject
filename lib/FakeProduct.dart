import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:apiproject/AboutScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FakeProduct extends StatefulWidget {

  @override
  State<FakeProduct> createState() => _FakeProductState();
}
class _FakeProductState extends State<FakeProduct> {


  Future<List>? alldata;

  Future<List> getdata() async
  {
    //200 OK
    //400 Not Found
    //500 server
    Uri url= Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        return json;
      }
    else
      {
        return [];
      }

    // var params= {
    //   "pname":"ABC"
    // };

    // Dio dio = new Dio();                                                    // Dio Method PostApi Calling
    // dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers['token'] = '';
    // var response = await dio.post("https://fakestoreapi.com/products",data: params);

    //
    // var response = await Dio().get("https://fakestoreapi.com/products");      // Dio Method GetApi Calling
    // if(response.statusCode==200)
    //   {
    //     var json = response.data;
    //     return json;
    //   }
    // else
    //   {
    //     return [];
    //   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FakeProduct"),),
      body: FutureBuilder(
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
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context,index)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async{

                            var id = snapshots.data![index]["id"].toString();
                            var imgg = snapshots.data![index]["image"].toString();
                            var titl = snapshots.data![index]["title"].toString();
                            var pr = snapshots.data![index]["price"].toString();
                            var cagry = snapshots.data![index]["category"].toString();
                            var rt = snapshots.data![index]["rating"]["rate"].toString();
                            var despn = snapshots.data![index]["description"].toString();

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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(snapshots.data![index]["image"].toString(),
                                    width: 150.0,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshots.data![index]["title"].toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text("Rs. " + snapshots.data![index]["price"].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshots.data![index]["category"].toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(snapshots.data![index]["rating"]["rate"].toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.favorite_border),
                                                  onPressed: (){},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
