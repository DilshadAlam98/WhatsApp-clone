import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

class LocalPreference {
  final prefManager = SharedPreferenceManager();

  Stream<void> setUserToPreference(UserReqResModel user) {
    return prefManager.setString(
        key: CollectionKeys.userPreferenceKey, value: user.uid!);
  }

  Stream<String?> getUserFromPreference() {
    return prefManager.getString(key: CollectionKeys.userPreferenceKey);
  }
  // Stream<void> setUserToPreference(UserReqResModel user) {
  //   return prefManager.setString(
  //       key: CollectionKeys.userPreferenceKey, value: jsonEncode(user));
  // }

  // Stream<UserReqResModel> getUserFromPreference() {
  //   return prefManager
  //       .getString(key: CollectionKeys.userPreferenceKey)
  //       .map((event) {
  //     return UserReqResModel.fromJson(jsonDecode(event!));
  //   });
  // }
}

class SharedPreferenceManager {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  static const _debug = true;

  /// get String from shared preferences
  Stream<String?> getString({required String key}) {
    return _getSharedPreference()
        .map((preference) => preference.getString(key));
  }

  /// set String to shared preferences
  Stream<bool> setString({required String key, required String value}) {
    if (_debug && kDebugMode) {
      if (kDebugMode) {
        print('Writing key: $key value: $value');
      }
    }
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setString(key, value)));
  }

  /// get String List from shared preferences
  Stream<List<String>?> getStringList({required String key}) {
    if (_debug) {
      if (kDebugMode) {
        print('Reading key: $key value: $key');
      }
    }
    return _getSharedPreference()
        .map((preference) => preference.getStringList(key));
  }

  /// set String list from shared preferences
  Stream<bool> setStringList(
      {required String key, required List<String> value}) {
    if (_debug) {
      if (kDebugMode) {
        print('Writing key: $key value: $value');
      }
    }
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setStringList(key, value)));
  }

  /// Clear Shared Preferences
  Stream<bool> clearPreference() {
    return _getSharedPreference()
        .flatMap((preference) => _convertToRx(preference.clear()));
  }

  Stream<SharedPreferences> _getSharedPreference() {
    return _convertToRx(_sharedPreferences);
  }

  Stream<T> _convertToRx<T>(Future<T> future) {
    return Stream.fromFuture(future);
  }
}
