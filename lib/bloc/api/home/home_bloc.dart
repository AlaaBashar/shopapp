import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc(HomeStates initialState) : super(initialState) {
    on<HomeChangeCurrentNveBottomEvent>(_onChangeIndexOfNav);
    on<HomeGetDataEvent>(_getHomeData);
  }

  static HomeBloc get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomNav = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  void _onChangeIndexOfNav(
      HomeChangeCurrentNveBottomEvent event, Emitter<HomeStates> emit) {
    currentIndex = event.index!;
    emit(HomeChangeBottomState()
        .copyWith(currentIndex: currentIndex, bottomNav: bottomNav));
  }

  HomeModel? homeModel;
  void _getHomeData(HomeGetDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'home',
        token: token,
      );
      //debugPrint(response.data.toString());
      homeModel = HomeModel.fromJson(response.data);
      emit(HomeSuccessDataState());
    }
    catch (error) {
      emit(HomeDataErrorState(error: error.toString()));

    }
  }
}
