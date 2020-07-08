import 'package:flutter/foundation.dart';
import 'package:steinmanga/mixins/server.dart';
import 'package:http/http.dart' as http;
import 'package:steinmanga/model/manga.dart';


abstract class MangaRepository{
  Future<String>geHome();
  Future<List<Manga>>getLatest(int page);
  Future<List<Manga>>getSearch(String keyword,int page);
  Future<String>getDetail(String url);
  Future<String>getRead(String url);
}


class MangaRepositoryImp extends MangaRepository{
  @override
  Future<String> geHome() async {
   var response = await http.get(Server.address+"/home");
      print(response.body);
      if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }

  }

   @override
  Future<List<Manga>> getLatest(int page) async {
   var response = await http.get(Server.address+"/latest_update?page="+page.toString());
      if (response.statusCode == 200) {
      return compute(listLatestUpdateMangaFromJson,response.body);
    } else {
      throw Exception();
    }

  }


   @override
  Future<List<Manga>> getSearch(String keyword,int page) async {
   var response = await http.get(Server.address+"/search?keyword="+keyword+"&page="+page.toString());
    print(response.body);
      if (response.statusCode == 200) {
      return compute(listSearchResultMangaFromJson,response.body);
    } else {
      throw Exception();
    }

  }

   @override
  Future<String> getDetail(String url) async {
   var response = await http.get(Server.address+"/detail?url="+url);
      if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }

  }

  @override
  Future<String> getRead(String url) async {
      var response = await http.get(Server.address+"/read?url="+url.toString());
      print(response.body);
      if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
    // TODO: implement getRead
  }

}