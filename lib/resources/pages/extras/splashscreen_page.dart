import 'package:uas_aris/config/const_vars.dart';
import 'package:uas_aris/resources/pages/auth/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import '/resources/widgets/logo_widget.dart';
import '/bootstrap/helpers.dart';

class SplashscreenPage extends NyStatefulWidget {
  static const path = '/splashscreen';

  SplashscreenPage({super.key}) : super(path, child: () => _SplashscreenPageState());
}

class _SplashscreenPageState extends NyState<SplashscreenPage> {

  @override
  init() async {
    super.init();

    Future.delayed(Duration.zero,() async {

      await getPackageInfo();
      
      Future.delayed(Duration(seconds: 2), (){
        nextPage();
      });

    });

  }

  void nextPage() async {

    routeTo(LoginPage.path, navigationType: NavigationType.popAndPushNamed);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorUtama.withOpacity(0.5),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Opacity(
                  opacity: 0.5,
                  child: Image.asset("image_02.png").localAsset(),
                )
              ],
            ),

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: Logo(),
                  ),
                  SizedBox(height: 150),
                  SpinKitCubeGrid(
                    size: 40.sp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            
          ],
        )
      ),
    );
  }

}