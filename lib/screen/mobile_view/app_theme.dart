import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text(
          "Change Theme",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            const Text(
              "Choose theme to adjust your preferences",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: 1.2,
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: 0,
              onChanged: (value) {},
              title: const Text(
                "Light",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    letterSpacing: 1.2),
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
              title: const Text(
                "Dark",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    letterSpacing: 1.2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
