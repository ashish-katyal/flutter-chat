import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages(this.receiverId);
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final user = FirebaseAuth.instance.currentUser;
        final chatDocs = chatSnapshot.data!.docs
            .where((element) =>
                (element['userId'] == user!.uid &&
                    element['receiverId'] == receiverId) ||
                (element['userId'] == receiverId &&
                    element['receiverId'] == user.uid))
            .toList();

        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                chatDocs[index]['text'],
                user!.uid == chatDocs[index]['userId'],
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                key: ValueKey(chatDocs[index].id),
              );
            });
      },
    );
  }
}
