part of 'profile_cubit.dart';

class ProfileState<T> extends Equatable {
  final NetworkState? networkState;
  final T? errorResponse;
  final XFile? pickedImage;

  const ProfileState({this.networkState, this.errorResponse, this.pickedImage});

  ProfileState copyWith({
    final NetworkState? networkState,
    final T? errorResponse,
    final XFile? pickedImage,
  }) {
    return ProfileState(
      networkState: networkState ?? this.networkState,
      errorResponse: errorResponse ?? this.errorResponse,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }

  @override
  List<Object?> get props => [
        networkState,
        errorResponse,
        pickedImage,
      ];
}
