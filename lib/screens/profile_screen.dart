import 'dart:convert';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heybuddy/constants.dart';
import 'package:heybuddy/screens/chat_screen.dart';
import 'package:crypto/crypto.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
   Map<String,dynamic>? map1 ;
   bool loading = false;
   var condition;
   String chatid(var userId1,var userId2){
     // Sort the user IDs to ensure consistent order
     List<String> sortedIds = [userId1, userId2]..sort();
     String concatenatedIds = sortedIds[0] + "_" + sortedIds[1];

     // Generate a hash of the concatenated IDs using SHA-256
     var bytes = utf8.encode(concatenatedIds);
     var digest = sha256.convert(bytes);

     return digest.toString();
   }
  void searchdata()async{
    setState(() {
      loading = true;
    });
    try {
      await _firestore.collection('user').where(
          'useremail', isEqualTo: identered).get().then((value) {
        setState(() {
          map1 = value.docs[0].data();
          loading = false;
        });
      });
      print(map1);
    }
    catch(e){
      setState(() {
        condition = "user not found";
        loading = false;
      });
    }
  }
  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Material(
      child: Container(
        child: Column(

        ),
      ),
    );
  }
  final controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  var identered;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Heybuddy",
        style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pushNamed(context, 'loginScreen');
          },
              icon: Icon(Icons.logout,color: Colors.white,))
        ],
        centerTitle: true,
      ),
      body: loading ? const Center(
          child: CircularProgressIndicator(
            color: Colors.lightBlueAccent,
          )
      ) : Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
          TextField(
            controller: controller,
              onChanged: (value){
              identered = value;
    },
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide().copyWith(color: Colors.grey)))),
        TextButton(onPressed: (){
          searchdata();
          controller.clear();
        },
        child: const Text("Search",
        style: kSendButtonTextStyle,
        ),
            ),
             map1!=null?
             ListTile(
               onTap: (){
               },
               leading: Icon(Icons.account_box,size: 30,),
               title: Text(map1?['name']),
               subtitle: Text(map1?['useremail']),
               trailing: IconButton(
                   onPressed:(){
                     var groupid = chatid(_auth.currentUser!.uid, map1?['userid']);
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>ChatScreen(chatid: groupid,user: map1,)));
                   },
                   icon: Icon(Icons.chat),
                   ),
             ):Container(
               child: condition!=null? Text(condition):null,
             )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          showFlexibleBottomSheet(
            minHeight: 0,
            initHeight: 0.5,
            maxHeight: 1,
            context: context,
            builder: _buildBottomSheet,
            anchors: [0, 0.5, 1],
            isSafeArea: true,
          );
        },
      ),
    );
  }
}
