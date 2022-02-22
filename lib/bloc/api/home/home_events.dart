import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeChangeCurrentNveBottomEvent extends HomeEvents {
  final int? index;

  HomeChangeCurrentNveBottomEvent({this.index});
}

class HomeGetDataEvent extends HomeEvents {
  final BuildContext context;

  HomeGetDataEvent({required this.context});
}

class HomeGetCategoriesDataEvent extends HomeEvents {
  final BuildContext context;

  HomeGetCategoriesDataEvent({required this.context});
}

class HomeChangeFavoritesDataEvent extends HomeEvents {
  final int? id;

  HomeChangeFavoritesDataEvent({
    this.id,
  });
}

class HomeGetFavoritesDataEvent extends HomeEvents {}
class HomeGetProfileDataEvent extends HomeEvents {}
