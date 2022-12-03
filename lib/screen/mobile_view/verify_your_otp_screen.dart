import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:whatsapp_clone/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class EnterYourOTP extends StatelessWidget {
  const EnterYourOTP({
    Key? key,
    this.onTap,
    required this.state,
    required this.otpController,
    required this.otpFormKey,
  }) : super(key: key);

  final OnboardingState state;
  final VoidCallback? onTap;
  final TextEditingController otpController;
  final GlobalKey<FormState> otpFormKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Verify your OTP!!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: tabColor,
            fontSize: 22,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          " SMS sent to your phone number",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
          key: otpFormKey,
          child: PinCodeTextField(
            controller: otpController,
            appContext: context,
            length: 6,
            autoFocus: true,
            obscureText: false,
            autoUnfocus: true,
            errorTextSpace: 30,
            cursorColor: messageColor,
            cursorWidth: 2.5,
            validator: context.read<OnboardingCubit>().validateOtp,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              activeColor: messageColor,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              inactiveFillColor: Colors.grey,
              inactiveColor: Colors.grey,
              selectedFillColor: Colors.white.withOpacity(0.8),
              errorBorderColor: Colors.red,
              selectedColor: Colors.white.withOpacity(0.8),
              borderWidth: 2,
              fieldOuterPadding: const EdgeInsets.all(3),
              activeFillColor: messageColor,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onChanged: (String value) {},
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 105,
          child: RoundedLoadingButton(
            controller: state.buttonController!,
            animateOnTap: false,
            height: 36,
            loaderStrokeWidth: 1.4,
            successColor: Colors.green,
            color: tabColor,
            errorColor: Colors.grey,
            successIcon: Icons.check_rounded,
            loaderSize: 18,
            onPressed: onTap,
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
