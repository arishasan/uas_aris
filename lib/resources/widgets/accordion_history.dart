import 'package:nylo_framework/nylo_framework.dart';
import 'package:uas_aris/app/models/keranjang.dart';
import 'package:uas_aris/bootstrap/helpers.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccordionHistory extends StatefulWidget {
  final int index;

  const AccordionHistory(
    {
      Key? key,
      required this.index
    }
  )
      : super(key: key);
  @override
  State<AccordionHistory> createState() => _AccordionHistoryState();
}

class _AccordionHistoryState extends State<AccordionHistory> {
  // Show or hide the content
  bool _showContent = false;

  Widget rowGen(tit, sub){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Flexible(
          child: Text(tit.toString(), 
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: Colors.black54,
          ),),
        ),
        
        SizedBox(width: 10,),

        Flexible(
          child: Text(sub.toString(), 
          textAlign: TextAlign.end,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: Colors.black54,
            fontWeight: FontWeight.bold
          ),),
        )

      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(children: [
        
        GestureDetector(
          onTap: (){
            // setState(() {
            //   _showContent = !_showContent;
            // });
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              // color: colorUtama,
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
                    
                    Icon(Icons.shelves, color: Colors.black.withOpacity(0.6), size: 25.sp,),
                    SizedBox(width: 20,),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getDateIndo(globalHistoryKeranjang[widget.index].date), style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w300
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(globalHistoryKeranjang[widget.index].products.length.toString() + " item", style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold
                      ),),
                    // Icon(_showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.black.withOpacity(0.6),)

                  ],
                ),

                // _showContent ? Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [

                //     Divider(),
                    
                //     rowGen("A. Bekal Makanan", ""),
                //     Padding(
                //       padding: EdgeInsets.only(left: 10, right: 0),
                //       child: Column(
                //         children: [

                //           Divider(),
                //           rowGen("Giat Yang Telah Dilaksanakan", "3 giat Pam Pemilu (Eprokal Plus, Naraga Plus, Pemanas Natura)"),
                //           Divider(),
                //           rowGen("Giat Yang Sedang Berjalan", "6 giat e-Purchasing Bekal Satgas TA 2024 (Eprokal, Pemanas Natura, Naraga Plus, C2BN, Konserven)"),
                //           Divider(),
                //           rowGen("Giat Yang Akan Datang", "Nihil"),
                //           Divider(),
                //           rowGen("Kewenangan Daerah", "9 giat telah diaksanakan, 1 giat yg akan dilaksanakan."),

                //         ],
                //       )
                //     ),
                //     Divider(),

                //     // rowGen("Jumlah Home Trip", widget.jmlHomeTrip.toString()),
                //     // Padding(
                //     //   padding: EdgeInsets.only(left: 20),
                //     //   child: Column(
                //     //     children: [

                //     //       Divider(),
                //     //       rowGen("Peserta Ikut", "13"),
                //     //       Divider(),
                //     //       rowGen("Peserta Tidak Ikut", "10"),

                //     //     ],
                //     //   )
                //     // ),
                    
                //   ],
                // ) : SizedBox.shrink()                

              ],
            )
          ),
        ),
        // Show or hide the content based on the state
      ]),
    );
  }
}