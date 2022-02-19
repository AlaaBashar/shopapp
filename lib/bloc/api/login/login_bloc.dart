import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  IconData? suffixIcon = Icons.visibility;
  bool isVisible = true;

  LoginBloc(LoginStates initialState) : super(initialState) {
    on<LoginEvent>(_onLoginEvents);
    on<PasswordVisibilityEvent>(suffixVisibility);
  }

  static LoginBloc get(context) => BlocProvider.of(context);

  void _onLoginEvents(LoginEvent event, Emitter<LoginStates> emit) async {
    UserModel? loginModel;
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
      if (loginModel.status == true) {
        debugPrint(loginModel.data!.toJson().toString());
        showToast(
          text: '${loginModel.message}',
          textColor: Colors.white,
          backgroundColor: Colors.greenAccent,
        );
        CacheHelper.saveData(key: 'loginSuccess', value: loginModel.data!.token);
        openNewPage(event.context, const HomeScreen(),popPreviousPages: true);
        emit(LoginSuccessState().copyWith(loginModel: loginModel,),);
      } else {
        showToast(
          text: '${loginModel.message}',
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (error) {
      emit(ErrorState(message: error.toString()));
      debugPrint(error.toString());
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

  void suffixVisibility(
      PasswordVisibilityEvent? event, Emitter<LoginStates>? emit) {
    isVisible = !isVisible;
    suffixIcon = isVisible ? Icons.visibility_outlined : Icons.visibility_off;
    emit!(PasswordVisibility(suffixIcon: suffixIcon, isVisible: isVisible));
  }
}
