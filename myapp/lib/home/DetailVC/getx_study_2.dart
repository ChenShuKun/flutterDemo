import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getx_study_controller.dart';

class GetXStudy2Page extends StatefulWidget {
  const GetXStudy2Page({super.key});

  @override
  State<GetXStudy2Page> createState() => _GetXStudy2PageState();
}

class _GetXStudy2PageState extends State<GetXStudy2Page> {
  RxInt count = 0.obs;
  // var student = Person().obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX 2 的学习"),
      ),
      body: _getBodyContent(),
    );
  }

  Widget _getBodyContent() {
    var counter = Get.put(CounterController());
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Obx(() {
            return Text(" 您点击了 $count 次");
          }),
          // Obx(() {
          //   return Text(
          //       " 名字 ${student.value.name}  age = ${student.value.age}");
          // }),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                count++;
              },
              child: const Text(" +++ ")),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                count--;
              },
              child: const Text("---")),
          ElevatedButton(
              onPressed: () {
                counter.increase();
              },
              child: const Text("counter action  ")),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
