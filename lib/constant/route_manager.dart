import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/mobile_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/register_your_self.dart';
import 'package:whatsapp_clone/widget/chat_list.dart';

class RouteManager {
  static PageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.registerYourSelf:
        return MaterialPageRoute(
          builder: (context) => const RegisterYourSelf(),
        );

      case RouteConstant.mobileScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileScreen(),
        );
      case RouteConstant.chatScreen:
        final arg = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (context) => ChatList(
            name: arg['name'],
            profilePic: arg['profilePic'],
          ),
        );
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text("Server unavailable"),
        ),
      ),
    );
  }
}
