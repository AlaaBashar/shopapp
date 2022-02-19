import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeBloc = HomeBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Screen'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                 openNewPage(context,const SearchScreen());
                },
              )
            ],
          ),
          body: homeBloc.bottomNav[homeBloc.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.indigo,
            ),
            child: BottomNavigationBar(
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              showUnselectedLabels: true,
              fixedColor: Colors.white,
              selectedIconTheme: const IconThemeData(color: Colors.blue),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                homeBloc.add(HomeChangeCurrentNveBottomEvent(index: index));
              },
              currentIndex: homeBloc.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
