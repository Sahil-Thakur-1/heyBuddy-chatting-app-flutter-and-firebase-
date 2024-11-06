import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heybuddy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heybuddy/widgets/MessageBubble.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.chatid,this.user});
  var chatid;
  var user;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
final ScrollController controller = ScrollController();

void _scrollDown() {
  controller.animateTo(
    controller.position.maxScrollExtent,
    duration: Duration(seconds: 1),
    curve: Curves.fastOutSlowIn
  );
}

class _ChatScreenState extends State<ChatScreen> {
  var person;
  final messageTextcontroller = TextEditingController();
  final _cloud = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var loggeduser;
  String? message;
  void getuser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggeduser = user;
    }
  }

  // void getMessage() async{
  //   var messages = await _cloud.collection('message').get();
  //   for(var message in messages.docs)
  //     print(message.data());
  // }
  //
  // void getMessage()async{
  //   await for (var snapshot in  _cloud.collection('message').snapshots())
  //   for (var message in snapshot.docs){
  //     print (message.data());
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, "loginScreen");
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close,color: Colors.white,),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, "loginScreen");
                //Implement logout functionality
              }),
        ],
        title: Text(widget.user['name'],style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _cloud.collection('ChatRoom').doc('${widget.chatid}').collection("chats").orderBy("time",descending: false).snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                    final messages = snapshot.data?.docs;
                    List<MessageBubble> MessagesWidget = [];
                    for ( var message in messages!){
                      final messageText = message['text'];
                      final messageUser = message['user'];
                      final messagesWidget = MessageBubble(user: messageUser, message: messageText,loggeduser: loggeduser.email,);
                      MessagesWidget.add(messagesWidget);
                    }
                    return Expanded(
                      child: ListView(
                        controller: controller,
                        children: MessagesWidget,
                      ),
                    );
                }
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextcontroller,
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      messageTextcontroller.clear();
                     await _cloud.collection('ChatRoom').doc('${widget.chatid}').collection("chats")..add({
                        'text' : message,
                        'user' : loggeduser.email,
                        'time' : FieldValue.serverTimestamp(),
                      });
                      _scrollDown();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


