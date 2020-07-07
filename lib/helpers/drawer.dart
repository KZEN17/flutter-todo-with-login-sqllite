import 'package:flutter/material.dart';
import 'package:todoflutter/screens/categories.dart';
import 'package:todoflutter/screens/home.dart';

class DrawerNav extends StatefulWidget {
  @override
  _DrawerNavState createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, color: Colors.black,),
                backgroundColor: Colors.grey,
              ),
              accountName: Text('Zlatko'),
              accountEmail: Text('zack.kargeen@gmail.com'),
              decoration: BoxDecoration(color: Colors.orange),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
