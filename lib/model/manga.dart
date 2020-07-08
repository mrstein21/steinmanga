import 'dart:convert';

List<Manga>listPopularMangaFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"]["popular"];
  return new List<Manga>.from(data.map((x) => Manga.fromJson(x)));
}

List<Manga>listLatestUpdateMangaFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"]["latest_update"];
  return new List<Manga>.from(data.map((x) => Manga.fromJson(x)));
}

List<Manga>listSearchResultMangaFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"]["result"];
  return new List<Manga>.from(data.map((x) => Manga.fromJson(x)));
}



class Manga{
  String url;
  String judul_manga;
  String alamat_gambar;
  String chapter_terakhir;
  String sinopsis;
  
  Manga({
    this.url,
    this.judul_manga,
    this.alamat_gambar,
    this.chapter_terakhir,
    this.sinopsis
  });

  factory Manga.fromJson(Map<String,dynamic>json)=>Manga(
    alamat_gambar: json["alamat_gambar"],
    judul_manga: json["judul_manga"],
    url: json["url"],
    chapter_terakhir: json["chapter_terakhir"],
    sinopsis: json["sinopsis"]
  );
}