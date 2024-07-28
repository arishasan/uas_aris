import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    required this.label,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12.0),
        ),
        backgroundColor: WidgetStateProperty.all(color),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16.sp),
      ),
    );
  }
}
