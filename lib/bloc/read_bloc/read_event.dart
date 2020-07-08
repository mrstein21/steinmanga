import 'package:equatable/equatable.dart';

abstract class ReadEvent extends Equatable{}

class FetchReadEvent extends ReadEvent{
  String url;
  FetchReadEvent({
    this.url
  });

  @override
  // TODO: implement props
  List<Object> get props => [];
  
}