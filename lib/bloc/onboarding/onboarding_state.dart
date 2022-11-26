part of 'onboarding_cubit.dart';

class OnboardingState<T> extends Equatable {
  final NetworkState? networkState;
  final T? errorResponse;
  final CountryIsoList? countryIsoList;

  const OnboardingState(
      {this.errorResponse, this.networkState, this.countryIsoList});

  OnboardingState copyWith({
    final NetworkState? networkState,
    final T? errorResponse,
    final CountryIsoList? countryIsoList,
  }) {
    return OnboardingState(
        networkState: networkState ?? this.networkState,
        countryIsoList: countryIsoList ?? this.countryIsoList,
        errorResponse: errorResponse ?? this.errorResponse);
  }

  @override
  String toString() {
    return 'OnboardingState{networkState: $networkState, errorResponse: $errorResponse, countryIsoList: $countryIsoList,}';
  }

  @override
  List<Object> get props => [];
}
