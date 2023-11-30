import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FirstScreen"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SecondScreen()));
            },
            child: Text("Second Screen 👉"),
          ),
        ],
      ),
    );
  }
}
