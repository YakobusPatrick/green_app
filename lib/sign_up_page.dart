import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/sign_in_page.dart';
import 'package:green_app/splash.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordTC = TextEditingController();

  String _email;
  String _password;
  var list = ['porno', 'pornografi', 'sex', 'sexual', 'telanjang'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/sign_up.png', width: 150, height: 75),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }else if(value.length < 5){
                      return 'Email tidak boleh kurang dari lima karakter';
                    }else if(list.contains(value)){
                      return 'Email tidak boleh mengandung unsur pornografi';
                    }
                      return null;
                  },
                  onSaved: (newValue) {
                    _email = newValue;
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: passwordTC,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }else if(value.length < 5){
                      return 'Password tidak boleh kurang dari lima karakter';
                    }
                      return null;
                  },
                  onSaved: (newValue) {
                    _password = newValue;
                  }
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Konfirmasi password', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }else if(value.length < 5){
                      return 'Password tidak boleh kurang dari lima karakter';
                    }else if (passwordTC.text != value) {
                      return 'Password tidak sama';
                    }
                      return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: Text('Sign Up'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                      } catch (e) {
                        print(e);
                      }

                      print('Email: $_email     Password: $_password');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));
                    }
                  }
                )
              ),
              Row(
                children: [
                  Text('Sudah punya akun? '),
                  InkWell(
                    child: Text('Sign In'),
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
                    }
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }
}
