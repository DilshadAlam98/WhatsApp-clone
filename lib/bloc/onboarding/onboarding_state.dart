part of 'onboarding_cubit.dart';

class OnboardingState<T> extends Equatable {
  final NetworkState? networkState;
  final T? errorResponse;
  final CountryIsoList? countryIsoList;
  final CountryIso? country;
  final CountryIso? countryCode;
  final bool isOtpSent;
  final RoundedLoadingButtonController? buttonController;
  final String? verificationId;

  const OnboardingState({
    this.errorResponse,
    this.networkState,
    this.countryIsoList,
    this.countryCode,
    this.country,
    this.isOtpSent = false,
    this.buttonController,
    this.verificationId,
  });

  OnboardingState copyWith({
    final NetworkState? networkState,
    final T? errorResponse,
    final CountryIsoList? countryIsoList,
    final CountryIso? country,
    final CountryIso? countryCode,
    final bool? isOtpSent,
    final RoundedLoadingButtonController? buttonController,
    final String? verificationId,
  }) {
    return OnboardingState(
      networkState: networkState ?? this.networkState,
      countryIsoList: countryIsoList ?? this.countryIsoList,
      errorResponse: errorResponse ?? this.errorResponse,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      buttonController: buttonController ?? this.buttonController,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  String toString() {
    return 'OnboardingState{networkState: $networkState, errorResponse: $errorResponse, countryIsoList: $countryIsoList, country: $country, countryCode: $countryCode}';
  }

  @override
  List<Object?> get props => [
        networkState,
        countryIsoList,
        errorResponse,
        country,
        isOtpSent,
        buttonController
      ];
}
