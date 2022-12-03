import 'dart:convert';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

class LocalPreference {
  final _sharedPreferences = RxSharedPreferences.getInstance();

  Stream<void> setUserToPreference(UserReqResModel userModel) {
    return Stream.fromFuture(
      _sharedPreferences.setString(
        Collection.userPreferenceKey,
        jsonEncode(userModel),
      ),
    );
  }

  Stream<UserReqResModel> getUserFromPreference() {
    return _sharedPreferences.getStringStream(Collection.userPreferenceKey).map(
      (event) {
        return UserReqResModel.fromJson(
          jsonDecode(event!),
        );
      },
    );
  }
}
