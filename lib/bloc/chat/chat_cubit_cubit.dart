import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_state.dart';

class ChatCubitCubit extends Cubit<ChatCubitState> {
  ChatCubitCubit() : super(const ChatCubitState());

  void toggleTab(TabController tabController, VoidCallback callback) {
    emit(state.copyWith(tabController: tabController));
    tabController.addListener(callback.call);
  }
}
