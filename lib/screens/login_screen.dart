import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heybuddy/constants.dart';
import 'package:heybuddy/widgets/home_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/heybuddy.png"))),
                  ),
                ),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                    onChanged: (context) {
                      email = context;
                    },
                    decoration: kTextField.copyWith(hintText: "Enter Your Email")),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (context) {
                      password = context;
                    },
                    decoration:
                        kTextField.copyWith(hintText: "Enter Your Password")),
                SizedBox(
                  height: 20,
                ),
                homeButton(
                  text: "Log in",
                  color: Colors.blueAccent,
                  onPressed: () async{
                    setState(() {
                      spinner = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (await _auth.currentUser != null) {
                        Navigator.pushNamed(context, "profileScreen");
                      }
                      setState(() {
                        spinner = false;
                      });
                    }
                    catch(e){
                      setState(() {
                        spinner = false;
                      });
                      Fluttertoast.showToast(msg: "$e");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
