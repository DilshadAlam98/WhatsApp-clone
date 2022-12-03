import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_cubit.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_state.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<MobileCubit, MobileCubitState>(
        builder: (context, state) {
          return ListView(
            children: [
              _profileHeaderSection(context, state.user!),
              const SizedBox(height: 15),
              _contentTileSection(
                icon: Icons.key_off_outlined,
                title: "Account",
                subtitle: "Security notification, change number",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.lock,
                title: "Privacy",
                subtitle: "Block contacts disappearing messages",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.chat,
                title: "Chats",
                subtitle: "Theme, wallpapers, chat history",
                callback: () => Navigator.pushNamed(
                  context,
                  RouteConstant.appTheme,
                ),
              ),
              _contentTileSection(
                icon: Icons.notification_add_outlined,
                title: "Notifications",
                subtitle: "Message, group & call tones",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.circle_outlined,
                title: "Storage and data",
                subtitle: "Network usage, auto-download",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.web_stories,
                title: "App language",
                subtitle: "English (phone's language)",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.question_mark_outlined,
                title: "Help",
                subtitle: "Help center, contact us, privacy policy",
                callback: () {},
              ),
              _contentTileSection(
                icon: Icons.lock,
                title: "Invite a friend",
                subtitle: "",
                callback: () {},
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'version 1.0.2',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _contentTileSection({
    required VoidCallback callback,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      dense: true,
      minVerticalPadding: 15.0,
      minLeadingWidth: 35,
      onTap: callback,
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _profileHeaderSection(BuildContext context, UserReqResModel user) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, RouteConstant.profileScreen),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      leading: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tabColor,
          image: DecorationImage(
            image: NetworkImage(user.profilePic!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        user.name ?? "",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        user.about ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      trailing: const Icon(
        Icons.qr_code,
        color: tabColor,
      ),
    );
  }
}
