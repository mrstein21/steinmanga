import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steinmanga/bloc/search_bloc/search_bloc.dart';
import 'package:steinmanga/bloc/search_bloc/search_event.dart';
import 'package:steinmanga/bloc/search_bloc/search_state.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';
import 'package:steinmanga/ui/detail/detail_page.dart';

class SearchPage extends StatefulWidget {
  var context;
  SearchPage({
    this.context
  });
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword="";
  SearchBloc searchBloc;
  ScrollController controller=ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
     if(maxScroll==currentScroller){
          searchBloc.add(FetchSearchEvent(keyword: keyword));
     } 

  }

  @override
  void initState() {
    searchBloc=BlocProvider.of<SearchBloc>(widget.context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchBloc.add(ResetSearchEvent());

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red
      ),
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(58, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.done,
            onChanged: (String terms){
               if(terms.isEmpty){
                   setState(() {
                     keyword=null;
                   });
                  searchBloc.add(ResetSearchEvent());
                  //onlineExamBloc.add(RefreshOnlineExamEvent());
                }
            },
            onSubmitted:(String term){
               keyword=term;
              if(keyword.length>=3){
                searchBloc.add(FetchSearchEvent(keyword: keyword));
              }
            },
            decoration: InputDecoration(  
              isDense: true,
              border: InputBorder.none,
              hintText: "Search..",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search,color: Colors.white,)
            ),
          ),
        ),
        ),
        body: BlocProvider(
          create:(context)=> SearchBloc(mangaRepository: MangaRepositoryImp()),
          child: Container(
            child: BlocBuilder<SearchBloc,SearchState>(
              bloc: searchBloc,
              builder: (context,state){
                if(state is SearchLoadingState){
                  return _buildLoading();
                }else if(state is SearchUnitializedState){
                  return _buildFirst();
                }else if(state is SearchLoadedState){
                  return _buildListResult(state.hasReachMax,state.list);
                }else if(state is SearchFailureState){
                  return _buildMessage();
                }
              }
            ),
          ),
       ),
      ),
    );
  }

   Widget _buildFirst(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search,color: Colors.grey,size: 70,),
            Text(
              "Find manga here",
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildListResult(bool hasReachMax,List<Manga> manga){
    return ListView.builder(
      controller: controller,
      itemCount: hasReachMax?manga.length:manga.length+1,
      itemBuilder: (context,index){
        if(index<manga.length){
          return _buildRowResult(manga[index]);
        }else{
          return _buildLoading();
        }

      }
    );
  }


  Widget _buildRowResult(Manga popular){
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


  Widget _buildImage(ImageProvider provider,Manga popular){
   return Container(
      margin: EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
       decoration: BoxDecoration(
          boxShadow: [
             new BoxShadow(
                 color: Colors.black38,
                blurRadius: 4.0,
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
                Text(popular.judul_manga,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white,fontFamily:"Roboto"),maxLines: 2,overflow: TextOverflow.ellipsis),
                SizedBox(height:5),
                Text(popular.chapter_terakhir,style: TextStyle(color:Colors.white,fontFamily:"Montserrat"),),
                SizedBox(height:5),
                Text(popular.sinopsis,style: TextStyle(fontSize:12,color:Colors.white,fontFamily:"Roboto"),maxLines: 2,overflow: TextOverflow.ellipsis,)
              ],
            ),
          )
        ],
      ),

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