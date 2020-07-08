import 'package:equatable/equatable.dart';
import 'package:steinmanga/model/manga.dart';

abstract class SearchState extends Equatable{

}

class SearchLoadedState extends SearchState{
  bool hasReachMax=false;
  List<Manga>list;
  int page=1;
  SearchLoadedState({
    this.hasReachMax,
    this.list,
    this.page
  });

  SearchLoadedState copyWith({List<Manga>list,bool hasReachMax,int page})=>SearchLoadedState(
    hasReachMax: hasReachMax ?? this.hasReachMax,
    list: list ?? this.list,
    page: page ?? this.page
  );
  
  
  @override
  // TODO: implement props
  List<Object> get props => [list,hasReachMax,page];
  
}

class SearchLoadingState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


class SearchUnitializedState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class SearchFailureState extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


