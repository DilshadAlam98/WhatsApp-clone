import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/register_your_self.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _contentInfo(),
              _selectYourCountry(),
              _phoneNumberRow(),
              _buttonContent(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentInfo() {
    return Column(
      children: const [
        Text(
          "Verify your Phone Number",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: tabColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "WhatsApp Will send a SMS message to verify your phone number. Enter your country code and phone number",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _selectYourCountry() {
    return DropdownButton(
      isExpanded: true,
      items: ["india", "UAE", "America"]
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (value) {},
    );
  }

  Widget _phoneNumberRow() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          // height: 65,
          child: DropdownButton(
            isExpanded: true,
            items: ["+91", "273", "+810"]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: TextFormField(
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                label: Text("Enter Your Phone Number")),
          ),
        ))
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
                    builder: (BuildContext context) =>
                        const RegisterYourSelf()),
                (Route<dynamic> route) => false);
          },
          child: const Text(
            "Next",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Carrier SMS charges may apply",
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}