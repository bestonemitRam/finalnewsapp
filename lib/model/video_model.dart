class VideoModel {
  dynamic video_url;
  dynamic video_id;
   dynamic title;

  VideoModel({
    this.video_url,
    this.video_id,
      this.title,
  });

  factory VideoModel.fromMap(Map<dynamic, dynamic> data) {
    return VideoModel(
      video_url: data['video_url'],
      video_id: data['video_id'],
        title: data['title'],
    );
  }
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video_url: json['video_url'],
      video_id: json['video_id'],
        title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_url': video_url,
      'video_id': video_id,
      'title': title,
    };
  }
}
