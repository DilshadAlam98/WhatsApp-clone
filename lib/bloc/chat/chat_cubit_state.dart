import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/global_variable.dart';

class ChatCubitState<T> extends Equatable {
  final TabController? tabController;
  final NetworkState? networkState;
  final T? errorResponse;

  const ChatCubitState({
    this.errorResponse,
    this.networkState,
    this.tabController,
  });

  ChatCubitState copyWith({
    final NetworkState? networkState,
    final bool? isLoadingMore,
    final T? errorResponse,
    final TabController? tabController,
  }) {
    return ChatCubitState(
        networkState: networkState ?? this.networkState,
        tabController: tabController ?? this.tabController,
        errorResponse: errorResponse ?? this.errorResponse);
  }

  @override
  String toString() {
    return 'ChatCubitState{networkState: $networkState, errorResponse: $errorResponse, tabIndex: $tabController,}';
  }

  @override
  List<Object?> get props => [networkState, tabController, errorResponse];
}
