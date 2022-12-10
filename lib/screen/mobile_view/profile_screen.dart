import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_cubit.dart';
import 'package:whatsapp_clone/bloc/mobile_cubit/mobile_state.dart';
import 'package:whatsapp_clone/bloc/profile_cubit/profile_cubit.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';
import 'package:whatsapp_clone/constant/route_constant.dart';
import 'package:whatsapp_clone/model/user_res_req_model.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  String? name;
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<MobileCubit, MobileCubitState>(
        builder: (context, mobileState) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              return Stack(
                children: [
                  if (profileState.networkState == NetworkState.loading ||
                      mobileState.networkState == NetworkState.loading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ListView(
                    children: [
                      const SizedBox(height: 15),
                      _changeProfilePicSection(context, mobileState.user!),
                      const SizedBox(height: 10),
                      _listTileSection(
                        leading: Icons.person,
                        trailing: Icons.edit,
                        title: "Name",
                        subtitle: mobileState.user!.name!,
                        callback: () async => await _openBottomSheet(
                          context: context,
                          name: mobileState.user!.name,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 60.0),
                        child: Text(
                          "This is not your username or pin. This name will be visible to your WhatsApp contact",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      _listTileSection(
                        leading: Icons.error_outline_outlined,
                        trailing: Icons.edit,
                        title: "About",
                        subtitle: mobileState.user!.about!,
                        callback: () => Navigator.pushNamed(
                            context, RouteConstant.aboutPage,
                            arguments: {
                              "about": mobileState.user!.about!,
                            }),
                      ),
                      _listTileSection(
                        leading: Icons.call,
                        trailing: Icons.edit,
                        title: "Phone",
                        subtitle: mobileState.user!.whatsappNumber!,
                        callback: () async => await _openBottomSheet(
                          context: context,
                          mobileNumber: mobileState.user!.whatsappNumber,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openBottomSheet({
    required BuildContext context,
    String? name,
    String? mobileNumber,
    bool isChangeProfile = false,
  }) async {
    return await showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      backgroundColor: appBarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        if (isChangeProfile) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile Photo",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _chooseProfileFromSection(
                      chooseFrom: "Camera",
                      icon: Icons.camera_alt_outlined,
                      callback: () => context
                          .read<ProfileCubit>()
                          .pickProfilePicture(ImageSource.camera)
                          .then(
                            (value) => Navigator.pop(context),
                          ),
                    ),
                    const SizedBox(width: 25),
                    _chooseProfileFromSection(
                      chooseFrom: "Gallery",
                      icon: Icons.photo_album_rounded,
                      callback: () => context
                          .read<ProfileCubit>()
                          .pickProfilePicture(ImageSource.gallery)
                          .then(
                            (value) => Navigator.pop(context),
                          ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Enter your name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      initialValue: name ?? mobileNumber,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      ),
                      onChanged: (value) {
                        if (name == null) {
                          phoneNumber = value;
                        } else {
                          name = value;
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => context
                        .read<ProfileCubit>()
                        .updateNameOrPhone(name: name, phoneNumber: phoneNumber)
                        .then(
                          (value) => Navigator.pop(context),
                        ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _chooseProfileFromSection({
    required IconData icon,
    required String chooseFrom,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: tabColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            chooseFrom,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 1.2,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _listTileSection({
    required IconData leading,
    IconData? trailing,
    required String title,
    required String subtitle,
    required VoidCallback callback,
  }) {
    return ListTile(
      onTap: callback,
      minLeadingWidth: 25,
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          leading,
          color: Colors.grey,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.8,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
        ),
      ),
      trailing: Icon(
        trailing,
        color: tabColor,
      ),
    );
  }

  Widget _changeProfilePicSection(BuildContext context, UserReqResModel user) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 65,
            backgroundColor: messageColor,
            backgroundImage: NetworkImage(
              user.profilePic!,
            ),
          ),
        ),
        Positioned(
          bottom: 3,
          right: MediaQuery.of(context).size.width * 0.34,
          child: GestureDetector(
            onTap: () async => await _openBottomSheet(
              context: context,
              isChangeProfile: true,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: tabColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
