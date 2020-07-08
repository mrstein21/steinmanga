import 'package:equatable/equatable.dart';
import 'package:steinmanga/model/detail_manga.dart';

abstract class DetailState extends Equatable{

}


class DetailLoadedState extends DetailState{
  DetailManga detailManga;
  DetailLoadedState({
    this.detailManga
  });


  @override
  // TODO: implement props
  List<Object> get props => [detailManga];
}


class DetailUnitializedState extends DetailState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class DetailFailureState extends DetailState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}