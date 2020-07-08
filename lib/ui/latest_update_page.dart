import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steinmanga/bloc/latest_update_bloc/latest_update_bloc.dart';
import 'package:steinmanga/bloc/latest_update_bloc/latest_update_event.dart';
import 'package:steinmanga/bloc/latest_update_bloc/latest_update_state.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';

class LatestUpdatePage extends StatefulWidget {
  var context;
  LatestUpdatePage({
    this.context
  });
  @override
  _LatestUpdatePageState createState() => _LatestUpdatePageState();
}

class _LatestUpdatePageState extends State<LatestUpdatePage> {
  var size;
  LatestUpdateBloc latestUpdateBloc;
  ScrollController controller = ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
     if(maxScroll==currentScroller){
           latestUpdateBloc.add(FetchLatestUpdateEvent());
     }    
  }


  @override
  void initState() {
    latestUpdateBloc=BlocProvider.of<LatestUpdateBloc>(widget.context);
    latestUpdateBloc.add(FetchLatestUpdateEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    latestUpdateBloc.add(ResetLatestUpdateEvent());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    size=MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<LatestUpdateBloc>(
        create:(context)=>LatestUpdateBloc(mangaRepository: MangaRepositoryImp()),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Latest Update Manga"),
          ),
          body: Container(
            child: BlocBuilder<LatestUpdateBloc,LatestUpdateState>(
              bloc: latestUpdateBloc,
              builder: (context,state){
                if(state is LatestUpdateLoadedState){
                  return _buildListLatestUpdate(state.hasReachMax,state.list);
                }else if(state is LatestUpdateUnitializedState){
                  return _buildLoading();
                }else if(state is LatestUpdateFailureState){
                  return _buildMessage();
                }
              }
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildListLatestUpdate(bool hasReachMax,List<Manga>list){
   return GridView.builder(
        controller:  controller,
        itemCount: hasReachMax?list.length:list.length+1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 3,
          ), 
        itemBuilder: (_,index){
          if(index<list.length){
            return _buildRowLatestUpdate(list[index]);
          }else{
            return _buildLoading();
          }
        }
      );
  }




  
  Widget _buildRowLatestUpdate(Manga latest_update){
    return Container(
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