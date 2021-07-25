import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/config.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  Config config = Config();
  var _pages = [
    KeepAlivePage(child: HomeScreen()),
    KeepAlivePage(child: ExploreScreen()),
    //KeepAlivePage(child: SearchScreen(query: '',)),
    FavoriteScreen(),
    KeepAlivePage(child: SettingScreen())
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          if (_pageController.hasClients) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
            //_pageController.jumpToPage(index);
          }
        }),
        itemCornerRadius: 50.0,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text(config.bottomItems[0]),
            inactiveColor: DynamicTheme.of(context)!.themeId == 2
                ? Colors.grey[200]
                : Colors.grey[800],
            activeColor: Colors.purple[400],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.explore_outlined),
            title: Text(config.bottomItems[1]),
            inactiveColor: DynamicTheme.of(context)!.themeId == 2
                ? Colors.grey[200]
                : Colors.grey[800],
            activeColor: Colors.indigo[400],
          ),
          /* BottomNavyBarItem(
            icon: Icon(Icons.search_outlined),
            title: Text(config.bottomItems[2]),
            inactiveColor: Colors.black,
            activeColor: Colors.deepOrange[300],
          ), */
          BottomNavyBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            title: Text(config.bottomItems[3]),
            inactiveColor: DynamicTheme.of(context)!.themeId == 2
                ? Colors.grey[200]
                : Colors.grey[800],
            activeColor: Colors.orange[400],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings_outlined),
            title: Text(config.bottomItems[4]),
            inactiveColor: DynamicTheme.of(context)!.themeId == 2
                ? Colors.grey[200]
                : Colors.grey[800],
            activeColor: Colors.cyan[400],
          ),
        ],
      ),
    );
  }
}
