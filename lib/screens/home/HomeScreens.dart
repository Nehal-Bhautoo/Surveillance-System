import 'package:flutter/material.dart';
import 'package:breathing_collection/breathing_collection.dart';
import 'package:surveillence_app/screens/camera/VideoPlayerScreen.dart';
import 'package:surveillence_app/screens/connection/ConnectionScreen.dart';
import 'package:surveillence_app/screens/setting/SettingScreen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(45),
          topLeft: Radius.circular(45)
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF1C1C1D),
          currentIndex: _page,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bluetooth,
                color: Colors.white70,
              ),
              activeIcon: Icon(
                Icons.bluetooth,
                color: Color(0xFF6265FF),
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: BreathingGlowingButton(
                height: 30.0,
                width: 30.0,
                buttonBackgroundColor: Color(0xFF373A49),
                glowColor: Color(0xFF6265FF),
                icon: Icons.camera_alt_rounded,
                iconColor: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.white70,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Color(0xFF6265FF),
              ),
              title: Container(
                height: 0.0,
              ),
            )
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        children: <Widget>[
          TabbedAppBar(),
          VideoScreen(),
          SettingScreen(),
        ],
      ),
    );
  }
}