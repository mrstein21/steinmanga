import 'package:equatable/equatable.dart';
import 'package:steinmanga/model/manga.dart';

abstract class LatestUpdateState extends Equatable{

}

class LatestUpdateLoadedState extends LatestUpdateState{
  bool hasReachMax=false;
  List<Manga>list;
  int page=1;
  LatestUpdateLoadedState({
    this.hasReachMax,
    this.list,
    this.page
  });

  LatestUpdateLoadedState copyWith({List<Manga>list,bool hasReachMax,int page})=>LatestUpdateLoadedState(
    hasReachMax: hasReachMax ?? this.hasReachMax,
    list: list ?? this.list,
    page: page ?? this.page
  );
  
  
  @override
  // TODO: implement props
  List<Object> get props => [list,hasReachMax,page];
  
}


class LatestUpdateUnitializedState extends LatestUpdateState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class LatestUpdateFailureState extends LatestUpdateState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


