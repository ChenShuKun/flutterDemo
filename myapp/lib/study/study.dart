import "package:flutter/material.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("学习"),
      ),
      body: const _StudyContent(),
    );
  }
}

class _StudyContent extends StatelessWidget {
  const _StudyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("我是学习的视图 333"),
    );
  }
}
