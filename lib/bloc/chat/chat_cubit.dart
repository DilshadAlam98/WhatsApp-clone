import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState());

  void checkChatInputEmpty(String? input) {
    if (input != null && input.isNotEmpty) {
      emit(state.copyWith(isChatInputEmpty: true));
    } else {
      emit(state.copyWith(isChatInputEmpty: false));
    }
  }
}
