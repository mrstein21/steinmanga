import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable{

}


class FetchDetailEvent extends DetailEvent{
  String url;
  FetchDetailEvent({
    this.url
  });

  @override
  List<Object> get props => [url];
  
}