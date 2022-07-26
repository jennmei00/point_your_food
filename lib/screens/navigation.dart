import 'package:community_material_icon/community_material_icon.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/screens/diary/fodd_diary.dart';
import 'package:punkte_zaehler/screens/home.dart';
import 'package:punkte_zaehler/screens/point_calculator.dart';
import 'package:punkte_zaehler/screens/scale.dart';
import 'package:punkte_zaehler/screens/settings.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _page = 1;
  final List<Widget> _navScreens = [
    const Home(),
    const PointCalculator(fromSheet: false),
    const FoodDiary(),
    const Scale(),
    const Settings(),
  ];
  final List<Widget> _navTitles = [
    const Text('Home'),
    const Text('Punkterechner'),
    const Text('Tagebuch'),
    const Text('Wiegedaten'),
    const Text('Einstellungen'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0
          ? null
          : AppBar(
              title: _navTitles[_page],
            ),
      body: _navScreens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).primaryColor,
        items: <Widget>[
          Icon(
            CommunityMaterialIcons.home_account,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          Icon(
            CommunityMaterialIcons.calculator,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          Icon(
            CommunityMaterialIcons.notebook_edit,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          Icon(
            CommunityMaterialIcons.scale,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          Icon(
            CommunityMaterialIcons.cogs,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
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
