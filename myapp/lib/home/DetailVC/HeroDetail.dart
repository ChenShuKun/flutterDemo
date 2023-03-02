import "package:flutter/material.dart";

class HeroDetail extends StatelessWidget {
  String imageUrl = "";
  HeroDetail({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
                tag: imageUrl,
                child: Image.network(imageUrl,
                    width: double.infinity, fit: BoxFit.cover))),
      ),
    );
  }
}
