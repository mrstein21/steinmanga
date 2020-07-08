import 'dart:convert';

import 'chapter.dart';

DetailManga detailMangaFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return DetailManga.fromJson(data);
}



class DetailManga{
  String judul_manga;
  String author;
  String status;
  var genre=[];
  String sinopsis;
  String alamat_gambar;
  String terakhir_update;
  List<Chapter> chapter;
  String dilihat;

  DetailManga({
    this.judul_manga,
    this.author,
    this.status,
    this.genre,
    this.sinopsis,
    this.alamat_gambar,
    this.chapter,
    this.terakhir_update,
    this.dilihat
  });

  factory DetailManga.fromJson(Map<String,dynamic>json)=>DetailManga(
    judul_manga:json["judul_manga"],
    author:json["author"],
    status:json["status"],
    genre:json["genre"],
    sinopsis:json["sinopsis"],
    alamat_gambar:json["alamat_gambar"],
    terakhir_update: json["terakhir_update"],
    dilihat: json["dilihat"],
    chapter:listChapterMangaFromJson(json["chapters"])==null?[]:listChapterMangaFromJson(json["chapters"])
  );
 

}