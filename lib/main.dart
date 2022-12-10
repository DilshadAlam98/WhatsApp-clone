import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/bloc_utils/bloc_observer.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_cubit.dart';
import 'package:whatsapp_clone/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:whatsapp_clone/bloc/profile_cubit/profile_cubit.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_manager.dart';
import 'package:whatsapp_clone/screen/mobile_view/mobile_screen.dart';
import 'package:whatsapp_clone/screen/mobile_view/onboarding_screen.dart';
import 'package:whatsapp_clone/utils/responsive_layout.dart';
import 'package:whatsapp_clone/screen/web_view/web_screen.dart';

void main() async {
  Bloc.observer = MyAppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            create: (context) => MobileCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider(
            create: (context) => ChatCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WhatsApp UI',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          onGenerateRoute: RouteManager.onGenerateRoute,
          home: const App(),
        ));
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      bloc: context.watch<OnboardingCubit>(),
      builder: (context, state) {
        if (state.networkState == NetworkState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.uid != null) {
          return const ResponsiveLayoutScreen(
            mobileLayoutScreen: MobileScreen(),
            webLayoutScreen: WebLayoutScreen(),
          );
        }
        return const ResponsiveLayoutScreen(
          mobileLayoutScreen: OnBoardingScreen(),
          webLayoutScreen: WebLayoutScreen(),
        );
      },
    );
  }
}
