import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/mobile_view/call_log_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/status_screen.dart';
import 'package:whatsapp_clone/widget/contact_list.dart';

final List<String> tabs = ["Chat", "Status", "Calls"];

final List<Widget> tabPage = [
  const ContactList(),
  const StatusScreen(),
  const CallLogScreen()
];
