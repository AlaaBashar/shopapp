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

class HomeLoadingDataState extends HomeStates {}

class HomeSuccessDataState extends HomeStates {
  HomeModel? homeModel;

  HomeSuccessDataState({
    this.homeModel,
  });

  HomeSuccessDataState copyWith({
    HomeModel? homeModel,
  }) {
    {
      return HomeSuccessDataState(
        homeModel: homeModel ?? this.homeModel,
      );
    }
  }

  @override
  List<Object?> get props => [homeModel];
}
