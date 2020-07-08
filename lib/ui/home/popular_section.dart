import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/ui/detail/detail_page.dart';

class PopularSection extends StatefulWidget {
  List<Manga>list;
  var context;
  PopularSection({
    this.list,
    this.context
  });

  @override
  _PopularSectionState createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (_,index){
            return _buildRowPopular(widget.list[index]);
        }
      ),     
    );
  }

  Widget _buildImage(ImageProvider provider,Manga popular){
   return Container(
      margin: EdgeInsets.all(5),
     height: 120,
      width: 270,
       decoration: BoxDecoration(
          boxShadow: [
             new BoxShadow(
                 color: Colors.black38,
                blurRadius: 2.0,
              )
           ],
          image: DecorationImage(image: provider,fit: BoxFit.fill),
         borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(popular.judul_manga,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white,fontFamily:"Roboto"),),
                SizedBox(height:5),
                Text(popular.chapter_terakhir,style: TextStyle(color:Colors.white,fontFamily:"Montserrat"),),
              ],
            ),
          )
        ],
      ),

    );
  }
  
  Widget _buildRowPopular(Manga popular){
    return GestureDetector(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(
                 builder: (context2)=> DetailPage(context:widget.context,alamat_gambar: popular.alamat_gambar,url: popular.url,),
            )); 
      },
      child: CachedNetworkImage(
        imageUrl: popular.alamat_gambar,
        imageBuilder: (context,provider){
          return _buildImage(provider, popular);
        },
        errorWidget: (_,url,error){
          return _buildImage(NetworkImage("http://manga-bat.xyz/frontend/images/404-avatar.png"), popular);
        },
      ),
    );
  } 

}