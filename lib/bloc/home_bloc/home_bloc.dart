
import 'package:steinmanga/bloc/home_bloc/home_event.dart';
import 'package:steinmanga/bloc/home_bloc/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  MangaRepository mangaRepository;
  HomeBloc({
    this.mangaRepository
  });

  @override
  // TODO: implement initialState
  HomeState get initialState => HomeUnitializedState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async * {
    if(event is FetchHomeEvent){
          yield HomeUnitializedState();

      try{
        String response= await mangaRepository.geHome();
        List<Manga>latest_update=listLatestUpdateMangaFromJson(response);
        List<Manga>popular=listPopularMangaFromJson(response);
        yield HomeLoadedState(
          latest_update: latest_update,
          popular: popular,
        );
      }catch(e){
        print(e.toString());
        yield HomeFailureState();
      }

    }
    // TODO: implement mapEventToState
  }
  
}