import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/add_status_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/app_theme.dart';
import 'package:whatsapp_clone/screen/mobile_view/contact_list_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/mobile_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/new_broadcast_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/new_group_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/payments_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/profile_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/register_your_self.dart';
import 'package:whatsapp_clone/screen/mobile_view/select_contact_to_call_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/setting_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/starred_message_screen.dart';
import 'package:whatsapp_clone/widget/chat_screen.dart';

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
          builder: (context) => ChatScreen(
            name: arg['name'],
            profilePic: arg['profilePic'],
          ),
        );

      case RouteConstant.settings:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );
      case RouteConstant.newBroadcast:
        return MaterialPageRoute(
          builder: (context) => const NewBroadCastScreen(),
        );

      case RouteConstant.newGroup:
        return MaterialPageRoute(
          builder: (context) => const NewGroupScreen(),
        );

      case RouteConstant.payments:
        return MaterialPageRoute(
          builder: (context) => const PaymentsScreen(),
        );

      case RouteConstant.starredMessage:
        return MaterialPageRoute(
          builder: (context) => const StarredMessageScreen(),
        );
      case RouteConstant.contactListScreen:
        return MaterialPageRoute(
          builder: (context) => const ContactListScreen(),
        );
      case RouteConstant.addStatusScreen:
        return MaterialPageRoute(
          builder: (context) => const AddStatusScreen(),
        );
      case RouteConstant.selectContactToCall:
        return MaterialPageRoute(
          builder: (context) => const SelectContactToCall(),
        );
      case RouteConstant.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case RouteConstant.appTheme:
        return MaterialPageRoute(
          builder: (context) => const AppTheme(),
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
