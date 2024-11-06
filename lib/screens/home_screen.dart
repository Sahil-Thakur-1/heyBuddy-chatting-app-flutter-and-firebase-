import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heybuddy/widgets/home_button.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                            image: AssetImage("images/heybuddy.png")
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText(
                      "Hey Buddy",
                      textStyle: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      ),
                      speed: Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 5,
                  stopPauseOnTap: true,
                  displayFullTextOnTap: true,)

                ],
              ),
              homeButton(color: Colors.blue, text: "Login page",onPressed: (){
                Navigator.pushNamed(context, "loginScreen");
              },),
              SizedBox(
               height: 10,
              ),
              homeButton(color: Colors.blue.shade900,text: "Register page",onPressed: (){
                Navigator.pushNamed(context, "registerationScreen");
              },)
            ],
          ),
        ),
      ),
    );
  }
}
