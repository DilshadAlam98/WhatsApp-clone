import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/onboarding/onboarding_cubit.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/global_variable.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/model/country_model.dart';

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
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
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
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _contentInfo(),
                  _selectYourCountry(state, context),
                  const SizedBox(height: 10),
                  _phoneNumberRow(state, context),
                  _buttonContent(context)
                ],
              ),
            ),
          );
        },
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

  Widget _selectYourCountry(OnboardingState? state, BuildContext context) {
    return Form(
      key: _formCountryKey,
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
          key: _formCodeKey,
          child: SizedBox(
            width: 100,
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
        const SizedBox(width: 10),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Form(
            key: _formPhoneKey,
            child: TextFormField(
              // expands: true,
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              backgroundColor: tabColor),
          onPressed: () {
            if (isValidate) {
              Navigator.pushReplacementNamed(
                context,
                RouteConstant.registerYourSelf,
              );
            }
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

  bool get isValidate => (_formCountryKey.currentState!.validate() &&
      _formCodeKey.currentState!.validate() &&
      _formPhoneKey.currentState!.validate());
}
