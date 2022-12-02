import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/onboarding/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/global_variable.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/screen/mobile_view/verify_your_number_scree.dart';
import 'package:whatsapp_clone/screen/mobile_view/verify_your_otp_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _formCodeKey = GlobalKey<FormState>();
  final _formCountryKey = GlobalKey<FormState>();
  final _formPhoneKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              if (state.networkState == NetworkState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.networkState == NetworkState.error) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.isOtpSent) {
                return EnterYourOTP(
                  state: state,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteConstant.mobileScreen,
                    );
                  },
                );
              }
              return VerifyYourNumber(
                state: state,
                formCodeKey: _formCodeKey,
                formCountryKey: _formCountryKey,
                formPhoneKey: _formPhoneKey,
                onTap: () {
                  if (isValidate) {
                    context.read<OnboardingCubit>().verifyYourNumber();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  bool get isValidate => (_formCountryKey.currentState!.validate() &&
      _formCodeKey.currentState!.validate() &&
      _formPhoneKey.currentState!.validate());
}
