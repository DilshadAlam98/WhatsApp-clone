import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/repository/firebase_repo.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  final _firebaseRepo = FirebaseRepo();

  Future<void> pickProfilePicture(ImageSource imageSource) async {
    emit(state.copyWith(networkState: NetworkState.loading));
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      await updateProfilePic(pickedImage);
      emit(state.copyWith(
        pickedImage: pickedImage,
        networkState: NetworkState.completed,
      ));
    }
    emit(state.copyWith(networkState: NetworkState.error));
  }

  Future<void> updateProfilePic(XFile profilePic) async {
    final profileUrl = await _firebaseRepo.getImageUrl(profilePic);
    return _firebaseRepo.updateProfilePic(profileUrl);
  }

  Future<void> updateNameOrPhone({String? name, String? phoneNumber}) async {
    return await _firebaseRepo.updateNameOrPhone(name, phoneNumber);
  }
}
