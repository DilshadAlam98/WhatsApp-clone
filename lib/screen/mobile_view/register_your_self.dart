import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:whatsapp_clone/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/widget/app_textfield.dart';

class RegisterYourSelf extends StatefulWidget {
  const RegisterYourSelf({Key? key}) : super(key: key);

  @override
  State<RegisterYourSelf> createState() => _RegisterYourSelfState();
}

class _RegisterYourSelfState extends State<RegisterYourSelf> {
  final _nameFormKey = GlobalKey<FormState>();
  final _statusFormKey = GlobalKey<FormState>();
  String? name;
  String? about;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            bloc: context.watch<OnboardingCubit>(),
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _chooseYourProfilePicture(state),
                  const SizedBox(height: 30),
                  Form(
                    key: _nameFormKey,
                    child: AppTextField(
                      validator: (value) =>
                          context.read<OnboardingCubit>().validateForm(value),
                      hintText: "Enter you display name",
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _statusFormKey,
                    child: AppTextField(
                      validator: (value) =>
                          context.read<OnboardingCubit>().validateForm(value),
                      hintText: "Write your Status....",
                      maxLines: 4,
                      onChanged: (value) {
                        about = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buttonContent(context, state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _chooseYourProfilePicture(OnboardingState state) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: messageColor,
          backgroundImage: FileImage(File(state.pickedImage!.path)),
        ),
        Positioned(
          bottom: 0,
          right: -8,
          child: IconButton(
            onPressed: () async => await _openBottomSheet(context: context),
            icon: const Icon(
              Icons.camera_alt,
              color: tabColor,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openBottomSheet({
    required BuildContext context,
  }) async {
    return await showModalBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: appBarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  _chooseProfileFromSection(
                    chooseFrom: "Camera",
                    icon: Icons.camera_alt_outlined,
                    callback: () async => await context
                        .read<OnboardingCubit>()
                        .pickProfilePicture(ImageSource.camera)
                        .then((value) => Navigator.pop(context)),
                  ),
                  const SizedBox(width: 30),
                  _chooseProfileFromSection(
                    chooseFrom: "Gallery",
                    icon: Icons.photo_album_rounded,
                    callback: () {},
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _chooseProfileFromSection({
    required IconData icon,
    required String chooseFrom,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: tabColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            chooseFrom,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 1.2,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _buttonContent(BuildContext context, OnboardingState state) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: 105,
          child: RoundedLoadingButton(
            controller: state.buttonController!,
            height: 36,
            animateOnTap: false,
            loaderStrokeWidth: 1.4,
            successColor: Colors.green,
            color: tabColor,
            errorColor: Colors.grey,
            successIcon: Icons.check_rounded,
            loaderSize: 18,
            elevation: 2,
            onPressed: () {
              if (isFieldValid) {
                context
                    .read<OnboardingCubit>()
                    .createUser(context, about!, name!);
              }
            },
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

  bool get isFieldValid => (_nameFormKey.currentState!.validate() &&
      _statusFormKey.currentState!.validate());
}
