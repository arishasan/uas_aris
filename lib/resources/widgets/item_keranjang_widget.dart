import 'package:uas_aris/app/models/keranjang.dart';
import 'package:uas_aris/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemKeranjangWidget extends StatefulWidget {
  final int index;
  final Function deleteFunc;

  const ItemKeranjangWidget(
    {
      Key? key,
      required this.index,
      required this.deleteFunc
    }
  )
      : super(key: key);
  @override
  State<ItemKeranjangWidget> createState() => _ItemKeranjangWidgetState();
}

class _ItemKeranjangWidgetState extends State<ItemKeranjangWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colorUtama
                ),
                child: Column(
                  children: [
                    Text(
                      "QTY" , style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Colors.white,
                    ),),
                    Text(
                      globalKeranjang[widget.index].qty.toString() 
                      , style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                )
              ),
              SizedBox(width: 20,),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(globalKeranjang[widget.index].namaProduk, 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w300
                    ),),
                    Text(
                      "USD " + globalKeranjang[widget.index].price.toString() + " * " + globalKeranjang[widget.index].qty.toString() + ' = ' + (globalKeranjang[widget.index].price * globalKeranjang[widget.index].qty).toString(), 
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  globalSelectedItemIDX = globalKeranjang[widget.index].idproduk;
                  widget.deleteFunc();
                },
                child: Icon(Icons.delete, color: Colors.red)
              )

            ],
          ),

        ],
      )
    );
  }
}