class BannerModel {
  BannerModel({this.id, this.title, this.url});
  int? id;
  String? title;
  String? url;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      BannerModel(id: json["id"], title: json["title"], url: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url};
}
