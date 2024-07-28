import 'package:ndialog/ndialog.dart';
import 'package:uas_aris/app/models/global.dart';
import 'package:uas_aris/app/models/keranjang.dart';
import 'package:uas_aris/app/networking/api_service.dart';
import 'package:uas_aris/bootstrap/helpers.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:uas_aris/resources/widgets/accordion_history.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HistoryKeranjangSection extends NyStatefulWidget {
  final Function notifyParent;
  final Function moveScreen;

  static const path = '/section-history-keranjang';

  HistoryKeranjangSection({super.key, required this.notifyParent, required this.moveScreen}) : super(path, child: () => _HistoryKeranjangSectionState());
}

class _HistoryKeranjangSectionState extends NyState<HistoryKeranjangSection> {

  RefreshController _refreshControllerTwo =
      RefreshController(initialRefresh: false);

  bool isFilterOpen = true;

  String rangePeriode = "";

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  String firstDate = "";
  String endDate = "";

  @override
  init() async {
    super.init();
    _loadHistory();
  }

  Future<void> _loadHistory() async {

    ProgressDialog pdialog = showLoading(context);
    pdialog.show();

    String url = "/carts/user/"+globalIDUser.toString()+"?startdate="+firstDate+"&enddate="+endDate;
    print(url);
    List<Notif> dataKategori = await ApiService().methodGET(url);
    pdialog.dismiss();

    globalHistoryKeranjang.clear();
  
    if(dataKategori.first.error){}else{

      if(dataKategori.first.data.toString() == "[]"){
        return;
      }

      // Map<String, dynamic> data = dataKategori.first.data;
      List<dynamic> data = dataKategori.first.data;
      data.forEach((value) {
        // print(value);
        globalHistoryKeranjang.add(HistoryKeranjang(id: value['id'], user: value['userId'], date: DateTime.parse(value['date']), products: value['products']));
      });

    }

    setState((){

    });

  }
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshControllerTwo.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshControllerTwo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: (){
            setState((){
              isFilterOpen = isFilterOpen ? false : true;
            });
          },
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isFilterOpen ? colorUtama : Colors.white,
              border: Border.all(color: colorUtama),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Icon(Icons.filter_alt_rounded, color: isFilterOpen ? Colors.white : colorUtama, size: 20.sp,),
                          SizedBox(width: 5,),
                          Text("Filter", style: GoogleFonts.poppins(color: isFilterOpen ? Colors.white : colorUtama, fontSize: 15.sp))
                        ],
                      ),
                    ),
                    Icon(isFilterOpen ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, color: isFilterOpen ? Colors.white : colorUtama, size: 20.sp)
                  ],
                ),

                isFilterOpen ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),

                    Row(
                      children: [

                        Flexible(
                          child: InkWell(
                            onTap: () async {

                              DateTimeRange? newDateRange = await showDateRangePicker(
                                context: context,
                                initialDateRange: dateRange,
                                firstDate: DateTime(2019),
                                lastDate: DateTime(2100),
                              );
                              setState(() {
                                dateRange = newDateRange ?? dateRange;
                                firstDate = dateRange.start.toFormat("yyyy-MM-dd").toString();
                                endDate = dateRange.end.toFormat("yyyy-MM-dd").toString();
                                rangePeriode = firstDate + ' s.d ' + endDate;
                              });
                              
                            },
                            child: Container(
                              width: 1.sw,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.white),
                                color: colorUtama
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.date_range, size: 20.sp, color: Colors.white,),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Text(
                                      rangePeriode == "" ? 'Tentukan Periode' : rangePeriode,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        InkWell(
                          onTap: () async {

                            if(rangePeriode == ""){
                              showToastOops(description: "Anda belum menentukan filter tanggal.");
                              return;
                            }

                            await _loadHistory();
                            
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                            ),
                            child: Icon(Icons.search, color: colorUtama, size: 20.sp,)
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10,),
                  ],
                ) : SizedBox.shrink()

              ],
            ),
          ),
        ),

        SizedBox(height: 10,),

        Flexible(
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
              controller: _refreshControllerTwo,
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  return AccordionHistory(index: i);
                },
                // itemExtent: 100.0,
                itemCount: globalHistoryKeranjang.length,
              ),
            )
          )
        )

      ],
    );
  }

}