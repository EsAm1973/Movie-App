import 'package:flutter/material.dart';
import 'package:movie_app/presentation/screens/favorite_screen.dart';
import 'package:movie_app/presentation/screens/homepage_screen.dart';
import 'package:movie_app/presentation/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomepageScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: Container(
          color: theme.scaffoldBackgroundColor,
          height: 75,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: theme.navigationBarTheme.backgroundColor,
              selectedItemColor: theme.navigationBarTheme
                  .indicatorColor, // Use indicatorColor for selected items
              unselectedItemColor: theme.unselectedWidgetColor,

              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 28,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    size: 28,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_2_outlined,
                    size: 28,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
