import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steinmanga/model/chapter.dart';
import 'package:steinmanga/ui/read_page.dart';

class ListChapterSection extends StatefulWidget {
  List<Chapter>list;
  String alamat_gambar;
  var context;
  String judul;
  ListChapterSection({
    this.list,
    this.alamat_gambar,
    this.context,
    this.judul
  });

  @override
  _ListChapterSectionState createState() => _ListChapterSectionState();
}

class _ListChapterSectionState extends State<ListChapterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ListView.separated(
        separatorBuilder: (_,index){
          return Divider();
        },
        itemCount: widget.list.length,
        itemBuilder: (context,index){
          return _buildRowChapter(widget.list[index]);
        }
      ),
    );
  }

   Widget _buildRowChapter(Chapter chapter){
     return GestureDetector(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(
                 builder: (context2)=> ReadPage(context:widget.context,alamat_gambar: widget.alamat_gambar,url:chapter.url,chapter: chapter.chapter,judul: widget.judul,),
            )); 
       },
       child: Container(
         padding: EdgeInsets.all(10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.alamat_gambar,
              imageBuilder: (context,provider){
                return _buildImage(NetworkImage(widget.alamat_gambar));
              },
              errorWidget:(context, url, error){
                return _buildImage(NetworkImage("http://manga-bat.xyz/frontend/images/404-avatar.png"));
              },
            ),
             Container(
               width: 200,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                  Text(chapter.chapter,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Roboto'),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5,),
                  Text(chapter.title==""?"N/A":chapter.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily: 'Montserrat'),),
                  SizedBox(height: 5,),
                  Text(chapter.tanggal==""?"N/A":chapter.tanggal,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'Montserrat'),),
                 ],
               ),
             )
           ],
         ),
       ),
     );
   }

   Widget _buildImage(ImageProvider provider){
   return Container(
      margin: EdgeInsets.only(right: 5),
      height: 100,
      width: 100,
       decoration: BoxDecoration(
          boxShadow: [
             new BoxShadow(
                 color: Colors.black38,
                blurRadius: 2.0,
              )
           ],
          image: DecorationImage(image: provider,fit: BoxFit.fill),
         borderRadius: BorderRadius.all(Radius.circular(10)),
      )
    );
  }
  
 


}