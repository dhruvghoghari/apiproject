import 'dart:convert';
import 'package:apiproject/StudentModel/ProductwithModel.dart';
import 'package:flutter/material.dart';
import 'Products.dart';
import 'package:http/http.dart' as http;

class EditProducts extends StatefulWidget {
 //Products obj;
 //EditProducts({required this.obj});
  
  var pid="";
  EditProducts({required this.pid});

  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {

  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  var isloading=false;



  getdata() async
  {
    setState(() {
      isloading=true;
    });
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getSingleProduct.php");
    var params = {
      "pid":widget.pid
    };

    var response = await http.post(url,body: params);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());


        Products obj = Products.fromJson(json["data"]);

        _name.text = obj.pname.toString();
        _price.text = obj.price.toString();
        _quantity.text = obj.qty.toString();
        // _name.text = json["data"]["pname"].toString();
        // _price.text = json["data"]["qty"].toString();
        // _quantity.text = json["data"]["price"].toString();
        setState(() {
          isloading=false;
        });
      }
    
    
    
    // _name.text = widget.obj.pname.toString();
    // _price.text = widget.obj.price.toString();
    // _quantity.text = widget.obj.qty.toString();
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
      appBar: AppBar(title: Text('EditProducts'),),
      body: (isloading)?Center(child: CircularProgressIndicator(),):Column(
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

                Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/updateProductNormal.php");
                var params= {
                  "pname":nm,
                  "qty":qty,
                  "price":price,
                  "pid":widget.pid.toString()
                };
                var response = await http.post(url,body: params);
                if(response.statusCode==200)
                {
                  var json = jsonDecode(response.body.toString());
                  if(json["status"]=="true")
                  {
                    Navigator.of(context).pop(); //edit
                    Navigator.of(context).pop(); //view
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>ProductwithModel())
                    ); //view
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
              child: Text("UPDATE ",style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
