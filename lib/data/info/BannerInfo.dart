import 'dart:convert';

BannerInfo bannerFromJson(String str) => BannerInfo.fromJson(json.decode(str));

String bannerToJson(BannerInfo data) => json.encode(data.toJson());

// https://app.quicktype.io/
class BannerInfo {
  BannerInfo({
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  });

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory BannerInfo.fromJson(Map<String, dynamic> json) => BannerInfo(
        desc: json["desc"],
        id: json["id"],
        imagePath: json["imagePath"],
        isVisible: json["isVisible"],
        order: json["order"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "imagePath": imagePath,
        "isVisible": isVisible,
        "order": order,
        "title": title,
        "type": type,
        "url": url,
      };
}
