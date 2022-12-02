import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:whatsapp_clone/constant/global_variable.dart';
import 'package:whatsapp_clone/model/country_model.dart';
import 'package:whatsapp_clone/repository/onboarding_repo.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState()) {
    getCountries();
  }
  final _onBoardingRepo = OnBoardingRepo();
  void getCountries() async {
    emit(state.copyWith(networkState: NetworkState.loading));

    try {
      final country = await _onBoardingRepo.getCountries();
      if (country.countryIso.isNotEmpty) {
        emit(state.copyWith(
          countryIsoList: country,
          buttonController: RoundedLoadingButtonController(),
          networkState: NetworkState.completed,
          errorResponse: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        countryIsoList: null,
        errorResponse: e,
        networkState: NetworkState.error,
      ));
    }
  }

  void onCountryChange(CountryIso? changedCountry) {
    emit(state.copyWith(country: changedCountry, countryCode: changedCountry));
  }

  void onCountryCodeChange(CountryIso? countryCode) {
    emit(state.copyWith(countryCode: countryCode));
  }

  String? validateCountryName(CountryIso? value) {
    if (value?.name == null) {
      return "Please select country name";
    }
    return null;
  }

  String? validateCountryCode(CountryIso? value) {
    if (value?.code == null) {
      return "Please select country code";
    }
    return null;
  }

  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number is required";
    }
    if (phone.length != 10) {
      return "Phone number should be 10 digit";
    }
    if (canSubmit(phone)) {
      return "Can't use special character";
    }
    return null;
  }

  bool canSubmit(String value) {
    if (value.contains(',') || value.contains(".") || value.contains("/")) {
      return true;
    }
    return false;
  }

  String? validateForm(String? value) {
    if (value == null || value.isEmpty) {
      return "Value is Required";
    }

    return null;
  }

  void verifyYourNumber() async {
    state.buttonController?.start();
    emit(state.copyWith(isOtpSent: true, networkState: NetworkState.completed));
    state.buttonController?.reset();
  }
}
