import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  IconData? suffixIcon = Icons.visibility;
  bool isVisible = true;

  SearchBloc(SearchStates initialState) : super(initialState) {
    on<SearchEvent>(_onSearchEvents);
  }

  static SearchBloc get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void _onSearchEvents(SearchEvent event, Emitter<SearchStates> emit) async {
    emit(SearchLoadingState());
    try {
      Response response = await DioHelper.postData(
        path: event.path,
        token: token,
        data: {
          'text':event.text,

          },
      );
      searchModel =SearchModel.fromJson(response.data);
      if(searchModel!.status == true) {
        emit(SearchSuccessState().copyWith(searchModel: searchModel));
      }
      else{
        showToast(
          text: '${searchModel!.message}',
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      }


    }
    catch (error) {
      emit(SearchErrorState(error: error.toString()));
    }
  }
}
