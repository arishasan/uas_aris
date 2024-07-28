import 'package:uas_aris/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    this.icon,
    this.obscureText = false,
    required this.keyboardType,
    required this.onChanged,
    this.withPadding = true,
    this.ctr,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final bool withPadding;
  final TextEditingController? ctr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: withPadding ? const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0) : EdgeInsets.only(),
      child: TextField(
        cursorColor: Colors.black54,
        controller: ctr ?? null,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18.0),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: icon == null ? null : Icon(
            icon,
            size: 23.sp,
            color: Colors.black54,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: colorGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: colorUtama),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
