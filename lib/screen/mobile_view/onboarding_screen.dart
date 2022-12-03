import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
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
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _otpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            bloc: context.watch<OnboardingCubit>(),
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
                  otpController: _otpController,
                  otpFormKey: _otpFormKey,
                  onTap: () {
                    if (isOtpValidate) {
                      context
                          .read<OnboardingCubit>()
                          .verifyYourOTP(_otpController.text.trim(), context);
                    }
                  },
                );
              }
              return VerifyYourNumber(
                state: state,
                phoneNumberController: _phoneNumberController,
                formCodeKey: _formCodeKey,
                formCountryKey: _formCountryKey,
                formPhoneKey: _formPhoneKey,
                onTap: () {
                  if (isNumberValidate) {
                    context.read<OnboardingCubit>().verifyYourNumber(
                        _phoneNumberController.text.trim(), context);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  bool get isOtpValidate => (_otpFormKey.currentState!.validate());

  bool get isNumberValidate => (_formCountryKey.currentState!.validate() &&
      _formCodeKey.currentState!.validate() &&
      _formPhoneKey.currentState!.validate());
}
