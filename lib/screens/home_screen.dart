import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeBloc.get(context).add(HomeGetDataEvent(context: context));
    HomeBloc.get(context).add(HomeGetCategoriesDataEvent(context: context));
    HomeBloc.get(context).add(HomeGetFavorItemsDataEvent());
    HomeBloc.get(context).add(HomeGetProfileDataEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeBloc = HomeBloc.get(context);
        return Scaffold(
          appBar: AppBar(

            title: const Text(
              'Home Screen',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                 openNewPage(context,SearchScreen());
                },
              )
            ],
          ),
          body: homeBloc.bottomNav[homeBloc.currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              backgroundColor: Colors.transparent
            ),
            child: BottomNavigationBar(
              unselectedIconTheme: const IconThemeData(color: Colors.black,),
              showUnselectedLabels: true,
              fixedColor: Colors.black,
              selectedIconTheme: const IconThemeData(color: Colors.black),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.black,
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
