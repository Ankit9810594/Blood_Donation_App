import 'package:flutter/material.dart';
import 'colors.dart';

class Constant {
  static String imageUrl = "http://10.0.2.2:3000/";
  static InputDecoration textFormFieldDecoration(
      String label, String text, IconData icon) {
    return InputDecoration(
        prefixIcon: Icon(icon),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        hintText: text,
        filled: true,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        fillColor: MyColor.backgroundColor);
  }

  static Widget authButton(String title, void Function()? onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: MyColor.redColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: Text(title)),
    );
  }

  static Widget customRow(void Function()? onTap, String text1, String text2) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text1),
        InkWell(
          onTap: onTap,
          child: Text(
            text2,
            style: const TextStyle(
                color: MyColor.redColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  static moveToNext(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static moveToNextUntil(BuildContext context, Widget widget) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }

  static InputDecoration dropDownDecoration() {
    return InputDecoration(
        hintStyle: const TextStyle(fontSize: 12),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: MyColor.backgroundColor,
        filled: true);
  }
}

class Validator {
  static String? isRequired(String? input) {
    if (input!.isEmpty) {
      return "This field is required";
    }
  }

  static String? validNumber(String? input) {
    if (input!.isEmpty) {
      return "This field is required";
    } else if (input.length != 10) {
      return "Invalid number";
    }
  }

  static String? validEmail(String? input) {
    if (input!.isEmpty) {
      return "Email is required";
    } else if (!input.contains('@')) {
      return "Invalid email";
    }
  }

  static String? validPassword(String? input) {
    if (input!.isEmpty) {
      return "password is required";
    } else if (input.length < 7) {
      return "should be 6 digit long";
    }
  }
}
