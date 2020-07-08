import 'package:equatable/equatable.dart';

abstract class ReadState extends Equatable{

}





class ReadUnitializedState extends ReadState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class ReadFailureState extends ReadState{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}


class ReadLoadedState extends ReadState{
  var gambar;
  int total;

  ReadLoadedState({
    this.gambar,
    this.total
  });

  @override
  // TODO: implement props
  List<Object> get props => [gambar,total];
  
}