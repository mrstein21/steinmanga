import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/ui/detail/detail_page.dart';

class LatestUpdateSection extends StatefulWidget {
  List<Manga>list;
  var context;
  LatestUpdateSection({
    this.list,
    this.context
  });
  @override
  _LatestUpdateSectionState createState() => _LatestUpdateSectionState();
}

class _LatestUpdateSectionState extends State<LatestUpdateSection> {
  var size;


  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 3,
          ), 
        itemBuilder: (_,index){
          return _buildRowLatestUpdate(widget.list[index]);
        }
      )
    );
  }
  
  Widget _buildImage(ImageProvider provider){
   return Container(
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

  

  Widget _buildRowLatestUpdate(Manga latest_update){
    return GestureDetector(
       onTap: (){
           Navigator.push(context, MaterialPageRoute(
                 builder: (context2)=> DetailPage(context:widget.context,alamat_gambar: latest_update.alamat_gambar,url: latest_update.url,),
            )); 
         },
      child: Container(
        margin: EdgeInsets.only(left:5,right: 5,top: 5,bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: latest_update.alamat_gambar,
                imageBuilder: (context,provider){
                  return _buildImage(NetworkImage(latest_update.alamat_gambar));
                },
                errorWidget:(context, url, error){
                  return _buildImage(NetworkImage("http://manga-bat.xyz/frontend/images/404-avatar.png"));
                },
              ),
           
            ),
            SizedBox(height:5),
            Container(
              width: size.width/3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(latest_update.judul_manga,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily:"Roboto"),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  SizedBox(height:5),
                  Text(latest_update.chapter_terakhir,style: TextStyle(fontSize: 10,fontFamily:"Montserrat"),maxLines: 1,overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


}