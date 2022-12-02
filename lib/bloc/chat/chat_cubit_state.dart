import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/global_variable.dart';

class ChatCubitState<T> extends Equatable {
  final TabController? tabController;
  final int? tabIndex;
  final NetworkState? networkState;
  final T? errorResponse;

  const ChatCubitState({
    this.errorResponse,
    this.networkState,
    this.tabController,
    this.tabIndex = 0,
  });

  ChatCubitState copyWith({
    final NetworkState? networkState,
    final bool? isLoadingMore,
    final T? errorResponse,
    final TabController? tabController,
    final int? tabIndex,
  }) {
    return ChatCubitState(
      networkState: networkState ?? this.networkState,
      tabController: tabController ?? this.tabController,
      errorResponse: errorResponse ?? this.errorResponse,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  @override
  String toString() {
    return 'ChatCubitState{networkState: $networkState, errorResponse: $errorResponse, tabController: $tabController,tabIndex: $tabIndex}';
  }

  @override
  List<Object?> get props =>
      [networkState, tabController, errorResponse, tabIndex];
}
