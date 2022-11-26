import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      if (country.countryIso.isEmpty) {
        emit(state.copyWith(
          countryIsoList: country,
          networkState: NetworkState.completed,
          errorResponse: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          countryIsoList: null,
          errorResponse: e,
          networkState: NetworkState.error));
    }
  }
}
