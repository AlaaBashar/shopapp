import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../export_feature.dart';


abstract class SearchStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialSearchState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  SearchModel? searchModel;

  SearchSuccessState({
    this.searchModel,
  });

  SearchSuccessState copyWith({
    SearchModel? searchModel,

  }) {
    return SearchSuccessState(
      searchModel: searchModel ?? this.searchModel,
    );
  }

  @override
  List<Object?> get props => [searchModel,];

}

class SearchErrorState extends SearchStates {
  final String? error;

  SearchErrorState({this.error});
}
