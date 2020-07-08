import 'dart:convert';

import 'package:steinmanga/bloc/read_bloc/read_event.dart';
import 'package:steinmanga/bloc/read_bloc/read_state.dart';

import 'package:bloc/bloc.dart';
import 'package:steinmanga/resource/manga_resource.dart';
class ReadBloc extends Bloc<ReadEvent,ReadState>{
  MangaRepository mangaRepository;
  ReadBloc({
   this.mangaRepository
  });
  @override
  // TODO: implement initialState
  ReadState get initialState => ReadUnitializedState();

  @override
  Stream<ReadState> mapEventToState(ReadEvent event)async* {
    if(event is FetchReadEvent){
      yield ReadUnitializedState();
      try{
        String response=await mangaRepository.getRead(event.url);
        var result=json.decode(response);
        var list_gambar=result["data"]["gambar"];
        int total=result["data"]["total"];
        yield ReadLoadedState(gambar: list_gambar,total: total);
      }catch(e){
        yield ReadFailureState();
      }
      
    }
    // TODO: implement mapEventToState
  }

}