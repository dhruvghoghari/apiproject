import 'package:flutter/material.dart';

import 'FakeProduct.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Fake Product"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FakeProduct())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

