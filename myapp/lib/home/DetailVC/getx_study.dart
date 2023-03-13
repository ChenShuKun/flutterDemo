import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myapp/home/DetailVC/getx_study_2.dart';
import 'package:myapp/home/DetailVC/getx_study_controller.dart';
import 'package:myapp/tools/tips.dart';

class GetXStudyPage extends StatefulWidget {
  const GetXStudyPage({super.key});

  @override
  State<GetXStudyPage> createState() => _GetXStudyPageState();
}

class _GetXStudyPageState extends State<GetXStudyPage> {
  String _infor = "下个页面的数据 ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" GetX 的学习"),
      ),
      body: _getBodyContent(),
    );
  }

  Widget _getBodyContent() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          // Obx(() {
          //   return Text(" _infor $_infor");
          // }),

          Text(" _infor $_infor"),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "你好我是 弹框 ", content: const Text("哈哈哈 "));
              },
              child: const Text(" Dialog ")),
          ElevatedButton(
              onPressed: () {
                Get.to(const GetXStudy2Page());
              },
              child: const Text(" push  Study 2 页面  ")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Get.snackbar("你好 标题", "我是 一个 小内容",
                    colorText: Colors.red,
                    shouldIconPulse: true,
                    showProgressIndicator: false);
              },
              child: const Text(" Gext snackbar")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: () {}, child: const Text(" Gext  ")),
        ],
      ),
    );
  }
}
