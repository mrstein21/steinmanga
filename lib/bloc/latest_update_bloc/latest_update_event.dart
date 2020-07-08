import 'package:equatable/equatable.dart';

abstract class LatestUpdateEvent extends Equatable{

}


class FetchLatestUpdateEvent extends LatestUpdateEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class ResetLatestUpdateEvent extends LatestUpdateEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}