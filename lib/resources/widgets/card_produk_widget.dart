import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_aris/app/models/produk.dart';
import 'package:uas_aris/config/const_vars.dart';

class CardProduk extends StatefulWidget {
  final int index;

  const CardProduk(
    {
      Key? key,
      required this.index
    }
  )
      : super(key: key);
  @override
  State<CardProduk> createState() => CardProdukState();
}

class CardProdukState extends State<CardProduk> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.network(globalProduk[widget.index].image, width: 80,),

              SizedBox(height: 10,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(globalProduk[widget.index].title, 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),),

                    SizedBox(height: 5,),

                    Text('USD ' + globalProduk[widget.index].price.toString(), 
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: colorUtama,
                      fontWeight: FontWeight.bold
                    ),),

                    SizedBox(height: 5,),

                  ],
                )
              )

            ],
          ),
        ),
      )
    );
  }
}