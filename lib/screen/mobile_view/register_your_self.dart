import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/mobile_screen.dart';
import 'package:whatsapp_clone/widget/app_textfield.dart';

class RegisterYourSelf extends StatelessWidget {
  const RegisterYourSelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chooseYourProfilePicture(),
              const SizedBox(height: 30),
              AppTextField(
                hintText: "Enter you display name",
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              AppTextField(
                hintText: "Write your Status....",
                maxLines: 4,
                onChanged: (value) {},
              ),
              const SizedBox(height: 15),
              _buttonContent(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseYourProfilePicture() {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 55,
        ),
        Positioned(
          bottom: 6,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
        ),
      ],
    );
  }

  Widget _buttonContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              backgroundColor: tabColor),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const MobileScreen()),
                (Route<dynamic> route) => false);
          },
          child: const Text(
            "Finish",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
