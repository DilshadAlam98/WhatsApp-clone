import 'package:flutter/material.dart';
import 'package:status_view/status_view.dart';
import 'package:whatsapp_clone/constant/info.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: info.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const _MyStatusView();
        }
        return _StatusList(info[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _StatusList extends StatelessWidget {
  const _StatusList(this.data, {Key? key}) : super(key: key);

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: StatusView(
        radius: 30,
        spacing: 10,
        strokeWidth: 2,
        indexOfSeenStatus: 2,
        numberOfStatus: 5,
        padding: 3.5,
        centerImageUrl: data['profilePic'] ?? "",
        seenColor: Colors.grey,
        unSeenColor: Colors.blueAccent,
      ),
      title: Text(
        data['name'] ?? "",
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

class _MyStatusView extends StatelessWidget {
  const _MyStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        "My Status",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(top: 6.0),
        child: Text(
          "No updates",
          style: TextStyle(fontSize: 15),
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          info[0]['profilePic'].toString(),
        ),
        radius: 30,
      ),
    );
  }
}
