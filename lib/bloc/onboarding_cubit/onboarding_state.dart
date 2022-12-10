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
  final String? whatsAppNumber;
  final UserReqResModel? localPreference;
  final String? uid;
  final XFile? pickedImage;

  const OnboardingState(
      {this.errorResponse,
      this.networkState,
      this.countryIsoList,
      this.countryCode,
      this.country,
      this.isOtpSent = false,
      this.buttonController,
      this.verificationId,
      this.whatsAppNumber,
      this.localPreference,
      this.uid,
      this.pickedImage});

  OnboardingState copyWith({
    final NetworkState? networkState,
    final T? errorResponse,
    final CountryIsoList? countryIsoList,
    final CountryIso? country,
    final CountryIso? countryCode,
    final bool? isOtpSent,
    final RoundedLoadingButtonController? buttonController,
    final String? verificationId,
    final String? whatsAppNumber,
    final UserReqResModel? localPreference,
    final String? uid,
    final XFile? pickedImage,
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
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      localPreference: localPreference ?? this.localPreference,
      uid: uid ?? this.uid,
      pickedImage: pickedImage ?? this.pickedImage,
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
        buttonController,
        whatsAppNumber,
        localPreference,
        pickedImage
      ];
}
