import 'package:apiproject/Dropdown.dart';
import 'package:apiproject/FakeUser.dart';
import 'package:apiproject/Product&Employe_Data/AddEmploye.dart';
import 'package:apiproject/Product&Employe_Data/AddProducts.dart';
import 'package:flutter/material.dart';
import 'FakePoductsWithModel.dart';
import 'FakeProduct.dart';
import 'FakestorewithUser.dart';
import 'Login/LoginScreen.dart';
import 'StudentModel/Employe.dart';
import 'StudentModel/EmployWithModel.dart';
import 'StudentModel/Products.dart';
import 'StudentModel/ProductwithModel.dart';

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
        title: Center(child: Text("HomeScreen")),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Fake Product"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FakeProduct()));
              },
            ),
            ListTile(
              title: Text("Fake User"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FakeUser()));
              },
            ),
            ListTile(
              title: Text("Fake Product With Model"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FakePoductsWithModel()));
              },
            ),
            ListTile(
              title: Text("Fake Store With User"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FakestorewithUser()));
              },
            ),
            ListTile(
              title: Text("Product with Model"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductwithModel()));
              },
            ),
            ListTile(
              title: Text("Employ With Model"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EmployWithModel()));
              },
            ),
            ListTile(
              title: Text("Login"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              title: Text("Drop Down"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Dropdown()),
                );
              },
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Products"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProducts()),
                );
              },
            ),
            ListTile(
              title: Text("Employes"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEmploy()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
