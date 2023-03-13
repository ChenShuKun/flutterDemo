import 'package:get/get.dart';
import 'package:myapp/home/DetailVC/news/news_model.dart';

class NewsController extends GetxController {
  bool isLoading = true; //是否加载中
  String title = "新闻 列表";
  List<NewsModel> list = [];

  @override
  void onInit() {
    getNewsList();
    super.onInit();
  }

  /// 数据请求与处理
  void getNewsList() async {
    try {
      Map<String, dynamic> map = await HttpService.getNews();
      List list = map["result"];
      list = List<NewsModel>.from(
          list.map((jsonMap) => NewsModel.fromMap(jsonMap)));
      // list.removeAt(0);
      update();
    } finally {
      isLoading = false;
      update();
    }
  }
}
