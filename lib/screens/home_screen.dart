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
        return WillPopScope(
          onWillPop: () async{
            final shouldPop = await showMyDialog(context) ;
            return shouldPop;
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Home',
                ),
                actions: [
                  IconButton(
                    icon: Icon(HomeBloc.get(context).modeIcon),
                    onPressed: () {
                      HomeBloc.get(context).add(HomeChangeAppModeEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                     openNewPage(context,SearchScreen());
                    },
                  ),
                ],
              ),
              body: homeBloc.bottomNav[homeBloc.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
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
          ),
        );
      },
    );
  }


}