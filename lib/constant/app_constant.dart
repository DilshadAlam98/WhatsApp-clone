import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screen/mobile/call_log_screen.dart';
import 'package:whatsapp_clone/screen/mobile/status_screen.dart';
import 'package:whatsapp_clone/widget/contact_list.dart';

final List<String> tabs = ["Chat", "Status", "Calls"];

final List<Widget> tabPage = [
  const ContactList(),
  const StatusScreen(),
  const CallLogScreen()
];
