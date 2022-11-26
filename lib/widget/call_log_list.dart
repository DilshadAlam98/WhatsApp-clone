import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/info.dart';

class CallLogListView extends StatelessWidget {
  const CallLogListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: info.length,
      itemBuilder: (context, index) {
        return _CallLogList(info[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _CallLogList extends StatelessWidget {
  const _CallLogList(this.data, {Key? key}) : super(key: key);
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data['name'].toString(),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Row(
          children: [
            const Icon(
              Icons.call_missed_outgoing_outlined,
              color: CupertinoColors.systemGreen,
            ),
            const SizedBox(width: 8),
            Text(
              "12 October ${data['time'].toString()}",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          data['profilePic'].toString(),
        ),
        radius: 30,
      ),
      trailing: const Icon(
        Icons.call,
        color: CupertinoColors.systemGreen,
      ),
    );
  }
}
