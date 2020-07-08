import 'package:flutter/material.dart';
import 'package:steinmanga/model/detail_manga.dart';

class DetailSection extends StatefulWidget {
  DetailManga detailManga;
  DetailSection({
    this.detailManga
  });

  @override
  _DetailSectionState createState() => _DetailSectionState();
}

class _DetailSectionState extends State<DetailSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
         Text(widget.detailManga.judul_manga,style: TextStyle(fontSize: 18,fontFamily: "Roboto",fontWeight: FontWeight.bold),),
          SizedBox(
            height: 12,
          ),
          Text("Author : ",style: TextStyle(fontSize: 15,fontFamily: "Roboto",fontWeight: FontWeight.bold),),
           SizedBox(
            height: 5,
           ),
           Text(widget.detailManga.author,style: TextStyle(fontSize: 14,fontFamily: "Montserrat"),textAlign: TextAlign.justify),
           SizedBox(
            height: 8,
          ),   
          Text("Latest Update : ",style: TextStyle(fontSize: 15,fontFamily: "Roboto",fontWeight: FontWeight.bold),),
         SizedBox(
            height: 5,
          ),
         Text(widget.detailManga.terakhir_update,style: TextStyle(fontSize: 14,fontFamily: "Montserrat"),textAlign: TextAlign.justify),
          SizedBox(
            height: 8,
          ),
         Text("Synopsis : ",style: TextStyle(fontSize: 15,fontFamily: "Roboto",fontWeight: FontWeight.bold),),
         SizedBox(
            height: 5,
          ),
         Text(widget.detailManga.sinopsis,style: TextStyle(fontSize: 14,fontFamily: "Montserrat"),textAlign: TextAlign.justify),

        ],
      ),
    );
  }
}