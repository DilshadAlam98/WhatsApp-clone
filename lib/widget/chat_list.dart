import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/info.dart';
import 'package:whatsapp_clone/widget/my_message_card.dart';
import 'package:whatsapp_clone/widget/sender_message.dart';

class ChatList extends StatelessWidget {
  ChatList({
    Key? key,
    this.name,
    this.profilePic,
    this.webView,
  }) : super(key: key);
  final String? name;
  final String? profilePic;
  bool? webView = false;
final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: _controller,
        isAlwaysShown: true,
        thickness: 8,
        child: ListView.builder(
          controller: _controller,
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
