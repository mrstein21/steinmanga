import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steinmanga/bloc/detail_bloc/detail_bloc.dart';
import 'package:steinmanga/bloc/detail_bloc/detail_event.dart';
import 'package:steinmanga/bloc/detail_bloc/detail_state.dart';
import 'package:steinmanga/model/detail_manga.dart';
import 'package:steinmanga/ui/detail/detail_section.dart';
import 'package:steinmanga/ui/detail/list_chapter_section.dart';

class DetailPage extends StatefulWidget {
  var context;
  var url;
  var alamat_gambar;
  DetailPage({
    this.context,
    this.alamat_gambar,
    this.url
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin{
   DetailBloc detailBloc;
   TabController _tabController;



   @override
  void initState() {
    _tabController = TabController(length:2, vsync: this);
    detailBloc=BlocProvider.of<DetailBloc>(widget.context);
    detailBloc.add(FetchDetailEvent(url: widget.url));
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<DetailBloc,DetailState>(
          bloc: detailBloc,
          builder: (context,state){
            if(state is DetailLoadedState){
              return _buildDetail(state.detailManga);
            }else if(state is DetailUnitializedState){
              return _buildLoading();
            }else if(state is DetailFailureState){
              return _buildMessage();
            }

          },
        ),
      ),
    );
  }

 Widget _buildImage(ImageProvider provider,DetailManga detailManga){
   return Container(
      height: 240.0,
      child: Container(
        padding: EdgeInsets.only(bottom: 60,left: 5),
        height: 240.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(detailManga.judul_manga,style: TextStyle(fontSize: 18,fontFamily: "Roboto",fontWeight: FontWeight.bold,color: Colors.white,),maxLines: 2,overflow: TextOverflow.ellipsis,),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Status : "+detailManga.status,style: TextStyle(color: Colors.white,fontFamily: "Montserrat",)),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("View :"+detailManga.dilihat,style: TextStyle(color: Colors.white,fontFamily: "Montserrat",))
                )
              ],
            ),
             SizedBox(
              height: 15,
            ),
            Container(
                 height: 30,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   children: detailManga.genre.map((e) {
                      if(detailManga.genre.length>0){
                           return Container(
                             alignment: Alignment.center,
                             margin: EdgeInsets.only(right: 5),
                             padding: EdgeInsets.all(4),
                             decoration: BoxDecoration(
                               border: Border.all(
                                 width: 1,
                                 color: Colors.white,
                               ),
                               borderRadius:  new BorderRadius.circular(10.0),
                             ),
                             child: Text(e,style: TextStyle(color: Colors.white,fontFamily: "Montserrat",)),
                           );
                         }else{
                           return Container();
                         }
                     }).toList()
                 ),
               ),
          ],
        ),
        color: Colors.black.withOpacity(0.5)
      ),
       decoration: BoxDecoration(
          boxShadow: [
             new BoxShadow(
                 color: Colors.black38,
                blurRadius: 2.0,
              )
           ],
          image: DecorationImage(image: provider,fit: BoxFit.fill),
      )
    );
  }
  
  Widget _buildDetail(DetailManga detail){
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
            expandedHeight: 240.0,
            pinned: true,
            snap: true,
            floating: true,
            
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: detail.alamat_gambar,
                imageBuilder: (context,provider){
                  return _buildImage(provider,detail);
                },
                errorWidget: (context,url,error){
                  return _buildImage(NetworkImage("http://manga-bat.xyz/frontend/images/404-avatar.png"),detail);
                },
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Information",),
                Tab(text: "List Chapter",),                
              ]
            ),

        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              DetailSection(detailManga: detail,),
              ListChapterSection(context: widget.context,alamat_gambar: detail.alamat_gambar,list: detail.chapter,judul: detail.judul_manga,)
            ]
          ),
        )
      ],
    );
  }



  Widget _buildMessage(){
    return Center(
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
    );
  }

 Widget _buildLoading() {
    return Container(
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
 }
}