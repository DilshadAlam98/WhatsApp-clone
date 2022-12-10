part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final NetworkState? networkState;
  final bool isChatInputEmpty;
  const ChatState({this.networkState, this.isChatInputEmpty = false});

  ChatState copyWith({
    final NetworkState? networkState,
    final bool? isChatInputEmpty = false,
  }) {
    return ChatState(
        networkState: networkState ?? this.networkState,
        isChatInputEmpty: isChatInputEmpty ?? this.isChatInputEmpty);
  }

  @override
  List<Object?> get props => [
        networkState,
        isChatInputEmpty,
      ];
}
