import 'package:flutter/material.dart';
import 'package:test2/pages/MessagePage.dart';


///  主页页面
///   [MessagePage()]
///
///
///
///
///
///
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("-------aaaaaaaaaaa------------"));
  }
}

class BottomMenuData {
  int index;
  IconData icon;
  IconData activeIcon;

  BottomMenuData(this.index, this.icon, this.activeIcon);
}

class BottomMenuPart extends StatelessWidget {
  int index;
  IconData icon;
  IconData activeIcon;
  int currentIndex;
  ValueChanged<int> changeIndex;

  BottomMenuPart(this.index, this.icon, this.activeIcon, this.currentIndex,
      this.changeIndex,
      {super.key});

  void _changeIndex() {
    changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _changeIndex,
        child: Icon(index == currentIndex ? activeIcon : icon));
  }
}

class BottomMenu extends StatefulWidget {
  List<BottomMenuData> iconsData = [];
  int currentIndex = 0;

  BottomMenu(this.currentIndex, this.iconsData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return BottomMenuState(currentIndex, iconsData);
  }
}

class BottomMenuState extends State<BottomMenu> {
  int currentIndex = 0;
  List<BottomMenuData> iconsData = [];

  BottomMenuState(this.currentIndex, this.iconsData);

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    print(currentIndex.toString() + " BottomMenuState ");
  }

  // Widget buildMenuPart(int index, IconData icon, IconData activeIcon) {
  //   iconsData.add(BottomMenuData(index, icon, activeIcon));
  //   return Icon(currentIndex == index ? activeIcon : icon);
  // }

  List<BottomMenuPart> buildBottomMenuPartList() {
    List<BottomMenuPart> result = [];
    for (var element in iconsData) {
      result.add(BottomMenuPart(element.index, element.icon, element.activeIcon,
          currentIndex, changeIndex));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildBottomMenuPartList()),
    );
  }
}
