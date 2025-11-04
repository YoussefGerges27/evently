import 'dart:developer';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/providers/user_provider.dart';
import 'package:evently_c16/ui/home/tabs/favorites_tab/FavoritesTab.dart';
import 'package:evently_c16/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_c16/ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently_c16/ui/home/tabs/profile_tab/ProfileTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    FavoritesTab(),
    ProfileTab(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEventScreen);
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/home.svg"),
            activeIcon: SvgPicture.asset("assets/images/home_selected.svg"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/map.svg"),
            activeIcon: SvgPicture.asset("assets/images/map_selected.svg"),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/heart.svg"),
            activeIcon: SvgPicture.asset("assets/images/heart_selected.svg"),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/user.svg"),
            activeIcon: SvgPicture.asset("assets/images/user_selected.svg"),
            label: 'Profile',
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
