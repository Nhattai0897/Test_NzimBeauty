class TechniciansModel {
  TechniciansModel({this.id, this.name, this.url});
  int? id;
  String? name;
  String? url;

  factory TechniciansModel.fromJson(Map<String, dynamic> json) =>
      TechniciansModel(id: json["id"], name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "url": url};
}
