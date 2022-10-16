import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/widget/contact_list.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar(),
        body:  SafeArea(
          child: TabBarView(
              children:tabPage.map((e) => e).toList()),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: false,
      elevation: 0,
      title: const Text(
        "WhatsApp",
        style: TextStyle(
            fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      actions: [
        _actionIconButton(icon: Icons.search),
        _actionIconButton(icon: Icons.more_vert),
      ],
      bottom: TabBar(
        indicatorColor: tabColor,
        indicatorWeight: 4,
        labelColor: tabColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: tabs.map((e) => _tabs(e)).toList(),
      ),
    );
  }

  Tab _tabs(String text) {
    return Tab(
      text: text,
    );
  }

  Widget _actionIconButton({required IconData icon, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey),
      onPressed: onPressed,
    );
  }
}
