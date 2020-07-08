import 'package:equatable/equatable.dart';
import 'package:steinmanga/model/manga.dart';

abstract class HomeState extends Equatable{}

class HomeLoadedState extends HomeState{
  List<Manga>latest_update;
  List<Manga>popular;

  HomeLoadedState({
    this.latest_update,
    this.popular
  });
  @override
  // TODO: implement props
  List<Object> get props => [latest_update,popular];
}


class HomeUnitializedState extends HomeState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class HomeFailureState extends HomeState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}