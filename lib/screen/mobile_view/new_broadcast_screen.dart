import 'package:flutter/material.dart';

class NewBroadCastScreen extends StatefulWidget {
  const NewBroadCastScreen({Key? key}) : super(key: key);

  @override
  State<NewBroadCastScreen> createState() => _NewBroadCastScreenState();
}

class _NewBroadCastScreenState extends State<NewBroadCastScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("New Broadcast screen"),
      ),
    );
  }
}
