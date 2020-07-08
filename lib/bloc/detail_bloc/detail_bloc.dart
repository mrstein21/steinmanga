import 'package:steinmanga/bloc/detail_bloc/detail_event.dart';
import 'package:steinmanga/bloc/detail_bloc/detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:steinmanga/model/detail_manga.dart';
import 'package:steinmanga/resource/manga_resource.dart';

class DetailBloc extends Bloc<DetailEvent,DetailState>{
  MangaRepository mangaRepository;
  DetailBloc({
    this.mangaRepository
  });

  @override
  // TODO: implement initialState
  DetailState get initialState => DetailUnitializedState();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async * {
    if(event is FetchDetailEvent){
      yield DetailUnitializedState();
      try{
        String response= await mangaRepository.getDetail(event.url);
        DetailManga manga=detailMangaFromJson(response);
        yield DetailLoadedState(
          detailManga: manga
        );
      }catch(e){
        yield DetailFailureState();
      }
    }
    // TODO: implement mapEventToState
  }
  
}