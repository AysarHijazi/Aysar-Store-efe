import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Add_screen.dart';
import 'Cart-Screen.dart';
import 'Search-Screen.dart';

import 'ProfileScreen.dart'; // استبدل ProfileScreen بصفحة الملف الشخصي

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    HomeScreen(),
    TrackScreen(),
    CartPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xff40e0d0),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? const Color(0xff40e0d0) : const Color(0xff818181),
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/heart.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? const Color(0xff40e0d0) : const Color(0xff818181),
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/location.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? const Color(0xff40e0d0) : const Color(0xff818181),
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? const Color(0xff23AA49) : const Color(0xff818181),
                BlendMode.srcIn,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
