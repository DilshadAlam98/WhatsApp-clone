import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          const SizedBox(height: 15),
          _changeProfilePicSection(context),
          const SizedBox(height: 10),
          _listTileSection(
            leading: Icons.person,
            trailing: Icons.edit,
            title: "Name",
            subtitle: "Dilshad Alam",
            callback: () => _openBottomSheet(context: context),
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
            subtitle: "Alhamdulillah for everything",
            callback: () {},
          ),
          _listTileSection(
            leading: Icons.call,
            trailing: Icons.edit,
            title: "Phone",
            subtitle: "958802XXX9",
            callback: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _openBottomSheet({
    required BuildContext context,
    bool isChangeProfile = false,
  }) async {
    return await showModalBottomSheet(
      context: context,
      elevation: 10,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    ),
                    const SizedBox(width: 25),
                    _chooseProfileFromSection(
                      chooseFrom: "Gallery",
                      icon: Icons.photo_album_rounded,
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      enableIMEPersonalizedLearning: true,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
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
                    onPressed: () => Navigator.pop(context),
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
  }) {
    return Column(
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

  Widget _changeProfilePicSection(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 65,
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
