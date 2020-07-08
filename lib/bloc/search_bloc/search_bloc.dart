
import 'package:bloc/bloc.dart';
import 'package:steinmanga/bloc/search_bloc/search_event.dart';
import 'package:steinmanga/bloc/search_bloc/search_state.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  MangaRepository mangaRepository;
  SearchBloc({
    this.mangaRepository
  });


  @override
  // TODO: implement initialState
  SearchState get initialState => SearchUnitializedState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if(event is FetchSearchEvent){
      if(state is SearchUnitializedState){
        yield SearchLoadingState();
        try{
          List<Manga>list=await mangaRepository.getSearch(event.keyword, event.page);
          yield SearchLoadedState(list: list,hasReachMax: false,page: 2);
        }catch(e){
          yield SearchFailureState();
        }
      }else{
        SearchLoadedState states= state as SearchLoadedState;
        List<Manga>list=await mangaRepository.getSearch(event.keyword,states.page);
        yield(list.isEmpty)?states.copyWith(hasReachMax: true):states.copyWith(list:states.list+list,page:states.page+1,hasReachMax: false);
      }
    }else if(event is ResetSearchEvent){
       yield SearchUnitializedState();
    }
    // TODO: implement mapEventToState
  }

}