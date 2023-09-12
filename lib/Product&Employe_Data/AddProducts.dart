import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _ProductsState();
}

class _ProductsState extends State<AddProducts> {


  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Products"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Name"),
                ],
              ),
              SizedBox(height: 5.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text("price"),
                ],
              ),
              SizedBox(height: 5.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text("quantity"),
                ],
              ),
              SizedBox(height: 5.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _quantity,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.0,),

              Container(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                  onPressed: ()  async{
                    
                    
                    var nm = _name.text.toString();
                    var qty= _quantity.text.toString();
                    var price = _price.text.toString();
                    
                    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/insertProductNormal.php");
                    var params= {
                      "pname":nm,
                      "qty":qty,
                      "price":price
                    };
                    var response = await http.post(url,body: params);
                    if(response.statusCode==200)
                      {
                        var json = jsonDecode(response.body.toString());
                        if(json["status"]=="true")
                          {
                            var message = json["message"].toString();
                            var snackbar = SnackBar(content: Text(message));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            _name.text="";
                            _quantity.text="";
                            _price.text="";
                          }
                        else
                          {
                            var message = json["message"].toString();
                            var snackbar = SnackBar(content: Text(message));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                      }
                    
                    
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text("ADD ➕",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
