import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{

}


class FetchSearchEvent extends SearchEvent{
  String keyword;
  int page;

  FetchSearchEvent({
    this.keyword,
    this.page
  });
  @override
  // TODO: implement props
  List<Object> get props => [keyword,page];
  
}


class ResetSearchEvent extends SearchEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}