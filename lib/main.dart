import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steinmanga/bloc/detail_bloc/detail_bloc.dart';
import 'package:steinmanga/bloc/home_bloc/home_bloc.dart';
import 'package:steinmanga/bloc/home_bloc/home_event.dart';
import 'package:steinmanga/bloc/home_bloc/home_state.dart';
import 'package:steinmanga/bloc/latest_update_bloc/latest_update_bloc.dart';
import 'package:steinmanga/bloc/read_bloc/read_bloc.dart';
import 'package:steinmanga/resource/manga_resource.dart';
import 'package:steinmanga/ui/home/latest_update_section.dart';
import 'package:steinmanga/ui/home/popular_section.dart';
import 'package:steinmanga/ui/latest_update_page.dart';
import 'package:steinmanga/ui/search_page.dart';
import 'bloc/search_bloc/search_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>( create:(context)=> HomeBloc(mangaRepository:MangaRepositoryImp())),
          BlocProvider<LatestUpdateBloc>( create:(context)=> LatestUpdateBloc(mangaRepository:MangaRepositoryImp())),
          BlocProvider<SearchBloc>( create:(context)=> SearchBloc(mangaRepository:MangaRepositoryImp())),
          BlocProvider<DetailBloc>( create:(context)=> DetailBloc(mangaRepository:MangaRepositoryImp())),
          BlocProvider<ReadBloc>( create:(context)=> ReadBloc(mangaRepository:MangaRepositoryImp())),
        ],
      child: MyHomePage(title: 'Flutter Demo Home Page')
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc=BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchHomeEvent());
    // TODO: implement initState
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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

Widget _buildHome(HomeLoadedState state){
  return Container(
    padding: EdgeInsets.all(5),
    child: ListView(
      children: <Widget>[
        SizedBox(height:15),
        Text("Popular Manga",style:TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 17)),
        SizedBox(height:5),
        Divider(),
        SizedBox(height:5),
        PopularSection(list: state.popular,context: context,),
        SizedBox(height:18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Latest Update Manga",style:TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 17)),
              GestureDetector( 
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context2)=> LatestUpdatePage(context: context,),
                  )); 
                 },
              child: Text("See More",style:TextStyle(fontFamily: "Montserrat",fontSize: 14))
            ),
          ],
        ),
        SizedBox(height:5),
        Divider(),
        SizedBox(height:5),
        LatestUpdateSection(list:state.latest_update,context: context,)
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
         title: Image.asset("assets/icon_app.png",height: 60,),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(
                   builder: (context2)=> SearchPage(context: context,),
                ));
            },
            child: Icon(Icons.search)
          ),
          SizedBox(width:5)

        ],
      ),
      body: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
          if(state is HomeLoadedState){
            return _buildHome(state);
          }else if(state is HomeFailureState){
            return _buildMessage();
          }else if(state is HomeUnitializedState){
            return _buildLoading();
          }
        }          
      )
    );
  }
}
