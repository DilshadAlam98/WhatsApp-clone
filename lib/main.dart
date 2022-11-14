import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/onboarding_page.dart';
import 'package:whatsapp_clone/utils/responsive_layout.dart';
import 'package:whatsapp_clone/screen/web_view/web_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const ResponsiveLayoutScreen(
        mobileLayoutScreen: OnBoardingView(),
        webLayoutScreen: WebLayoutScreen(),
      ),
    );
  }
}
