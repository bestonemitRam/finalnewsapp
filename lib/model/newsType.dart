class NewsType {
  dynamic img;

  dynamic title;

  NewsType({
    this.img,
  
    this.title,
  });

  factory NewsType.fromMap(Map<dynamic, dynamic> data) {
    return NewsType(
      img: data['img'],

      title: data['title'],
    );
  }
  factory NewsType.fromJson(Map<String, dynamic> json) {
    return NewsType(
      img: json['img'],
 
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,

      'title': title,
    };
  }
}
