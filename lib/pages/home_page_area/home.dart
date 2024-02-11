import 'package:flutter/material.dart';
import 'package:todo/pages/home_page_area/profile.dart';
import 'package:todo/pages/home_page_area/settings.dart';
import 'package:todo/pages/home_page_area/todo_list.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/theme/buttons/button_styles.dart';
import 'package:todo/theme/gradients.dart';
import 'package:todo/theme/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  static const List<Widget> _pagesList = <Widget>[
    Settings(),
    TodoList(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pagesList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.colors.darkPurple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_circle_rounded),
              label: "To-do list"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "Profile"
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.colors.darkPink,
        unselectedItemColor: AppTheme.colors.pinkWhite,
        onTap: _onItemTapped,
      ),
    );
  }
}