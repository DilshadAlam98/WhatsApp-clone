import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/mobile_view/call_log_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/status_screen.dart';
import 'package:whatsapp_clone/widget/chat_list_screen.dart';

final List<String> tabs = ["Chat", "Status", "Calls"];

final List<Widget> tabPage = [
  const ChatListScreen(),
  const StatusScreen(),
  const CallLogScreen()
];

final List<String> menuItems = [
  'New group',
  'New broadcast',
  'Starred messages',
  'Payments',
  'Settings'
];
