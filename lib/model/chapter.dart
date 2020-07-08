List<Chapter>listChapterMangaFromJson(var data){
  return new List<Chapter>.from(data.map((x)=>Chapter.fromJson(x)));
}


class Chapter{
  String url;
  String chapter;
  String title;
  String tanggal;
  
  Chapter({
    this.url,
    this.chapter,
    this.title,
    this.tanggal
  });


  factory Chapter.fromJson(Map<String,dynamic>json)=>Chapter(
    url:json["url"],
    chapter:json["chapter"],
    title:json["judul"]==null?"":json["judul"],
    tanggal:json["tanggal"]
  );
}