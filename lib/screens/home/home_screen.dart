import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/screens/home/tabs/fav_tab/fav_tab.dart';
import 'package:evently/screens/home/tabs/home_tab/home_tab.dart';
import 'package:evently/screens/home/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget>tabs=[
    HomeTab(),
    FavTab(),
    ProfileTab(),
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme=Theme.of(context);
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: (){}
     , child: Icon(Icons.add,color: Colors.white,size: 24,)
      ,backgroundColor:theme.colorScheme.primary ,
      shape: CircleBorder(),
      ) ,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(16),
        child: tabs[index],
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap:(value)=>setState(() {
          index=value;
        }) ,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          
        ), 
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.homeUnselected.svg(),
            activeIcon: Assets.icons.homeSelected.svg(),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.heartUnselected.svg(),
            activeIcon: Assets.icons.heartSelected.svg(),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.userUnselected.svg(),
            activeIcon: Assets.icons.userSelected.svg(),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
