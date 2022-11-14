import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widget/call_log_list.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CallLogListView(),
    );
  }
}
