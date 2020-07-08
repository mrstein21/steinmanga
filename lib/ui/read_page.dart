import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steinmanga/bloc/read_bloc/read_bloc.dart';
import 'package:steinmanga/bloc/read_bloc/read_event.dart';
import 'package:steinmanga/bloc/read_bloc/read_state.dart';
import 'package:steinmanga/ui/gallery_page.dart';

class ReadPage extends StatefulWidget {
  var context;
  var alamat_gambar;
  var chapter;
  var url;
  var judul;
   
   ReadPage({
     this.alamat_gambar,
     this.context,
     this.chapter,
     this.url,
     this.judul
   });

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int current_pos=0;
  int position=1;
  ReadBloc readBloc;
  var size;
  @override
  void initState() {
    readBloc=BlocProvider.of<ReadBloc>(widget.context);
    readBloc.add(FetchReadEvent(url:widget.url));
    // TODO: implement initState
    super.initState();
  }
  Widget _buildImageCover(ImageProvider provider,String judul,String chapter){
    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(judul,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "Roboto"),maxLines: 2,overflow: TextOverflow.ellipsis),
                SizedBox(
                 height: 5,
                ),
                Text(chapter,style: TextStyle(fontSize: 14,color:Colors.white,fontFamily: "Montserrat"),maxLines: 2,overflow: TextOverflow.ellipsis,)
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: provider
        )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size.height;
    return BlocBuilder<ReadBloc,ReadState>(
      bloc: readBloc,
      builder: (context,state){
        if(state is ReadFailureState){
          return _buildMessage();
        }else if(state is ReadUnitializedState){
          return _buildLoading();
        }else if(state is ReadLoadedState){
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    child: CachedNetworkImage(
                      imageUrl: widget.alamat_gambar,
                      imageBuilder: (ctx,provider){
                        return _buildImageCover(provider, widget.judul, widget.chapter);
                      },
                      errorWidget: (ctx,url,error){
                        return _buildImageCover(NetworkImage("http://manga-bat.xyz/frontend/images/404-avatar.png"), widget.judul, widget.chapter);
                      },
                    )
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Text("Choose Page",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Roboto",fontSize: 18),)
                  ),
                  Divider(),
                  SizedBox(height: 15,),
                  Container(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: state.gambar.map<Widget>((e){
                          var index = state.gambar.indexOf(e);
                          var nomor=index+1;
                        return GestureDetector(
                          onTap: (){
                            _scaffoldKey.currentState.openEndDrawer();
                            setState(() {
                              current_pos=index;
                              position=index+1;
                            });

                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Page "+nomor.toString(),style: TextStyle(fontFamily: "Montserrat"),),
                                SizedBox(height: 5,),
                                Divider()
                              ],
                            ),
                          ),
                        );

                      }).toList(),
                    ),
                  )
                ],
              ),
             ) ,
              appBar: AppBar(
                  title: Text(widget.chapter),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         GestureDetector(
                      onTap: (){
                        setState(() {
                           if(current_pos>0){
                             current_pos=current_pos-1;
                             position=position-1;
                           }
                        });
                      },
                      child: Icon(Icons.navigate_before,color: current_pos==0?Colors.grey:Colors.white,)
                    ),
                    SizedBox(width: 5,),
                    Text(""+position.toString()+"/"+state.total.toString()),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        if(current_pos<state.total-1){
                          setState(() {
                            current_pos=current_pos+1;
                            position=position+1;
                          });

                        }
                      },
                      child: Icon(Icons.navigate_next,color: current_pos==state.gambar.length-1?Colors.grey:Colors.white,)
                    ),
                     SizedBox(width: 3,),

                      ],
                    ),
                   
                  ],
                ),
                body: Container(
                  child: _buildImage(state.gambar,current_pos),
                ),
          );
        }

      },
    );
  }

  Widget _buildImage(var gambar,int pos){
  return GestureDetector(
    onTap: (){
           Navigator.push(context, MaterialPageRoute(
                 builder: (context2)=> GalleryPage(gambarr: gambar,),
          )); 
     },
    child: CachedNetworkImage(
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
      imageUrl: gambar[pos],
      errorWidget: (ctx,url,error){
        return Image.network("http://manga-bat.xyz/frontend/images/404-avatar.png",fit: BoxFit.fill,);
      },
    ),
  );
}


}





  Widget _buildMessage(){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.signal_cellular_connected_no_internet_4_bar,color: Colors.grey,size: 70,),
              Text(
                "Can't Connect to Server",
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildLoading() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
 }