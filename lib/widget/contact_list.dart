import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/info.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: info.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => _navigateToChatScreen(
                context,
                name: info[index]['name'].toString(),
                profilePic: info[index]['profilePic'].toString(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(
                    info[index]['name'].toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      info[index]['message'].toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      info[index]['profilePic'].toString(),
                    ),
                    radius: 30,
                  ),
                  trailing: Text(
                    info[index]['time'].toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: dividerColor, indent: 85),
          ],
        );
      },
    );
  }

  _navigateToChatScreen(
    BuildContext context, {
    required String name,
    required String profilePic,
  }) {
    Navigator.pushNamed(
      context,
      RouteConstant.chatScreen,
      arguments: {
        'name': name,
        'profilePic': profilePic,
      },
    );
  }
}
