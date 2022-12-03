import 'package:cloud_firestore/cloud_firestore.dart';

class UserReqResModel {
  String? country;
  String? whatsappNumber;
  String? name;
  String? about;
  String? profilePic;
  String? uid;
  Timestamp? createdAt;

  UserReqResModel({
    this.country,
    this.whatsappNumber,
    this.name,
    this.about,
    this.profilePic,
    this.uid,
    this.createdAt,
  });

  UserReqResModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    whatsappNumber = json['whatsapp_Number'];
    name = json['name'];
    about = json['about'];
    profilePic = json['profile_pic'];
    uid = json['uid'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['whatsapp_Number'] = whatsappNumber;
    data['name'] = name;
    data['about'] = about;
    data['profile_pic'] = profilePic;
    data['uid'] = uid;
    data['created_at'] = createdAt;
    return data;
  }
}
