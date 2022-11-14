import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widget/status_list.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StatusListView(),
    );
  }
}
