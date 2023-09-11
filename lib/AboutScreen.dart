import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
 Product obj;
 AboutScreen({required this.obj});
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                onPressed: (){
                    Navigator.pop(context);
                }
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.obj.title.toString(), style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
