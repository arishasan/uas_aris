import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ndialog/ndialog.dart';
import 'package:uas_aris/app/models/global.dart';
import 'package:uas_aris/app/networking/api_service.dart';
import 'package:uas_aris/bootstrap/helpers.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:uas_aris/resources/pages/main_page.dart';
import 'package:uas_aris/resources/widgets/curve_widget.dart';
import 'package:uas_aris/resources/widgets/custom_button_widget.dart';
import 'package:uas_aris/resources/widgets/custom_textfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';

class LoginPage extends NyStatefulWidget {
  static const path = '/login';

  LoginPage({super.key}) : super(path, child: () => _LoginPageState());
}

class _LoginPageState extends NyState<LoginPage> {

  String username = '';
  String password = '';
  bool showPass = false;
  TextEditingController uname = new TextEditingController(text: "mor_2314");
  TextEditingController pswd = new TextEditingController(text: "83r5^_");

  @override
  init() async {
    super.init();

  }

  Future<void> doLogin() async {

    FocusManager.instance.primaryFocus?.unfocus();

    if(uname.text.length == 0 || pswd.text.length == 0){
      showToastOops(description: "Username dan Password wajib diisi.");
      return;
    }

    ProgressDialog pdialog = showLoading(context);
    pdialog.show();

    Map<String, dynamic> formData;
    formData = {
      "username" : uname.text,
      "password" : pswd.text,
    };

    List<Notif> data = await ApiService().methodLogin(jsonEncode(formData));

    if(data.length > 0){

      pdialog.dismiss();

      print(data.first.data);
      print(data.first.message);

      if(data.first.error){
        showToastOops(description: data.first.message);
      }else{

        dynamic temp = data.first.data;
        // pdialog.dismiss();
        globalToken = temp;

        Map<String, dynamic> decodedToken = await JwtDecoder.decode(globalToken);

        globalIDUser = decodedToken['sub'];

        List<Notif> dataUser = await ApiService().methodGET("/users/" + globalIDUser.toString());

        if(dataUser.first.error){}else{

          Map<String, dynamic> nama = dataUser.first.data['name'];
          globalEmailUser = dataUser.first.data['email'];
          globalNamaUser = (nama['firstname'] ?? '') + ' ' + nama['lastname'] ?? '';

        }

        pdialog.dismiss();

        routeTo(MainScreenPage.path, navigationType: NavigationType.popAndPushNamed);

      }

    }else{
      pdialog.dismiss();
      showToastOops(description: msgErrorGlobal);
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          alignment: Alignment.bottomRight,
          fit: StackFit.expand,
          children: [
            // First Child in the stack

            ClipPath(
              clipper: ImageClipper(),
              child: Image.asset(
                getImageAsset("bg.jpg"),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                // height: 100.h,
              ),
            ),

            // Second Child in the stack
            Positioned(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.50,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First Column
                        
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Text(
                                    "meStore",
                                    style: GoogleFonts.poppins(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: colorUtama,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'E-Commerce',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  )

                                ],
                              ),
                              Text(
                                'Login untuk memulai',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                ),
                              )
                            ],
                          ),
                        ),

                        // Second Column
                        Column(
                          children: [
                            CustomTextField(
                              hintText: 'Username',
                              icon: Icons.person,
                              ctr: uname,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                username = value != '' ? value : '';
                              },
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              icon: Icons.lock,
                              ctr: pswd,
                              obscureText: showPass ? false : true,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {
                                password = value != '' ? value : '';
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: colorUtama,
                                    // fillColor: MaterialStateProperty.all(
                                    //     colorGrey),
                                    value: showPass,
                                    onChanged: (value) {
                                      setState(() {
                                        showPass = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Show Password',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Third Column
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AuthenticationButton(
                                label: 'Login',
                                color: colorUtama,
                                onPressed: () {
                                  doLogin();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

}