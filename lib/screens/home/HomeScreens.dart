import 'package:flutter/material.dart';
import 'package:breathing_collection/breathing_collection.dart';

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
          backgroundColor: Colors.white,
          currentIndex: _page,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bluetooth,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.bluetooth,
                color: Color(0xFF3D41EF),
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
                glowColor: Color(0xFF3D41EF),
                icon: Icons.camera_alt_rounded,
                iconColor: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_to_photos_rounded,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.add_to_photos_rounded,
                color: Color(0xFF3D41EF),
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
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}