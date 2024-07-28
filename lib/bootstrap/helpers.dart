import 'dart:convert';

import 'package:uas_aris/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Helpers
|--------------------------------------------------------------------------
| Add your helper methods here
|-------------------------------------------------------------------------- */

/// helper to find correct color from the [context].
class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) =>
      nyColorStyle<ColorStyles>(context, themeId: themeId);

  static Color fromHex(String hexColor) => nyHexColor(hexColor);
}

ProgressDialog showLoading(context){
  return ProgressDialog(context,
  // backgroundColor: Colors.white,
  message: Text("Memuat...",
  style: GoogleFonts.poppins()),
  title: Text("Mohon Tunggu",
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: colorGrey
  )),
  defaultLoadingWidget: SpinKitCircle(color: colorUtama),
  dismissable: false);
}

Future<void> getPackageInfo() async {

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  globalBuildVersion = buildNumber;
  globalVersion = version;

}

String convertedDateTime(DateTime text){
  String getDateOnly = DateFormat('HH:mm:ss, dd/MMMM/yyyy').format(text);
  // List splitted = getDateOnly.split(",");
  
  return getDateOnly;
}

String convertedDate(DateTime text){
  String getDateOnly = DateFormat('dd/MM/yyyy').format(text);
  // List splitted = getDateOnly.split(",");
  
  return getDateOnly;
}

String convDatePOST(DateTime text){
  String getDateOnly = DateFormat('yyyy-MM-dd').format(text);
  // List splitted = getDateOnly.split(",");
  
  return getDateOnly;
}

String convDateTimePOST(DateTime text){
  String getDateOnly = DateFormat('yyyy-MM-dd HH:mm:ss').format(text);
  // List splitted = getDateOnly.split(",");
  
  return getDateOnly;
}

final formatTgl = new DateFormat('dd/MM/yyyy');
final formatTglDef = new DateFormat('yyyy-MM-dd');

String getBasicAuth() {
  var user = "ralind0";
  var pass = "KeratonMajapahit!236";
  var bytes = utf8.encode(user + ":" + pass);
  var base64encode = base64.encode(bytes);
  return base64encode;
}

getHariName(DateTime tgl){

  String getEnglishName = DateFormat('EEEE').format(tgl);
  getEnglishName = getEnglishName.toLowerCase();

  if(getEnglishName == 'sunday'){
    return 'Minggu';
  }else if(getEnglishName == 'monday'){
    return 'Senin';
  }else if(getEnglishName == 'tuesday'){
    return 'Selasa';
  }else if(getEnglishName == 'wednesday'){
    return 'Rabu';
  }else if(getEnglishName == 'thursday'){
    return 'Kamis';
  }else if(getEnglishName == 'friday'){
    return 'Jum`at';
  }else if(getEnglishName == 'saturday'){
    return 'Sabtu';
  }else{
    return '-';
  }

}

getBulanName(int bulan){

  if(bulan == 1){
    return 'Januari';
  }else if(bulan == 2){
    return 'Februari';
  }else if(bulan == 3){
    return 'Maret';
  }else if(bulan == 4){
    return 'April';
  }else if(bulan == 5){
    return 'Mei';
  }else if(bulan == 6){
    return 'Juni';
  }else if(bulan == 7){
    return 'Juli';
  }else if(bulan == 8){
    return 'Agustus';
  }else if(bulan == 9){
    return 'September';
  }else if(bulan == 10){
    return 'Oktober';
  }else if(bulan == 11){
    return 'November';
  }else if(bulan == 12){
    return 'Desember';
  }else{
    return '-';
  }

}

getDateIndo(DateTime tgl){

  String getDateOnly = DateFormat('dd-MM-yyyy').format(tgl);
  List splitted = getDateOnly.split("-");
  
  return splitted[0].toString() + " " + getBulanName(int.parse(splitted[1])) + " " + splitted[2].toString();

}

getDateIndoCutMonth(DateTime tgl){

  String getDateOnly = DateFormat('dd-MM-yyyy').format(tgl);
  List splitted = getDateOnly.split("-");
  
  return splitted[0].toString() + " " + getBulanName(int.parse(splitted[1]));

}

getDateIndoWaktu(DateTime tgl){

  String getDateOnly = DateFormat('dd-MM-yyyy,HH:mm:ss').format(tgl);
  List splitted = getDateOnly.split(",");
  
  return splitted[1];

}

getDateIndoLengkap(DateTime tgl){

  String getDateOnly = DateFormat('dd-MM-yyyy,HH:mm a').format(tgl);
  List splitted = getDateOnly.split(",");
  List splittedtwo = splitted[0].split("-");
  
  return splittedtwo[0].toString() + " " + getBulanName(int.parse(splittedtwo[1])) + " " + splittedtwo[2].toString() + ", " + splitted[1];

}

int getConvertedMonth(String bulanStr){
  int bulan;

  if(bulanStr.toLowerCase() == 'januari'){
    bulan = 1;
  }else if(bulanStr.toLowerCase() == 'februari'){
    bulan = 2;
  }else if(bulanStr.toLowerCase() == 'maret'){
    bulan = 3;
  }else if(bulanStr.toLowerCase() == 'april'){
    bulan = 4;
  }else if(bulanStr.toLowerCase() == 'mei'){
    bulan = 5;
  }else if(bulanStr.toLowerCase() == 'juni'){
    bulan = 6;
  }else if(bulanStr.toLowerCase() == 'juli'){
    bulan = 7;
  }else if(bulanStr.toLowerCase() == 'agustus'){
    bulan = 8;
  }else if(bulanStr.toLowerCase() == 'september'){
    bulan = 9;
  }else if(bulanStr.toLowerCase() == 'oktober'){
    bulan = 10;
  }else if(bulanStr.toLowerCase() == 'november'){
    bulan = 11;
  }else if(bulanStr.toLowerCase() == 'desember'){
    bulan = 12;
  }else{
    bulan = 1;
  }
  return bulan;
}

final formatCurrency = new NumberFormat("#,###,###,###", "en_US");