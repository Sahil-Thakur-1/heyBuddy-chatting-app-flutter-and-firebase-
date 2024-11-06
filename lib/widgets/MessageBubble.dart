import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.user,this.message,this.loggeduser});

  var user;
  var message;
  var loggeduser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: user==loggeduser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(user,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black54
            ),),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topLeft: loggeduser==user?Radius.circular(30):Radius.circular(0),
              topRight: loggeduser==user?Radius.circular(0):Radius.circular(30),

            ),
            color: loggeduser==user?Colors.lightBlueAccent:Colors.white54,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$message",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
