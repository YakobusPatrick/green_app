import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));
            }
          )
        ]
      ),
      body: Container(
        child:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child:
              Text(
                'Selamat datang di aplikasi Green App',
                style: TextStyle(fontSize: 25)
              )
          )
      )
    );
  }
}
