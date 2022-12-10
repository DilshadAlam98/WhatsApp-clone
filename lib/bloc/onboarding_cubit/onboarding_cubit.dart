import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/image_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/model/country_model.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';
import 'package:whatsapp_clone/repository/firebase_repo.dart';
import 'package:whatsapp_clone/utils/dialog_utils.dart';
import 'package:whatsapp_clone/utils/local_preference.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState()) {
    getCountries();
    getUserFromPreference();
  }
  final _firebaseRepo = FirebaseRepo();
  final _currentUserUid = FirebaseAuth.instance.currentUser?.uid;
  final _localPreference = LocalPreference();

  void getCountries() async {
    emit(state.copyWith(networkState: NetworkState.loading));

    try {
      final country = await _firebaseRepo.getCountries();
      final assetImage = await getImageFileFromAssets(ImageConstant.person);
      if (country.countryIso.isNotEmpty) {
        emit(state.copyWith(
          countryIsoList: country,
          buttonController: RoundedLoadingButtonController(),
          pickedImage: assetImage,
          networkState: NetworkState.completed,
          errorResponse: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        countryIsoList: null,
        errorResponse: e,
        networkState: NetworkState.error,
      ));
    }
  }

  void onCountryChange(CountryIso? changedCountry) {
    emit(state.copyWith(country: changedCountry, countryCode: changedCountry));
  }

  void onCountryCodeChange(CountryIso? countryCode) {
    emit(state.copyWith(countryCode: countryCode));
  }

  String? validateCountryName(CountryIso? value) {
    if (value?.name == null) {
      return "Please select country name";
    }
    return null;
  }

  String? validateCountryCode(CountryIso? value) {
    if (value?.code == null) {
      return "Please select country code";
    }
    return null;
  }

  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone number is required";
    }
    if (phone.length != 10) {
      return "Phone number should be 10 digit";
    }
    if (canSubmit(phone)) {
      return "Can't use special character";
    }
    return null;
  }

  bool canSubmit(String value) {
    if (value.contains(',') || value.contains(".") || value.contains("/")) {
      return true;
    }
    return false;
  }

  String? validateForm(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is Required";
    }

    return null;
  }

  String? validateOtp(String? otp) {
    if (otp == null || otp.isEmpty) {
      return "Please enter OTP";
    }
    if (otp.length != 6) {
      return "Please enter 6 digit OTP";
    }
    return null;
  }

  void verifyYourNumber(String phoneNumber, BuildContext context) async {
    final number = state.countryCode!.code! + phoneNumber;
    emit(state.copyWith(
      buttonController: state.buttonController?..start(),
      isOtpSent: false,
      whatsAppNumber: phoneNumber,
      errorResponse: null,
    ));
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (error) async {
          emit(state.copyWith(
              buttonController: state.buttonController?..reset(),
              isOtpSent: false,
              errorResponse: null,
              verificationId: null));
          DialogUtils.showInSnackBar(
            context: context,
            msg: "Something went wrong, please try later",
          );
        },
        codeSent: (verificationId, forceResendingToken) async {
          emit(state.copyWith(
              buttonController: state.buttonController?..reset(),
              isOtpSent: true,
              errorResponse: null,
              verificationId: verificationId));
          DialogUtils.showToast(
            msg: "OTP Sent you Successfully",
          );
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } catch (e) {
      emit(state.copyWith(
          buttonController: state.buttonController?..reset(),
          isOtpSent: false,
          errorResponse: null,
          verificationId: null));
      DialogUtils.showInSnackBar(
        context: context,
        msg: "Error occurred, please try later",
      );
    }
  }

  void verifyYourOTP(String otp, BuildContext context) async {
    emit(state.copyWith(
      buttonController: state.buttonController?..start(),
      errorResponse: null,
      verificationId: null,
    ));
    final _credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!, smsCode: otp);

    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(_credential);
      final isUserAlreadyExist = await _firebaseRepo.isUserAlreadyExist();
      if (authCredential.user != null) {
        switch (isUserAlreadyExist) {
          case true:
            Navigator.pushReplacementNamed(
              context,
              RouteConstant.mobileScreen,
            );
            break;
          default:
            Navigator.pushReplacementNamed(
              context,
              RouteConstant.registerYourSelf,
            );
            break;
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      DialogUtils.showInSnackBar(
        context: context,
        msg: e.message,
      );
      emit(
        state.copyWith(
          buttonController: state.buttonController?..reset(),
          verificationId: null,
          errorResponse: e,
        ),
      );
    }
  }

  void createUser(BuildContext context, String about, String name) async {
    emit(state.copyWith(
      buttonController: state.buttonController?..start(),
    ));
    final imageUrl = await _firebaseRepo.getImageUrl(state.pickedImage!);
    var userReq = UserReqResModel(
      about: about,
      country: state.country?.name,
      createdAt: Timestamp.now(),
      name: name,
      uid: _currentUserUid,
      whatsappNumber: state.whatsAppNumber,
      profilePic: imageUrl,
    );
    final isUserCreated = await _firebaseRepo.createUser(userReq);
    if (isUserCreated) {
      await Navigator.pushReplacementNamed(
        context,
        RouteConstant.mobileScreen,
      );
    }
    emit(state.copyWith(buttonController: state.buttonController?..reset()));
  }

  Future<void> pickProfilePicture(ImageSource imageSource) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      emit(state.copyWith(pickedImage: pickedImage));
    }
  }

  Future<XFile> getImageFileFromAssets(String path) async {
    File? files;
    try {
      final byteData = await rootBundle.load(path);
      final file = await File('${(await getTemporaryDirectory()).path}/$path')
          .create(recursive: true);
      files = await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    } catch (e) {
      debugPrint(e.toString());
    }
    return XFile(files!.path);
  }

  void getUserFromPreference() {
    emit(state.copyWith(networkState: NetworkState.loading));
    _localPreference.getUserFromPreference().listen((uid) {
      emit(state.copyWith(networkState: NetworkState.completed, uid: uid));
    });
  }
}
