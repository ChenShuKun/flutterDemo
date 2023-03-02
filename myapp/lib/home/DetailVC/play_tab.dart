import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/tools/tips.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int _currentPage = 0;
  double _sliderValue = 0.0;
  final PageController _pageCtl = PageController(
    initialPage: 0,
    keepPage: true,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _getContent(),
    );
  }

  Widget _getContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _headerTitleRowWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _headerStackWidget(),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _headerCardAndCodeWidget(),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _bottomButtonsWidget(),
        ),
        const SizedBox(
          height: 10,
        ),
        _bottomContainerWidget(),
      ],
    );
  }

  ///头部标题视图
  Widget _headerTitleRowWidget() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        const Expanded(
            child: Text(
          "产品名称",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),
        IconButton(
            onPressed: () {
              Tips.showToast("设置按钮");
            },
            icon: const Icon(Icons.menu_outlined))
      ],
    );
  }

  ///头部 视图
  Widget _headerStackWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Transform.rotate(
                  angle: pi,
                  child: Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.green,
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      }))
            ],
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            height: 46,
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Tips.showToast("循环播放");
                    },
                    icon: const Icon(Icons.rectangle_sharp)),
                IconButton(
                    onPressed: () {
                      Tips.showToast("下一曲");
                    },
                    icon: const Icon(Icons.next_plan)),
                const Expanded(
                    child: SizedBox(
                  width: 10,
                )),
                IconButton(
                    onPressed: () {
                      Tips.showToast("播放");
                    },
                    icon: const Icon(Icons.play_circle)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 头部 名片 二维码视图
  Widget _headerCardAndCodeWidget() {
    return Row(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: _headerCardAndCodeItem(
              const Icon(
                Icons.contact_phone_outlined,
                size: 35,
                color: Colors.white,
              ),
              "我的名片",
              "点击扫一扫加我", () {
            Tips.showInfo("我的名片");
          }),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(10)),
          child: _headerCardAndCodeItem(
              const Icon(
                Icons.view_module_outlined,
                size: 35,
                color: Colors.white,
              ),
              "微信二维码",
              "点击扫一扫加我", () {
            Tips.showInfo("微信二维码");
          }),
        )),
      ],
    );
  }

  //名片，二维码 视图item
  Widget _headerCardAndCodeItem(
      Icon leftIcon, String title, String subTitle, void Function()? tap) {
    return TextButton(
      onPressed: tap,
      child: Row(
        children: [
          leftIcon,
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              Text(subTitle,
                  style: const TextStyle(color: Colors.green, fontSize: 12))
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _titleWidgets() {
    List<String> list = ["我的收藏", "警示语录", "热门图片", "视频", "我的其他"];
    List<Widget> titleWidget = [];
    for (var i = 0; i < list.length; i++) {
      final title = list[i];

      final button = OutlinedButton(
          onPressed: () {
            _titleBtnAction(i);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(90, 30),
            foregroundColor: _currentPage == i ? Colors.white : Colors.black,
            backgroundColor: _currentPage == i ? Colors.purple : null,
            side: const BorderSide(color: Colors.purple),
            // textStyle: TextStyle(
            //     fontWeight: FontWeight.w700,
            //     color: _currentPage == i ? Colors.white : Colors.black),
            shape: const StadiumBorder(),
          ),
          child: Text(title));
      titleWidget.add(button);
      titleWidget.add(const SizedBox(
        width: 10,
      ));
    }
    return titleWidget;
  }

  ///标题 按钮 点击事件
  void _titleBtnAction(int index) {
    if (_currentPage == index) {
      return;
    }
    setState(() {
      _currentPage = index;
      _pageCtl.jumpToPage(_currentPage);
    });
  }

  ///底部 按钮视图
  Widget _bottomButtonsWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _titleWidgets(),
      ),
    );
  }

  ///底部 滚动视图
  Widget _bottomContainerWidget() {
    return Expanded(
      child: PageView.builder(
        itemCount: _titleWidgets().length,
        controller: _pageCtl,
        itemBuilder: (context, index) {
          return _bottomCridView();
        },
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }

  Widget _bottomCridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          itemCount: _titleWidgets().length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: ((context, index) {
            Color color = index / 2 == 0 ? Colors.red : Colors.green;
            return _bottomContainerItem(context, index, color);
          })),
    );
  }

  Widget _bottomContainerItem(BuildContext ctx, int index, Color sss) {
    return Container(
      decoration: BoxDecoration(
          color: sss, borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: IconButton(
          onPressed: () {
            Tips.showToast("button $index click");
          },
          icon: const Icon(
            Icons.add,
            size: 35,
            color: Colors.black45,
          )),
    );
  }
}
