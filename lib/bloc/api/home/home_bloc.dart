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
    on<HomeGetFavoritesDataEvent>(_getFavoritesData);
    on<HomeGetProfileDataEvent>(_getProfileData);

  }

  static HomeBloc get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomNav = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingScreen(),
  ];

  void _onChangeIndexOfNav(
      HomeChangeCurrentNveBottomEvent event, Emitter<HomeStates> emit) {
    currentIndex = event.index!;
    emit(HomeChangeBottomState()
        .copyWith(currentIndex: currentIndex, bottomNav: bottomNav));
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void _getHomeData(HomeGetDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'home',
        token: token,
      );
      //debugPrint(response.data.toString());
      homeModel = HomeModel.fromJson(response.data);

      homeModel!.data!.products!.forEach((element) {
        favorites!.addAll({
          element.id!: element.inFavorite!,
        });
      });
      emit(HomeSuccessDataState());
    } catch (error) {
      emit(HomeDataErrorState(error: error.toString()));
    }
  }

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

  ChangeFavoritesModel? changeFavoritesModel;

  void _changeFavorites(
      HomeChangeFavoritesDataEvent? event, Emitter<HomeStates> emit) async {
    Response response;
    favorites![event!.id!] = !favorites![event.id!]!;
    emit(HomeChangeFavoritesState().copyWith(favorites: favorites));
    try {
      response = await DioHelper.postData(
        path: 'favorites',
        data: {
          'product_id': event.id,
        },
        token: CacheHelper.getData(key: 'loginSuccess'),
      );
      changeFavoritesModel = ChangeFavoritesModel.fromJson(response.data);
      if (!changeFavoritesModel!.status!) {
        favorites![event.id!] = !favorites![event.id!]!;
      } else {
        add(HomeGetFavoritesDataEvent());
      }
      showToast(
        text: '${changeFavoritesModel!.message}',
        textColor: Colors.white,
        backgroundColor: Colors.greenAccent,
      );
      emit(HomeSuccessFavoritesState().copyWith(
          changeFavoritesModel: changeFavoritesModel, favorites: favorites));
    } catch (error) {
      if (!changeFavoritesModel!.status!) {
        favorites![event.id!] = !favorites![event.id!]!;
      }
      emit(HomeErrorFavoritesState(error: error.toString()));

      print(error.toString());
    }
  }

  FavoritesModel? favoritesModel;

  void _getFavoritesData(
      HomeGetFavoritesDataEvent event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingFavoritesItemState());
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'favorites',
        token: CacheHelper.getData(key: 'loginSuccess'),
      );
      favoritesModel = FavoritesModel.fromJson(response.data);
      emit(HomeGetFavoritesItemState());
    } catch (error) {
      emit(HomeErrorFavoritesItemState(error: error.toString()));
    }
  }

  UserModel? userModel;
  void _getProfileData(HomeGetProfileDataEvent event, Emitter<HomeStates> emit) async {
    Response response;
    try {
      response = await DioHelper.getData(
        path: 'profile',
        token: CacheHelper.getData(key: 'loginSuccess'),
      );
      userModel = UserModel.fromJson(response.data);
      emit(HomeSuccessGetProfileState());
    } catch (error) {
      emit(HomeErrorGetProfileState(error: error.toString()));
    }
  }
}