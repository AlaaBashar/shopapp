import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopapp/export_feature.dart';

abstract class HomeStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class HomeChangeBottomState extends HomeStates {
  int? currentIndex;
  List<Widget>? bottomNav;

  HomeChangeBottomState({
    this.currentIndex,
    this.bottomNav,
  });

  HomeChangeBottomState copyWith({
    int? currentIndex,
    List<Widget>? bottomNav,
  }) {
    return HomeChangeBottomState(
      currentIndex: currentIndex ?? this.currentIndex,
      bottomNav: bottomNav ?? this.bottomNav,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        bottomNav,
      ];
}

class InitialHomeState extends HomeStates {}

class HomeDataErrorState extends HomeStates {
  final String? error;

  HomeDataErrorState({this.error});
}

class HomeSuccessDataState extends HomeStates {
  HomeModel? homeModel;
  Map<int, bool>? favorites;

  HomeSuccessDataState({this.homeModel, this.favorites});

  HomeSuccessDataState copyWith({
    HomeModel? homeModel,
    Map<int, bool>? favorites,
  }) {
    {
      return HomeSuccessDataState(
        homeModel: homeModel ?? this.homeModel,
        favorites: favorites ?? this.favorites,
      );
    }
  }

  @override
  List<Object?> get props => [homeModel];
}

class HomeSuccessCategoriesState extends HomeStates {}

class HomeErrorCategoriesState extends HomeStates {
  final String? error;

  HomeErrorCategoriesState({this.error});
}

class HomeSuccessFavoritesState extends HomeStates {
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool>? favorites;

  HomeSuccessFavoritesState({
    this.changeFavoritesModel,
    this.favorites,
  });

  HomeSuccessFavoritesState copyWith(
      {ChangeFavoritesModel? changeFavoritesModel, Map<int, bool>? favorites}) {
    {
      return HomeSuccessFavoritesState(
          changeFavoritesModel:
              changeFavoritesModel ?? this.changeFavoritesModel,
          favorites: favorites ?? this.favorites);
    }
  }

  @override
  List<Object?> get props => [changeFavoritesModel, favorites];
}

class HomeChangeFavoritesState extends HomeStates {
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool>? favorites;

  HomeChangeFavoritesState({
    this.changeFavoritesModel,
    this.favorites,
  });

  HomeSuccessFavoritesState copyWith(
      {ChangeFavoritesModel? changeFavoritesModel, Map<int, bool>? favorites}) {
    {
      return HomeSuccessFavoritesState(
          changeFavoritesModel:
              changeFavoritesModel ?? this.changeFavoritesModel,
          favorites: favorites ?? this.favorites);
    }
  }

  @override
  List<Object?> get props => [changeFavoritesModel, favorites];
}

class HomeErrorFavoritesState extends HomeStates {
  final String? error;

  HomeErrorFavoritesState({this.error});
}

class HomeGetFavoritesItemState extends HomeStates {
  FavoritesModel? favoritesModel;

  HomeGetFavoritesItemState({
    this.favoritesModel,
  });

  HomeGetFavoritesItemState copyWith({
    FavoritesModel? favoritesModel,
  }) {
    {
      return HomeGetFavoritesItemState(
        favoritesModel: favoritesModel ?? this.favoritesModel,
      );
    }
  }

  @override
  List<Object?> get props => [favoritesModel];
}

class HomeLoadingFavoritesItemState extends HomeStates {}

class HomeErrorFavoritesItemState extends HomeStates {
  final String? error;

  HomeErrorFavoritesItemState({this.error});
}

class HomeSuccessGetProfileState extends HomeStates {}
class HomeLoadingGetProfileState extends HomeStates {}

class HomeErrorGetProfileState extends HomeStates {
  final String? error;

  HomeErrorGetProfileState({this.error});
}

class HomeLoadingGetFavoritesState extends HomeStates {}


class HomeLoadingUpdateProfileDataState extends HomeStates {}
class HomeRejectedUpdateProfileDataState extends HomeStates {}

class HomeSuccessUpdateProfileDataState extends HomeStates {}

class HomeErrorGetFavoritesState extends HomeStates {
  final String? error;

  HomeErrorGetFavoritesState({this.error});

}

class HomeSuccessChangeAppModeState extends HomeStates {
  bool? isDark;
  IconData? modeIcon;

  HomeSuccessChangeAppModeState({
   this.isDark,
    this.modeIcon,
  });

  HomeSuccessChangeAppModeState copyWith(
      {
        bool? isDark,
        IconData? modeIcon,

      })
  {
    {
      return HomeSuccessChangeAppModeState(
          isDark: isDark ?? this.isDark,
          modeIcon: modeIcon ?? this.modeIcon,

      );
    }
  }

  @override
  List<Object?> get props => [isDark,modeIcon];


}

