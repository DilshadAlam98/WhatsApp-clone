import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:whatsapp_clone/bloc/onboarding/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/model/country_model.dart';

class VerifyYourNumber extends StatelessWidget {
  const VerifyYourNumber({
    Key? key,
    required this.state,
    required this.formCodeKey,
    required this.formCountryKey,
    required this.formPhoneKey,
    required this.phoneNumberController,
    this.onTap,
  }) : super(key: key);

  final OnboardingState state;
  final GlobalKey<FormState> formCodeKey;
  final GlobalKey<FormState> formCountryKey;
  final GlobalKey<FormState> formPhoneKey;
  final VoidCallback? onTap;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _contentInfo(),
        const SizedBox(height: 10),
        _selectYourCountry(state, context),
        const SizedBox(height: 10),
        _phoneNumberRow(state, context),
        _buttonContent(context)
      ],
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
        SizedBox(height: 30),
        Text(
          "WhatsApp will send a SMS message to verify your phone number. Enter your country code along with phone number.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _selectYourCountry(OnboardingState? state, BuildContext context) {
    return Form(
      key: formCountryKey,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: const InputDecoration(
          errorStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        hint: const Text("Select your country"),
        validator: (CountryIso? value) =>
            context.read<OnboardingCubit>().validateCountryName(value),
        value: state?.country,
        items: state?.countryIsoList?.countryIso
            .map(
              (e) => DropdownMenuItem<CountryIso>(
                value: e,
                child: Text(e.name!),
              ),
            )
            .toList(),
        onChanged: (CountryIso? value) =>
            context.read<OnboardingCubit>().onCountryChange(value),
      ),
    );
  }

  Widget _phoneNumberRow(OnboardingState? state, BuildContext context) {
    return Row(
      children: [
        Form(
          key: formCodeKey,
          child: SizedBox(
            width: 80,
            height: 65,
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                isExpanded: true,
                hint: const Text("Code"),
                value: state?.countryCode,
                validator: (CountryIso? value) =>
                    context.read<OnboardingCubit>().validateCountryCode(value),
                items: state?.countryIsoList?.countryIso
                    .map(
                      (e) => DropdownMenuItem<CountryIso>(
                        value: e,
                        child: Text(e.code!),
                      ),
                    )
                    .toList(),
                onChanged: (CountryIso? value) =>
                    context.read<OnboardingCubit>().onCountryCodeChange(value)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Form(
            key: formPhoneKey,
            child: TextFormField(
              controller: phoneNumberController,
              maxLength: 10,
              validator: (String? phone) =>
                  context.read<OnboardingCubit>().validatePhoneNumber(phone),
              decoration: const InputDecoration(
                isDense: true,
                errorStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                label: Text("Enter Your Phone Number"),
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget _buttonContent(BuildContext context) {
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
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Carrier SMS charges may apply",
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
