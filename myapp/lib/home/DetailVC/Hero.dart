import "package:flutter/material.dart";
import 'package:myapp/home/DetailVC/HeroDetail.dart';

class HeroPageDemo extends StatelessWidget {
  const HeroPageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero 学习"),
      ),
      body: HeroDemo(),
    );
  }
}

class HeroDemo extends StatefulWidget {
  HeroDemo({Key? key}) : super(key: key);

  @override
  State<HeroDemo> createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  final List<String> _list = [];
  late Future<dynamic> _dataFuture;
  late Stream _dataStream;
  @override
  void initState() {
    _dataFuture = Future(() {
      List.generate(30, (index) {
        final url = "https://picsum.photos/id/$index/300/400";
        _list.add(url);
      });
      setState(() {});
    });
    // _dataStream = (() async* {
    //   for (int i = 1; i <= 100; i++) {
    //     final url = "https://picsum.photos/id/$i/300/400";
    //     // _list.add(url);
    //   }
    //   yield _list;
    // })();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getWidgetBuilde1();
    // return _streamBuilde2();
  }

  Widget _getWidgetBuilde1() {
    if (_list.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
    return _getContent2(context);
  }

  Widget _streamBuilde2() {
    return StreamBuilder(
        stream: _dataStream,
        initialData: 0,
        builder: (context, snapshot) {
          print('State: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return _getContent2(context);
            } else {
              return const Center(child: Text('Empty data'));
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        });
  }

  Widget _getContent2(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
          itemCount: _list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            final imageURL = _list[index];
            return _getItem(imageURL);
          }),
    );
  }

  Widget _getContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: GridView.extent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
        children: List.generate(20, (index) {
          final imageURL = "https://picsum.photos/id/$index/300/400";
          return _getItem(imageURL);
        }),
      ),
    );
  }

  Widget _getItem(String imageURL) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
              opacity: animation,
              child: HeroDetail(
                imageUrl: imageURL,
              ));
        }));
      },
      child: Hero(
          tag: imageURL,
          child: Image.network(
            imageURL,
            fit: BoxFit.fitWidth,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                    color: Colors.red,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null),
              );
            },
          )),
    );
  }
}
