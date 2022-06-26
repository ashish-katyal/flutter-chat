import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';
import 'package:flutter_chat/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(this.receiverId, this.username);
  final String receiverId;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Messages(receiverId),
          ),
          NewMessage(receiverId),
        ],
      )),
    );
  }
}
