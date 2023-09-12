import 'dart:convert';
import 'package:apiproject/models/Social.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SocialCommunity extends StatefulWidget {
  const SocialCommunity({Key? key}) : super(key: key);

  @override
  State<SocialCommunity> createState() => _SocialCommunityState();
}

class _SocialCommunityState extends State<SocialCommunity> {

  List<Social>? alldata;
  
  
  getdata() async
  {
    Uri url = Uri.parse("https://begratefulapp.ca/api/social-community");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "user_id": prefs.getString("id").toString(),
      "page": "1"
    };
    var header = {
      "user_session_token":prefs.getString("user_session_token").toString(),
      "Content-Type":"application/json"
    };
    var response = await http.post(url,body: jsonEncode(params),headers: header);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        if(json["result"]=="success")
          {
            setState(() {
              alldata = json["data"].map<Social>((obj)=>Social.fromJson(obj)).toList();
            });
          }
        else
          {
            var message = json["message"].toString();
            print(message);
          }
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
        title: Text("Social Community"),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
        {
          DateTime dateTime = DateTime.parse(alldata![index].date.toString()); // Date Format
          var formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

          String colorString = alldata![index].color.toString(); // color format
          Color cardColor = Color(int.parse(colorString.replaceAll("#", "0xff")));

          return Card(
            color: cardColor,
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(alldata![index].categoryImage.toString(),
                    width: 150.0,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(alldata![index].userName.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                            SizedBox(height: 10.0),
                            Text(formattedDate,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14.0,
                            ),),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(alldata![index].gratitude.toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),)
                          ],
                        ),
                       SizedBox(height: 10.0),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(alldata![index].totalLike.toString(),
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border,color: Colors.red),
                              onPressed: (){},
                            ),
                            Text(alldata![index].totalComments.toString(),
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_comment_sharp,color: Colors.green),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
