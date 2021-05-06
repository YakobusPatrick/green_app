import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/sign_up_page.dart';
import 'package:green_app/splash.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

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
              Image.asset('assets/sign_in.png', width: 175, height: 175),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email tidak boleh kosong';
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
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                      return null;
                  },
                  onSaved: (newValue) {
                    _password = newValue;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    if( _formKey.currentState.validate()){
                      _formKey.currentState.save();
                      print('Email: $_email     Password: $_password');
                      try{
                        FirebaseAuth.instance.signInWithEmailAndPassword(email:_email, password: _password );
                      }catch(e){
                        print(e);
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));   
                    }
                  }
                )
              ),
              Row(
                children: [
                  Text('Belum punya akun? '),
                  InkWell(child: Text('Sign Up'),onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => SignUpPage()));
                  })
                ]
              )
            ]
          )
        )
      )
    );
  }
}
