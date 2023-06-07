import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:http/http.dart' as http;

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  final double appBarLen = 50;

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse("http://www.baidu.com"));
  }

  Future<String> get _localPath async {
    final directory = await path.getApplicationDocumentsDirectory();

    print(directory.path);
    return directory.path;
  }

  void init(BuildContext context) async {
    var of = MediaQuery.of(context);
    var response = await fetchAlbum();
    print(response.body);
    print(of.size.height.toString() + " ---" + of.size.width.toString());
  }

  @override
  Widget build(BuildContext context) {
    // init(context);
    // print(_localPath);
    return MaterialApp(
      home: BottomNavigationBarExample(50),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  double appBarLen;

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState(appBarLen);

  BottomNavigationBarExample(this.appBarLen, {super.key});
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  double appBarLen;

  void appBarMove(double _appBarLen) {
    appBarLen = _appBarLen;
  }

  _BottomNavigationBarExampleState(this.appBarLen);

  final ScrollController _homeController = ScrollController();

  Widget _listViewBody() {
    return TabBarView(
      children: [
        NotificationListener(
            onNotification: (ScrollUpdateNotification note) {
              var scrollDelta = note!.scrollDelta!.toDouble();
              print(scrollDelta);
              if (scrollDelta > 0) {
                if (appBarLen > 0) {
                  setState(() {
                    appBarLen = appBarLen - scrollDelta > 0
                        ? appBarLen - scrollDelta
                        : 0;
                  });
                }
              } else {
                if (appBarLen < 50) {
                  setState(() {
                    appBarLen = appBarLen - scrollDelta > 50
                        ? 50
                        : appBarLen - scrollDelta;
                  });
                }
              }
              return true;
            },
            child: ListView.separated(
                controller: _homeController,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Text(
                      'Item $index',
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      thickness: 1,
                    ),
                itemCount: 50)),
        const Center(
          child: Text("tabBarView   2222222222222222"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarLen,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Expanded(
                child: Text(
                  "为你推荐",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  "正在关注",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: [
          _listViewBody(),
          const Center(child: Text("11111111111111111111"))
        ][_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.open_in_new_rounded),
              label: 'Open Dialog',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (int index) {
            switch (index) {
              case 0:
                // only scroll to top when current index is selected.
                if (_selectedIndex == index) {
                  _homeController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                }
              case 1:
                showModal(context);
            }
            setState(
              () {
                _selectedIndex = index;
              },
            );
          },
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
