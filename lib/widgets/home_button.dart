import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeButton extends StatelessWidget {
  homeButton({this.color,this.text,this.onPressed});
  var color;
  var text;
  var onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
          )
        ]
      ),
      margin: const EdgeInsets.all(10),
      child: TextButton(
        child: Text(text,
        style: const TextStyle(
            fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        onPressed: onPressed,
        style: ButtonStyle(
          shadowColor: MaterialStateColor.resolveWith((states) => Colors.grey),
          backgroundColor: MaterialStateColor.resolveWith((states) => color),
        ),),
    );
  }
}
