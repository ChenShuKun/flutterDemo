import 'dart:convert';

/// 新闻模型类
class NewsModel {
  late String title;
  late String shareUrl;
  late String author;
  late String itemCover;
  late int hotValue;
  late String hotWords;
  late int playCount;
  late int diggCount;
  late int commentCount;
  NewsModel.fromMap(Map<String, dynamic> json) {
    title = json["title"] ?? "";
    shareUrl = json["share_url"] ?? "";
    author = json["author"] ?? "";
    itemCover = json["item_cover"] ?? "";
    hotValue = json["hot_value"] ?? 0;
    hotWords = json["hot_words"] ?? "";
    playCount = json["play_count"] ?? 0;
    diggCount = json["digg_count"] ?? 0;
    commentCount = json["comment_count"] ?? 0;
  }
}

class HttpService {
  static Future<Map<String, dynamic>> getNews() async {
    return jsonDecode('''
      "result":[{
        "title": "打发斯蒂芬",
        "shareUrl": "1213",
        "author": "1122",
        "itemCover": "111",
        "hotValue": 1,
        "hotWords": "90",
        "playCount": 120,
        "diggCount": 22,
        "commentCount": 100
      }]''');
    // var response = await Dio().get(
    //     "http://apis.juhe.cn/fapig/douyin/billboard?type=hot_video&size=50&key=9eb8ac7020d9bea6048db1f4c6b6d028");
    // return jsonDecode(response.toString());
  }
}
