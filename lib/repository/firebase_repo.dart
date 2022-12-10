import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/model/country_model.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';
import 'package:whatsapp_clone/source/api_source.dart';
import 'package:whatsapp_clone/source/firebase_source.dart';

class FirebaseRepo {
  final _apiServices = ApiSource();
  final _firebaseSource = FirebaseSource();

  Future<CountryIsoList> getCountries() async {
    final data = await _apiServices.getCountries();
    return data;
  }

  Future<bool> createUser(UserReqResModel userReq) async {
    final isUserCreated = await _firebaseSource.createUser(userReq);
    return isUserCreated;
  }

  Stream<UserReqResModel> fetchCurrentUser() {
    final user = _firebaseSource.fetchCurrentUser();
    return user;
  }

  Future<String> getImageUrl(XFile file) async {
    final imageUrl = await _firebaseSource.getImageUrl(file);
    return imageUrl;
  }

  Future<void> updateProfilePic(String profilePic) async {
    return await _firebaseSource.updateProfilePic(profilePic);
  }

  Future<void> updateNameOrPhone(String? name, String? phoneNumber) async {
    return await _firebaseSource.updateNameOrPhone(name, phoneNumber);
  }

  Future<void> updateAbout(String about) async {
    return await _firebaseSource.updateAbout(about);
  }

  Future<bool> isUserAlreadyExist() async {
    return await _firebaseSource.isUserAlreadyExist();
  }
}
