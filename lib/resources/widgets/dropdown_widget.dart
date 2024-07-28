import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    Key? key,
    required this.data,
    required this.selectedData,
    required this.returnState,
    required this.widthnya,
    required this.hint,
    required this.shrink,
    required this.isBgUtama,
    required this.buttonHeight
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String? selectedData;
  final Function returnState;
  final double widthnya;
  final String hint;
  final bool shrink;
  final bool isBgUtama;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthnya,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isBgUtama ? Colors.white : Colors.transparent,
        border: Border.all(color: isBgUtama ? Colors.white : Colors.black54),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              // fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              // fontWeight: FontWeight.w500,
            ),
          ),
          items: data.map((key, value){
            return MapEntry(key, 
              DropdownMenuItem(
                value: key,
                child: Text(
                  value,
                  overflow: shrink ? TextOverflow.ellipsis : null,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    // fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              )
            );
          }).values.toList(),
          value: selectedData,
          onChanged: (value) {
            // state(() {
            //   selectedData = value!;
            // });
            returnState(value!);
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: buttonHeight,
            width: 200,
          ),
          // dropdownStyleData: DropdownStyleData(
          //   maxHeight: 200,
          // ),
          menuItemStyleData: MenuItemStyleData(
            height: buttonHeight,
          ),
        ),
      ),
    );
  }
}
