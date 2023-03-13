import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'news_controller.dart';
import 'news_model.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    final counter = Get.put(NewsController());

    return Scaffold(
        appBar: AppBar(
          title: Text(counter.title),
        ),
        body: GetBuilder<NewsController>(
          builder: (counter) {
            if (counter.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: counter.list.length,
                itemBuilder: (_, index) {
                  NewsModel newsModel = counter.list[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          newsModel.itemCover,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            newsModel.title,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
