import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/tips.dart';

class BaseWidgetStudy extends StatefulWidget {
  const BaseWidgetStudy({super.key});

  @override
  State<BaseWidgetStudy> createState() => _BaseWidgetStudyState();
}

class _BaseWidgetStudyState extends State<BaseWidgetStudy> {
  bool stwValue = false;
  bool _value = false;
  TextEditingController _textVC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("基础组件学习"),
      ),
      body: _getBodyContent(),
    );
  }

  Widget _getBodyContent() {
    return Column(
      children: [
        _getTextDemo(),
        // _getTextSpanDemo(),
        // _getContarinDemo(),
        // _getImageDemo(),
        // _getListViewDemo(),
        // _getGridViewDemo(),
        // _getRowDemo(),
        // _getWarpDemo(),
        // _getColumDemo(),
        // _getStackDemo(),
        // _getCardDemo(),
        // _getButton1Demo(),
        // _getButton2Demo(),
        // _getButton3Demo(),
        // _getImage2Demo(),
        // _getSwitchDemo(),
        _getLayoutBuilder(),
        // _getCheckBoxhDemo(),
        // _getTextFieldDemo(),
        // _getProgressDemo(),
        // _getBoxDecorationDemo(),
        _getClipDemo(),
      ],
    );
  }

  Widget _getTextDemo() {
    return const Text(
      "hello 你好，哈哈哈哈 篇首语：本文由小常识网小编为大家整理，主要介绍了Flutter——最详细的Text（文本）使用教程相关的知识，希望对你有一定的参考价值。",
      maxLines: 2,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          // decoration: TextDecoration.lineThrough,
          // decorationThickness: 2.85,
          backgroundColor: Colors.green),
    );
  }

  Widget _getTextSpanDemo() {
    // DefaultTextStyle(style: style, child: child)
    return Text.rich(
        textWidthBasis: TextWidthBasis.parent,
        TextSpan(children: [
          const TextSpan(text: "我已经阅读并同意"),
          TextSpan(
            text: "http://www.baidu.com",
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Tips.showToast("去百度");
              },
          ),
        ]));
  }

  Widget _getContarinDemo() {
    return Container(
      height: 100,
      width: 200,
      // color: Colors.red,
      // child: const Text("我是内容 "),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: Colors.black),
          //渐变色值
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.red, Colors.pink, Colors.green]),
          borderRadius:
              // BorderRadius.circular(8)
              const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
    );
  }

  String _getUrl() {
    const url =
        "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500";
    return url;
  }

  Widget _getImageDemo() {
    // return Image(
    //     // color: Colors.green,
    //     width: 200,
    //     height: 300,
    //     fit: BoxFit.fitHeight,
    //     image: AssetImage("lib/images/1111.jpeg"));
    return Image.network(
      _getUrl(),
      width: 200,
      height: 200,
      // color: Colors.red[100],
      // cacheWidth: 100,
      // cacheHeight: 100,
    );
  }

  Widget _getImage2Demo() {
    final url = _getUrl();
    return Image(
      // color: Colors.red,
      image: NetworkImage(url),
      filterQuality: FilterQuality.high,
    );
  }

  //list View
  Widget _getListViewDemo() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      child: ListView(
        // scrollDirection: Axis.vertical,
        scrollDirection: Axis.horizontal,
        children: [
          Image.network(
            _getUrl(),
          ),
          Image.network(
            _getUrl(),
          ),
          Image.network(
            _getUrl(),
          ),
        ],
      ),
    );
  }

  //网格
  Widget _getGridViewDemo() {
    return Container(
      height: 300,
      color: Colors.red,
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Image.network(
              "https://img0.baidu.com/it/u=2028084904,3939052004&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
              fit: BoxFit.fitHeight,
            );
          }),
    );
  }

  //横向布局
  Widget _getRowDemo() {
    return Container(
      height: 130,
      width: double.infinity,
      color: Colors.orange,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // mainAxisSize:MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.green,
            ),
            const SizedBox(
              width: 300,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  //横向布局
  Widget _getWarpDemo() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.purple,
      child: Wrap(
        runSpacing: 10,
        spacing: 20,
        runAlignment: WrapAlignment.spaceBetween,
        // direction: Axis.vertical,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          // const SizedBox(
          //   width: 100,
          // ),
          Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _getColumDemo() {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: 200,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.green,
              width: 100,
              height: 100,
            ),
            Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Widget _getStackDemo() {
    return Stack(
      // alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.green,
        ),
        Positioned(
          bottom: 10,
          right: 10,
          // left: 10,
          // width: 60,
          // top: 10,
          child: Container(
            width: 40,
            height: 40,
            color: Colors.purple,
          ),
        )
      ],
    );
  }

  Widget _getCardDemo() {
    return const SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            side: BorderSide(
                color: Colors.green,
                width: 5,
                strokeAlign: StrokeAlign.outside,
                style: BorderStyle.solid)),
        shadowColor: Colors.yellow, // 阴影颜色
        elevation: 10, // 阴影高度
        color: Colors.red,
        // Container(
        //   color: Colors.purple,
        //   width: double.infinity,
        //   height: 200,
        // ),
      ),
    );
  }

  Widget _getButton1Demo() {
    return ElevatedButton(
        onPressed: () => print("pressed"), // Tips.showToast(" pressed toast "),
        // onLongPress: () => Tips.showToast(" long pressed toast "),
        onHover: (value) {
          print("value  $value");
        },
        onFocusChange: (value) {
          print("onFocusChange  $value");
        },
        child: Text("button1 "));
  }

  Widget _getButton2Demo() {
    return TextButton(
        onPressed: () {
          Tips.showToast("button click");
        },
        onHover: (value) {
          print("onHover  $value");
        },
        onFocusChange: (value) {
          print("onFocusChange  $value");
        },
        child: const Text("button"));
  }

  Widget _getButton3Demo() {
    // return OutlinedButton(

    //   onPressed: (() => print("OutlinedButton press")),
    //   child: Text("button 2"),
    // );
    return OutlinedButton.icon(
        onPressed: () {
          print("OutlinedButton  icon press");
        },
        icon: const Icon(
          Icons.add,
          color: Colors.red,
        ),
        label: Text(
          "我是 标题",
          style: TextStyle(color: Colors.purple, fontSize: 30),
        ));
  }

  Widget _getSwitchDemo() {
    return Column(
      children: [
        Switch(
          activeColor: Colors.red,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.green,
          inactiveTrackColor: Colors.black,
          value: stwValue,
          onChanged: (value) {
            setState(() {
              stwValue = value;
            });
          },
        ),
        SwitchListTile(
            tileColor: Colors.red,
            title: Text("title"),
            subtitle: Text("subtitle"),
            value: stwValue,
            // dense:stwValue,
            onChanged: (value) {
              setState(() {
                stwValue = value;
              });
            }),
      ],
    );
  }

  Widget _getCheckBoxhDemo() {
    return Column(
      children: [
        Checkbox(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
              });
            }),
        CheckboxListTile(
            title: Text("我是标题"),
            subtitle: Text("我是副标题"),
            tileColor: Colors.white,
            checkColor: Colors.green,
            activeColor: Colors.black,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
              });
            }),
      ],
    );
  }

  Widget _getTextFieldDemo() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: _textVC,
        autofocus: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.people,
            color: Colors.green,
          ),
          iconColor: Colors.red,
          helperText: "我是帮助text",
          helperStyle: TextStyle(color: Colors.red),
          hintText: "请输入用户名",
          hintStyle: TextStyle(color: Colors.orange),
          // label: Text("输入用户名"),
          labelText: "阿拉丁会计分录",
          suffixIcon: IconButton(
              onPressed: () {
                print("object");
              },
              icon: Icon(Icons.remove_red_eye)),
        ),
        textInputAction: TextInputAction.done,
        onTap: () {
          print(" 输入框为第一焦点了");
        },
        onChanged: (value) {
          print("value  = $value");
        },
      ),
    );
  }

  //进度条
  Widget _getProgressDemo() {
    return Column(
      children: const [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 10,
          // width: 100,
          child: LinearProgressIndicator(
              value: 0.5, color: Colors.red, backgroundColor: Colors.green),
        ),
        SizedBox(
          height: 20,
        ),
        CircularProgressIndicator(
            // value: .5,
            color: Colors.red,
            semanticsLabel: "1222")
      ],
    );
  }

  Widget _getBoxDecorationDemo() {
    final url = _getUrl();
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          // color: Colors.red,
          decoration: BoxDecoration(
              color: Colors.purple,
              // image: DecorationImage(
              //     image: NetworkImage(url), fit: BoxFit.fitHeight),

              // [BorderDirectional]. A uniform border can also be expressed as a
              /// [RoundedRectangleBorder
              border: const BorderDirectional(
                  top: BorderSide(width: 5, color: Colors.green)),
              // gradient: LinearGradient(
              //     colors: [Colors.red, Colors.orange.shade700]), //背景渐变
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          height: 200,
          width: 300,
        ),
      ],
    );
  }

  Widget _getLayoutBuilder() {
    return Container(
      child: Text("LayoutBuilder "),
    );
  }

  Widget _getClipDemo() {
    return Column(
      children: [
        ClipOval(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
        ),
        ClipRect(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  //LayoutBuilder
  ///end
}

class Recipe {
  int cows;
  int trampolines;
  Recipe(this.cows, this.trampolines);

  int get milkshake => cows + trampolines;

  int makeMilkshake() {
    return cows + trampolines;
  }

  ///
}

class MyWidget extends StatelessWidget {
  final personNextToMe =
      'That reminds me about the time when I was ten and our neighbor, her name was Mrs. Mable, and she said...';

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(Icons.airline_seat_legroom_reduced),
      Text(personNextToMe),
      const Icon(Icons.airline_seat_legroom_reduced),
    ]);
  }
}
