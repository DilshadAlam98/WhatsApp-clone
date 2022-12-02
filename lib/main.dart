import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/bloc_utils/bloc_observer.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_cubit.dart';
import 'package:whatsapp_clone/bloc/onboarding/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_manager.dart';
import 'package:whatsapp_clone/screen/mobile_view/onboarding_screen.dart';
import 'package:whatsapp_clone/utils/responsive_layout.dart';
import 'package:whatsapp_clone/screen/web_view/web_screen.dart';

void main() {
  Bloc.observer = MyAppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubitCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp UI',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        onGenerateRoute: RouteManager.onGenerateRoute,
        home: const ResponsiveLayoutScreen(
          mobileLayoutScreen: OnBoardingScreen(),
          webLayoutScreen: WebLayoutScreen(),
        ),
      ),
    );
  }
}
