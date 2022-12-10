import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/profile_cubit/profile_cubit.dart';
import 'package:whatsapp_clone/constant/app_constant.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class AboutYourThoughts extends StatelessWidget {
  AboutYourThoughts({Key? key, required this.about}) : super(key: key);
  final String about;
  String? newAbout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text(
          "About",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            children: [
              const Text(
                "Current set to",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  final willPop =
                      await _openBottomSheet(context: context, about: about);
                  if (willPop) {
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      about,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Icon(
                      Icons.edit,
                      color: tabColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Select About",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: aboutList
                    .map(
                      (e) => InkWell(
                        onTap: () => context
                            .read<ProfileCubit>()
                            .updateAbout(e)
                            .then((value) => Navigator.pop(context)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          width: double.infinity,
                          child: Text(
                            e,
                            style: const TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          );
        },
      ),
    );
  }

  Future<bool> _openBottomSheet({
    required BuildContext context,
    required String about,
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
                'Customize you about',
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
                      initialValue: about,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      ),
                      onChanged: (value) => newAbout = value,
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
                    onPressed: () {
                      context
                          .read<ProfileCubit>()
                          .updateAbout(newAbout!)
                          .then((value) {
                        Navigator.of(context).pop(true);
                      });
                    },
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
}
