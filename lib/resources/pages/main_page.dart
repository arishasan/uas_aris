import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:uas_aris/app/models/keranjang.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:uas_aris/resources/pages/auth/login_page.dart';
import 'package:uas_aris/resources/pages/parts/history_keranjang_page.dart';
import 'package:uas_aris/resources/pages/parts/produk_page.dart';
import 'package:uas_aris/resources/pages/parts/keranjang_belanja_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends NyStatefulWidget {
  static const path = '/main';

  MainScreenPage({super.key}) : super(path, child: () => _MainScreenPageState());
}

class _MainScreenPageState extends NyState<MainScreenPage> {

  Widget content = Column();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  changeScreen(){

    if(globalScreen == 'PRODUK'){
      content = ProdukSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else if(globalScreen == 'KERANJANG_BELANJA'){
      content = KeranjangBelanjaSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else if(globalScreen == 'HISTORY_KERANJANG'){
      content = HistoryKeranjangSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else{
      content = Column();
    }

  }

  @override
  init() async {
    super.init();
    changeScreen();
  }

  refresh(){
    setState(() { });
  }

  moveScreen(){
    changeScreen();
  }

  moveScreenCustomize(){
    setState(() { });
    changeScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Icon(Icons.menu, color: Colors.black54,),
              onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
              },
            ),
            Text(
              globalScreen.replaceAll("_", " "),
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                color: colorUtama,
                fontSize: 18.sp,
                fontWeight: FontWeight.w300
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: colorUtama,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            SizedBox(
              height: 130.h,
              child: DrawerHeader(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          getImageAsset("logo.png"),
                          width: 50.sp,
                        ),
                      ),

                      SizedBox(width: 20,),

                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "meStore",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "E-Commerce",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w300
                              ),
                            )

                          ],
                        )
                      )

                    ],
                  ),
                ),
              )
            ),

            SizedBox(height: 5,),

            ListTile(
              tileColor: globalScreen == 'PRODUK' ? Colors.white : colorUtama,
              onTap: (){

                setState((){
                  globalScreen = 'PRODUK';
                });
                _scaffoldKey.currentState!.closeDrawer();
                changeScreen();

              },
              leading: Icon(Icons.home_rounded, color: globalScreen == 'PRODUK' ? colorUtama : Colors.white, size: 30.sp),
              title: Text(
                "Daftar Produk",
                style: GoogleFonts.poppins(
                  color: globalScreen == 'PRODUK' ? colorUtama : Colors.white,
                  fontSize: 15.sp
                ),
              ),
            ),

            ListTile(
              tileColor: globalScreen == 'KERANJANG_BELANJA' ? Colors.white : colorUtama,
              onTap: (){

                setState((){
                  globalScreen = 'KERANJANG_BELANJA';
                });
                _scaffoldKey.currentState!.closeDrawer();
                changeScreen();

              },
              leading: Icon(Icons.shopping_cart_outlined, color: globalScreen == 'KERANJANG_BELANJA' ? colorUtama : Colors.white, size: 30.sp),
              trailing: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Text(
                globalKeranjang.length.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15.sp
                ))
              ),
              title: Text(
                "Keranjang Belanja",
                style: GoogleFonts.poppins(
                  color: globalScreen == 'KERANJANG_BELANJA' ? colorUtama : Colors.white,
                  fontSize: 15.sp
                ),
              ),
            ),

            ListTile(
              tileColor: globalScreen == 'HISTORY_KERANJANG' ? Colors.white : colorUtama,
              onTap: (){

                setState((){
                  globalScreen = 'HISTORY_KERANJANG';
                });
                _scaffoldKey.currentState!.closeDrawer();
                changeScreen();

              },
              leading: Icon(Icons.history, color: globalScreen == 'HISTORY_KERANJANG' ? colorUtama : Colors.white, size: 30.sp),
              title: Text(
                "History Keranjang Belanja",
                style: GoogleFonts.poppins(
                  color: globalScreen == 'HISTORY_KERANJANG' ? colorUtama : Colors.white,
                  fontSize: 15.sp
                ),
              ),
            ),

            Divider(),
            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          globalNamaUser,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp
                          ),
                        ),
                        Text(
                          globalEmailUser,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 13.sp
                          ),
                        )
                      ],
                    )
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25.0,
                      backgroundImage: AssetImage(getImageAsset("user.png")),
                    ),
                    onTap: () {},
                  )

                ],
              ),
            ),

            SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
                routeTo(LoginPage.path, navigationType: NavigationType.popAndPushNamed);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        color: colorUtama,
                      ),
                    ),
                    Icon(Icons.logout, color: colorUtama,)
                  ],
                )
              ),
            )

          ],
        )
      ),
      body: DoubleBackToCloseApp(snackBar: SnackBar(content: Text("Tekan kembali sekali lagi untuk menutup aplikasi.", style: GoogleFonts.poppins(),)), 
        child: Container(
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
                    opacity: 1,
                    child: Image.asset("image_02.png").localAsset(),
                  )
                ],
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    //   child: Container(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Flexible(
                    //           child: Text(
                    //             'SISTEM MONITORING PENGADAAN UO MABES TNI',
                    //             textAlign: TextAlign.left,
                    //             style: GoogleFonts.poppins(
                    //               color: colorUtama,
                    //               fontSize: 15.sp,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 10,),
                    //         Container(
                    //           padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    //           decoration: BoxDecoration(
                    //             color: colorUtama,
                    //             borderRadius: BorderRadius.all(Radius.circular(10))
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Text("23", style: GoogleFonts.poppins(
                    //                 color: Colors.white,
                    //                 fontSize: 15.sp,
                    //                 fontWeight: FontWeight.bold
                    //               ),),
                    //               Text("Juni", style: GoogleFonts.poppins(
                    //                 color: Colors.white,
                    //                 fontSize: 10.sp
                    //               ),),
                    //               Text("2024", style: GoogleFonts.poppins(
                    //                 color: Colors.white,
                    //                 fontSize: 10.sp
                    //               ),),
                    //             ],
                    //           )
                    //         )

                    //       ],
                    //     ),
                    //   )
                    // ),
                    
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        child: content
                      )
                    )

                  ],
                )
              )
              
            ],
          )
        ),
      )
    );
  }

}