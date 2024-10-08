import 'package:flutter/material.dart';
import 'package:flutter_api_test/src/features/album/view/albums_screen.dart';
import 'package:flutter_api_test/src/features/post/view/posts_screen.dart';
import 'package:flutter_api_test/src/features/todos_screen.dart';
import 'package:flutter_api_test/src/features/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: screens.length, vsync: this);
    super.initState();
  }

  var screens = [
    PostsScreen(),
    AlbumsScreen(),
    UserScreen(),
    ToDosScreen(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: (int? value) {
          setState(() {
            selectedIndex = value!;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.document_scanner,
              color: selectedIndex == 0
                  ? Color.fromARGB(255, 142, 108, 209)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.album,
              color: selectedIndex == 1
                  ? Color.fromARGB(255, 142, 108, 209)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.today,
                color: selectedIndex == 2
                    ? Color.fromARGB(255, 142, 108, 209)
                    : null,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 3
                    ? Color.fromARGB(255, 142, 108, 209)
                    : null,
              ),
              label: ''),
        ],
      ),
    );
  }
}
