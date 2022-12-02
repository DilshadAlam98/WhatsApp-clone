import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/onboarding/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/widget/app_textfield.dart';

class RegisterYourSelf extends StatefulWidget {
  const RegisterYourSelf({Key? key}) : super(key: key);

  @override
  State<RegisterYourSelf> createState() => _RegisterYourSelfState();
}

class _RegisterYourSelfState extends State<RegisterYourSelf> {
  final _nameFormKey = GlobalKey<FormState>();
  final _statusFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _chooseYourProfilePicture(),
                  const SizedBox(height: 30),
                  Form(
                    key: _nameFormKey,
                    child: AppTextField(
                      hintText: "Enter you display name",
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _statusFormKey,
                    child: AppTextField(
                      hintText: "Write your Status....",
                      maxLines: 4,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buttonContent(context)
                ],
              );
            },
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
            if (_nameFormKey.currentState!.validate() &&
                _statusFormKey.currentState!.validate()) {
              Navigator.pushReplacementNamed(
                context,
                RouteConstant.mobileScreen,
              );
            }
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
