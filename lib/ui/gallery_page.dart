import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  var gambarr;
  GalleryPage({
    this.gambarr
  });

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          PhotoViewGallery.builder(
             scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color:Colors.black,
            ),
            loadingBuilder:(contezt,index)=> Center(
              child: CircularProgressIndicator(),
            ),
            onPageChanged: (int pos){
              setState(() {
                currentIndex=pos;
              });
            },

            itemCount: widget.gambarr.length, 
            builder: (context,index){
              return PhotoViewGalleryPageOptions(
                heroAttributes: PhotoViewHeroAttributes(
                  tag:"Hellos" ),

                imageProvider: NetworkImage(
                  widget.gambarr[index],
                ),
              
              );
            }
          ),
              Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Page ${currentIndex + 1}/${widget.gambarr.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
        ],
      )
      ,
     
    );
  }
}