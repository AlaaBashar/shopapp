import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc(HomeStates initialState) : super(initialState) {
    on<HomeChangeCurrentNveBottomEvent>(_onChangeIndexOfNav);
    on<HomeGetDataEvent>(_getHomeData);
    on<HomeGetCategoriesDataEvent>(_getCategoriesData);
    on<HomeChangeFavoritesDataEvent>(_changeFavorites);
    on<HomeGetFavorItemsDataEvent>(_getFavoritesData);
    on<HomeGetProfileDataEvent>(_getProfileData);
    on<HomeUpdateProfileDataEvent>(_updateProfileData);
    on<HomeChangeAppModeEvent>(_changeAppMode);
  }

  ///-----------------------------------------------------------------------------------------

  static HomeBloc get(context) => BlocProvider.of(context);

  ///-----------------------------------------------------------------------------------------

  int currentIndex = 0;
  List<Widget> bottomNav = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingScreen(),
  ];

  ///-----------------------------------------------------------------------------------------

  void _onChangeIndexOfNav(
      HomeChangeCurrentNveBottomEvent event, Emitter<HomeStates> emit) {
    currentIndex = event.index!;
    emit(HomeChangeBottomState()
        .copyWith(currentIndex: currentIndex, bottomNav: bottomNav));
  }

  ///-----------------------------------------------------------------------------------------
  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void _getHomeData(HomeGetDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'home',
        token: token,
      );
      homeModel = HomeModel.fromJson(response.data);
      homeModel!.data!.products!.forEach((element) {
        favorites!.addAll({
          element.id!: element.inFavorite!,
        });
      });
      emit(HomeSuccessDataState().copyWith(favorites: favorites));
    } catch (error) {
      emit(HomeDataErrorState(error: error.toString()));
    }
  }

  ///-----------------------------------------------------------------------------------------
  CategoriesModel? categoriesModel;

  void _getCategoriesData(
      HomeGetCategoriesDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'categories',
      );
      categoriesModel = CategoriesModel.fromJson(response.data);
      emit(HomeSuccessCategoriesState());
    } catch (error) {
      emit(HomeErrorCategoriesState(error: error.toString()));
    }
  }

  ///-----------------------------------------------------------------------------------------
  ChangeFavoritesModel? changeFavoritesModel;

  void _changeFavorites(
      HomeChangeFavoritesDataEvent? event, Emitter<HomeStates> emit) async {
    Response response;
    favorites![event!.id!] = !favorites![event.id!]!;

    emit(HomeChangeFavoritesState());
    try {
      response = await DioHelper.postData(
        path: 'favorites',
        data: {
          'product_id': event.id,
        },
        token: token,
      );
      changeFavoritesModel = ChangeFavoritesModel.fromJson(response.data);
      if (!changeFavoritesModel!.status!) {
        favorites![event.id!] = !favorites![event.id!]!;
      } else {
        add(HomeGetFavorItemsDataEvent());
      }
      showToast(
        text: '${changeFavoritesModel!.message}',
        textColor: Colors.white,
        backgroundColor: Colors.greenAccent,
      );
      emit(HomeSuccessFavoritesState()
          .copyWith(changeFavoritesModel: changeFavoritesModel));
    } catch (error) {
      if (!changeFavoritesModel!.status!) {
        favorites![event.id!] = !favorites![event.id!]!;
      }
      emit(HomeErrorFavoritesState(error: error.toString()));
      debugPrint(error.toString());
    }
  }

  ///-----------------------------------------------------------------------------------------
  FavoritesModel? favoritesModel;

  void _getFavoritesData(
      HomeGetFavorItemsDataEvent event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingFavoritesItemState());
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'favorites',
        token: token,
      );
      favoritesModel = FavoritesModel.fromJson(response.data);
      emit(
          HomeGetFavoritesItemState().copyWith(favoritesModel: favoritesModel));
    } catch (error) {
      emit(HomeErrorFavoritesItemState(error: error.toString()));
    }
  }

  ///-----------------------------------------------------------------------------------------
  UserModel? userModel;

  void _getProfileData(
      HomeGetProfileDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    emit(HomeLoadingGetProfileState());
    try {
      response = await DioHelper.getData(
        path: 'profile',
        token: token,
      );
      userModel = UserModel.fromJson(response.data);

      emit(HomeSuccessGetProfileState());
    } catch (error) {
      emit(HomeErrorGetProfileState(error: error.toString()));
    }
  }

  ///-----------------------------------------------------------------------------------------
  void _updateProfileData(
      HomeUpdateProfileDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    emit(HomeLoadingUpdateProfileDataState());
    try {
      response = await DioHelper.putData(
        path: 'update-profile',
        token: token,
        data: {
          'name': event.name,
          'email': event.email,
          'phone': event.phone,
        },
      );
      userModel = UserModel.fromJson(response.data);
      if (userModel!.status == true) {
        showToast(
          text: '${userModel!.message}',
          textColor: Colors.white,
          backgroundColor: Colors.greenAccent,
        );
        emit(HomeSuccessUpdateProfileDataState());
      } else {
        add(HomeGetProfileDataEvent());
        showToast(
          text: '${userModel!.message}',
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (error) {
      emit(HomeErrorGetFavoritesState(error: error.toString()));
    }
  }

  ///-----------------------------------------------------------------------------------------
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
  IconData? modeIcon = CacheHelper.getData(key: 'isDark') == true
      ? Icons.wb_sunny : Icons.brightness_3_outlined;

  void _changeAppMode(
      HomeChangeAppModeEvent event, Emitter<HomeStates> emit) async {
    isDark = !isDark!;
    modeIcon = isDark! ? Icons.wb_sunny : Icons.brightness_3_outlined;
    print('isDark---------------------------------------------------');
    print(isDark);
    await CacheHelper.saveData(key: 'isDark', value: isDark);
    emit(HomeSuccessChangeAppModeState().copyWith(isDark: isDark));
  }
}
