import 'package:flutter/material.dart';
import 'package:heybuddy/screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registeration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDd6GAjzKTL-nqaRZA25jarQKMPcawIaew",
      appId: "1:649563370182:android:198403c2da6bc190009dc7",
      messagingSenderId: "649563370182",
      projectId: "heybuddy-4b1c6",
    ),
  );
  runApp(const HeyBuddy());
}

class HeyBuddy extends StatelessWidget {
  const HeyBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'homeScreen',
      routes: {
        'homeScreen' : (context) => HomeScreen(),
        'loginScreen' : (context) => LoginScreen(),
        "chatScreen" : (context) => ChatScreen(),
        'registerationScreen' : (context) => RegisterationScreen(),
        'profileScreen' : (context) => ProfileScreen()
      },
    );
  }
}
