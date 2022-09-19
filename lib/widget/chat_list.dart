import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/info.dart';
import 'package:whatsapp_clone/widget/my_message_card.dart';
import 'package:whatsapp_clone/widget/sender_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    Key? key,
    required this.name,
    required this.profilePic,
  }) : super(key: key);
  final String name;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarColor,
        title: Text(name),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(profilePic),
          ),
        ),
        actions: [
          _actionIconButton(icon: Icons.video_camera_front),
          _actionIconButton(icon: Icons.call),
          _actionIconButton(icon: Icons.more_vert_outlined),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          if (messages[index]['isMe'] == true) {
            return MyMessageCard(
              message: messages[index]['text'].toString(),
              date: messages[index]['time'].toString(),
            );
          }
          return SenderMessageCard(
            message: messages[index]['text'].toString(),
            date: messages[index]['time'].toString(),
          );
        },
      ),
    );
  }

  Widget _actionIconButton({required IconData icon, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey),
      onPressed: onPressed,
    );
  }
}
