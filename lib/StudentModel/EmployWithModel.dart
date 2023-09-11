import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Employe.dart';

class EmployWithModel extends StatefulWidget {
  const EmployWithModel({Key? key}) : super(key: key);

  @override
  State<EmployWithModel> createState() => _EmployWithModelState();
}

class _EmployWithModelState extends State<EmployWithModel> {

  List<Employe>? alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);

        setState(() {
          alldata = json["data"].map<Employe>((obj) => Employe.fromJson(obj)).toList();
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
      appBar: AppBar(title: Text("Employes Details "),),
      body: (alldata==null?Center(child: CircularProgressIndicator()):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
          {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(alldata![index].ename.toString()),
                        Text("₹." +alldata![index].salary.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text(alldata![index].department.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text(alldata![index].gender.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{

                            var eid = alldata![index].eid.toString();
                            
                            Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/deleteEmployeeNormal.php");
                            var parms = {
                              "eid":eid
                            };
                            var response = await http.post(url,body: parms);
                            if(response.statusCode==200)
                              {
                                var json = jsonDecode(response.body.toString());
                                if(json["status"]=="true")
                                  {
                                    var message = json["message"].toString();
                                    var snackbar = SnackBar(content: Text(message),);
                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    getdata();
                                  }
                                else
                                  {
                                    var message = json["message"].toString();
                                    var snackbar = SnackBar(content: Text(message),);
                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  }
                              }

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: (){


                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      )
      )
    );
  }
}
