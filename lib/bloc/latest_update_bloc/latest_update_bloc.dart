import 'package:steinmanga/bloc/latest_update_bloc/latest_update_event.dart';
import 'package:steinmanga/bloc/latest_update_bloc/latest_update_state.dart';

import 'package:bloc/bloc.dart';
import 'package:steinmanga/model/manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';

class LatestUpdateBloc extends Bloc<LatestUpdateEvent,LatestUpdateState>{
  MangaRepository mangaRepository;
  LatestUpdateBloc({
    this.mangaRepository
  });


  @override
  // TODO: implement initialState
  LatestUpdateState get initialState => LatestUpdateUnitializedState();

  @override
  Stream<LatestUpdateState> mapEventToState(LatestUpdateEvent event) async* {
    if(event is FetchLatestUpdateEvent){
      if(state is LatestUpdateUnitializedState){
        try{
          List<Manga>list=await mangaRepository.getLatest(1);
          yield LatestUpdateLoadedState(list: list,hasReachMax: false,page: 2);
        }catch(e){
          yield LatestUpdateFailureState();
        }
      }else{
        LatestUpdateLoadedState states= state as LatestUpdateLoadedState;
        List<Manga>list=await mangaRepository.getLatest(states.page);
        yield(list.isEmpty)?states.copyWith(hasReachMax: true):states.copyWith(list:states.list+list,page:states.page+1,hasReachMax: false);
      }
    }else if(event is ResetLatestUpdateEvent){
      yield LatestUpdateUnitializedState();
    }
    // TODO: implement mapEventToState
  }

}