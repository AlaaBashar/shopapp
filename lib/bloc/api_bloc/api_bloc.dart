import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_feature.dart';

class ApiBloc extends Bloc<ApiEvents, ApiStates> {
  ApiBloc(ApiStates initialState) : super(initialState) {
    on<LoginEvent>(_onLoginEvents);
  }
  static ApiBloc get(context) => BlocProvider.of(context);

  void _onLoginEvents(event, Emitter<ApiStates> emit) async {
    UserModel? loginModel;
    if (event is LoginEvent) {
      try {
        ProgressCircleDialog.show(event.context);
        Response response = await DioHelper.postData(
          path: event.path,
          data: {
            'email': event.email,
            'password': event.password,
          },
        );
        loginModel = UserModel.fromJson(response.data);
        ProgressCircleDialog.dismiss(event.context);
        debugPrint(loginModel.data!.toJson().toString());
        ShowToast.display(
          context: event.context,
          message: loginModel.message,
          color: Colors.greenAccent,
          icon: Icons.check,
        );
        emit(LoginSuccessState(loginModel: loginModel));
      } catch (error) {
        emit(ErrorState(message: error.toString()));
      }

      // DioHelper.postData(
      //   path: event.path,
      //   data: {
      //     'email': event.email,
      //     'password': event.password,
      //   },
      // ).then((value) {
      //   loginModel = UserModel.fromJson(value.data);
      //   print(value.data);
      //   ProgressCircleDialog.dismiss(event.context);
      //   ShowToast.display(
      //     context: event.context,
      //     message: loginModel!.message,
      //     color: Colors.greenAccent,
      //     icon: Icons.check,
      //   );
      //   emit(LoginSuccessState(loginModel: loginModel!));
      // }).catchError((error) {
      //   emit(ErrorState(message: error.toString()));
      // });
    }
  }
}
