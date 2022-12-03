import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_state.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';
import 'package:whatsapp_clone/repository/firebase_repo.dart';
import 'package:whatsapp_clone/utils/local_preference.dart';

class MobileCubit extends Cubit<MobileCubitState> {
  MobileCubit() : super(const MobileCubitState());

  final _firebaseRepo = FirebaseRepo();
  final _localPreference = LocalPreference();

  void initializeTabController(TabController tabController) {
    emit(state.copyWith(tabController: tabController));
    state.tabController?.addListener(() {
      emit(state.copyWith(tabIndex: state.tabController?.index));
    });
    fetchCurrentUser();
  }

  onMenuTapRoute(String value, BuildContext context, UserReqResModel user) {
    switch (value) {
      case 'New group':
        return Navigator.pushNamed(context, RouteConstant.newGroup);
      case 'New broadcast':
        return Navigator.pushNamed(context, RouteConstant.newBroadcast);
      case 'Starred messages':
        return Navigator.pushNamed(context, RouteConstant.starredMessage);
      case 'Payments':
        return Navigator.pushNamed(context, RouteConstant.payments);
      case 'Settings':
        return Navigator.pushNamed(context, RouteConstant.settings);
    }
  }

  void fetchCurrentUser() async {
    emit(state.copyWith(
      networkState: NetworkState.loading,
      user: null,
      errorResponse: null,
    ));
    try {
      _firebaseRepo.fetchCurrentUser().listen((event) {
        // _localPreference.setUserToPreference(user).listen((event) {});
        emit(state.copyWith(
          networkState: NetworkState.completed,
          user: event,
          errorResponse: null,
        ));
      });
    } on FirebaseException catch (e) {
      emit(state.copyWith(
        networkState: NetworkState.error,
        user: null,
        errorResponse: e.message,
      ));
    }
  }
}
