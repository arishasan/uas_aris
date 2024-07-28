import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:uas_aris/app/models/global.dart';
import 'package:uas_aris/app/models/keranjang.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:uas_aris/app/networking/api_service.dart';
import 'package:uas_aris/bootstrap/helpers.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:uas_aris/resources/widgets/item_keranjang_widget.dart';

class KeranjangBelanjaSection extends NyStatefulWidget {
  final Function notifyParent;
  final Function moveScreen;

  static const path = '/section-keranjang-belanja';

  KeranjangBelanjaSection({super.key, required this.notifyParent, required this.moveScreen}) : super(path, child: () => _KeranjangBelanjaSectionState());
}

class _KeranjangBelanjaSectionState extends NyState<KeranjangBelanjaSection> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  init() async {
    super.init();
    _loadPengadaan();
  }

  void _loadPengadaan() async {

  }
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void deleteFunc() async {

    globalKeranjang.removeWhere((element) => element.idproduk == globalSelectedItemIDX);
    setState((){

    });
    widget.notifyParent();

  }

  Future<void> saveKeranjang() async {

    NAlertDialog(
    backgroundColor: Colors.white,
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text(
    'Perhatian',
    style: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 15.sp,
    )),
    dismissable: false,
    content: Text(
      'Apakah anda yakin akan menyimpan data keranjang belanja ini?',
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 15.sp,
      )
    ),
    actions: <Widget>[
      TextButton(child: Text("Ya",
        style: GoogleFonts.poppins(
          color: colorUtama,
          fontSize: 15.sp,
        ),
      ), onPressed: () async {
        
        Navigator.pop(context);

        if(globalKeranjang.length <= 0){
          showToastOops(description: "Anda belum menambahkan produk kedalam keranjang.");
          return;
        }

        ProgressDialog pdialog = showLoading(context);
        pdialog.show();

        Map<String, dynamic> dataProduct = {};

        globalKeranjang.forEach((element) {
          
          dataProduct.addAll({
            "productId" : element.idproduk,
            "quantity" : element.qty
          });

        });

        Map<String, dynamic> formData = {};
        formData = {
          "userId" : globalIDUser,
          "date" : DateTime.now().toFormat("yyyy-MM-dd"),
          "products" : jsonEncode(dataProduct),
        };

        List<Notif> dataKategori = await ApiService().methodPOST(formData, "/carts");
        pdialog.dismiss();

        showToastSuccess(description: "Berhasil menyimpan data keranjang.");

        globalKeranjang.clear();
        setState((){

        });
        widget.notifyParent();


      }),
      TextButton(child: Text("Tidak",
        style: GoogleFonts.poppins(
          color: Colors.red,
          fontSize: 15.sp,
        ),
      ), onPressed: () async {
        Navigator.pop(context);
      }),
    ],
  ).show(context);

  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Flexible(
                child: Text("Kosongkan keranjang belanja?", style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w300
                ),),
              ),

              InkWell(
                onTap: (){
                  globalKeranjang.clear();
                  setState((){

                  });
                  widget.notifyParent();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text("CLEAR", style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),),
                ),
              )
              
            ],
          ),
        ),

        Expanded(
          child: Container(
            child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropHeader(
                waterDropColor: Colors.black54,
                refresh: SpinKitCircle(
                  color: Colors.black54,
                ),
              ),
              
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("pull up load", style: GoogleFonts.poppins(color: Colors.black54),);
                  }
                  else if(mode==LoadStatus.loading){
                    body =  SpinKitPulsingGrid(
                      color: Colors.black54,
                    );
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("Load Failed!Click retry!", style: GoogleFonts.poppins(color: Colors.black54),);
                  }
                  else if(mode == LoadStatus.canLoading){
                      body = Text("release to load more", style: GoogleFonts.poppins(color: Colors.black54),);
                  }
                  else{
                    body = Text("No more Data", style: GoogleFonts.poppins(color: Colors.black54),);
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  return ItemKeranjangWidget(index: i, deleteFunc: deleteFunc,);
                },
                // itemExtent: 100.0,
                itemCount: globalKeranjang.length,
              ),
            )
          )
        ),

        Container(
          width: 1.sw,
          child: InkWell(
            onTap: () async {
              
              await saveKeranjang();

            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorUtama,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("SIMPAN KERANJANG BELANJA", style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),),

                  Icon(Icons.save, color: Colors.white,)

                ],
              ),
            ),
          )
        ),

        SizedBox(height: 20,)

      ],
    );
  }

}