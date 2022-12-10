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

enum NetworkState { initial, loading, completed, error }

class CollectionKeys {
  static String users = "Users";
  static String userPreferenceKey = "1212sad453";
}

List<String> aboutList = [
  "Available",
  "Busy",
  "At school",
  "At the movies",
  "At work",
  "Battery about to die",
  "Can't talk, WhatsApp only",
  "In a meeting",
  "At the gym",
  "Sleeping",
  "Urgent call only",
];
