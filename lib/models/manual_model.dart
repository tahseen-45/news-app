class NewsModel{
  String? status;
  String? totalRecords;
  List? articles;

  NewsModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    totalRecords=json["totalrecords"];
    if(json["articles"]!=null) {
      for (Map<String, dynamic> maps in articles!) {
            articles!.add(Articles.fromJson(maps));
      }
    }

  }
}
class Articles{
  Source? source;
  String? title;
  String? description;
  String? publishAt;
  String? url;
  String? urlToImage;

  Articles.fromJson(Map<String,dynamic> maps){
    source=Source.fromJson(maps);
    title=maps["title"];
    description=maps["description"];
    publishAt=maps["publishAt"];
    url=maps["url"];
    urlToImage=maps["urlToImage"];

  }
}
class Source{
  String? name;
  String? id;

  Source.fromJson(Map<String,dynamic> sourceMap){
    name=sourceMap["name"];
    id=sourceMap["id"];

  }
}