import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant/color_constant.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.maxLines,
  }) : super(key: key);

  final String hintText;
  final Function(String?) onChanged;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: searchBarColor,
        hintStyle: const TextStyle(fontSize: 14),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
