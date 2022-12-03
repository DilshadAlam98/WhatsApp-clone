import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

class MobileCubitState<T> extends Equatable {
  final TabController? tabController;
  final int? tabIndex;
  final NetworkState? networkState;
  final T? errorResponse;
  final UserReqResModel? user;

  const MobileCubitState({
    this.errorResponse,
    this.networkState,
    this.tabController,
    this.tabIndex = 0,
    this.user,
  });

  MobileCubitState copyWith({
    final NetworkState? networkState,
    final bool? isLoadingMore,
    final T? errorResponse,
    final TabController? tabController,
    final int? tabIndex,
    final UserReqResModel? user,
  }) {
    return MobileCubitState(
        networkState: networkState ?? this.networkState,
        tabController: tabController ?? this.tabController,
        errorResponse: errorResponse ?? this.errorResponse,
        tabIndex: tabIndex ?? this.tabIndex,
        user: user ?? this.user);
  }

  @override
  String toString() {
    return 'ChatCubitState{networkState: $networkState, errorResponse: $errorResponse, tabController: $tabController,tabIndex: $tabIndex}';
  }

  @override
  List<Object?> get props => [
        networkState,
        tabController,
        errorResponse,
        tabIndex,
        user,
      ];
}
