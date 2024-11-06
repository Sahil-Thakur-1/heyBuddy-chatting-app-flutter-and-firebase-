import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heybuddy/constants.dart';
import 'package:heybuddy/widgets/home_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var name;
  var id;
  bool spinner = false;
  var email;
  var password;
  void newuser() {
     _firestore.collection("user").add({
      "status" : "null",
      "useremail" : email,
      "name" : name,
      "userid" : id
    });
  }
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
                    'Register',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    onChanged: (context) {
                      name = context;
                    },
                    decoration: kTextField.copyWith(hintText: "Enter Your name")),
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
                  text: "Register",
                  color: Colors.blue.shade900,
                  onPressed: () async{
                    setState(() {
                      spinner = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      final currentUser = _auth.currentUser;
                      if (currentUser != null) {
                        id = currentUser.uid;
                        currentUser.updateDisplayName(name);
                        newuser();
                        Navigator.pushNamed(context, 'profileScreen');
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
