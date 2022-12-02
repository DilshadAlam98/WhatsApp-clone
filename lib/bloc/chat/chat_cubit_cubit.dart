import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/bloc/chat/chat_cubit_state.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';

class ChatCubitCubit extends Cubit<ChatCubitState> {
  ChatCubitCubit() : super(const ChatCubitState());

  void initializeTabController(TabController tabController) {
    emit(state.copyWith(tabController: tabController));
    state.tabController?.addListener(() {
      emit(state.copyWith(tabIndex: state.tabController?.index));
    });
  }

  onMenuTapRoute(String value, BuildContext context) {
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
}
