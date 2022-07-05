import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/fodd_diary.dart';
import 'package:punkte_zaehler/home.dart';
import 'package:punkte_zaehler/point_calculator.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _page = 1;
  final List<Widget> _navScreens = [
    const Home(),
    const PointCalculator(),
    const FoodDiary(),
    const Home(),
  ];
  final List<Widget> _navTitles = [
    const Text('Home'),
    const Text('Punkterechner'),
    const Text('Tagebuch'),
    const Text('Einstellungen'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0 ? null : AppBar(
        title: _navTitles[_page],
      ),
      body: _navScreens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
          Icon(Icons.calculate, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
          Icon(Icons.calendar_month, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
          Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
        ],
        index: _page,
        onTap: (index) {
          //Handle button tap
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
