class CourseModel {
  CourseModel({this.id, this.title, this.url});
  int? id;
  String? title;
  String? url;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      CourseModel(id: json["id"], title: json["title"], url: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url};
}
