import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);

  nylo.addNavigatorObserver(FlutterSmartDialog.observer);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  await ScreenUtil.ensureScreenSize();

  runApp(
    AppBuild(
      navigatorKey: NyNavigator.instance.router.navigatorKey,
      onGenerateRoute: nylo.router!.generator(),
      navigatorObservers: nylo.getNavigatorObservers(),
      debugShowCheckedModeBanner: false,
      initialRoute: nylo.getInitialRoute(),
      builder: FlutterSmartDialog.init(),
      themeMode: ThemeMode.light,
    ),
  );
}
