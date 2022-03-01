import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../export_feature.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  IconData? suffixIcon = Icons.visibility;
  bool isVisible = true;

  RegisterBloc(RegisterStates initialState) : super(initialState) {
    on<RegisterEvent>(_onRegisterEvents);
    on<RegisterPasswordVisibilityEvent>(suffixVisibility);
  }

  static RegisterBloc get(context) => BlocProvider.of(context);

  void _onRegisterEvents(RegisterEvent event, Emitter<RegisterStates> emit) async {
    UserModel? registerModel;
    try {
      ProgressCircleDialog.show(event.context);
      Response response = await DioHelper.postData(
        path: event.path,
        data: {
          'email': event.email,
          'password': event.password,
          'name': event.name,
          'phone': event.phone,
        },
      );
      print('-------------------------fffff--------------------------------');
    registerModel = UserModel.fromJson(response.data);
      ProgressCircleDialog.dismiss(event.context);
      if (registerModel.status == true) {
        showToast(
          text: '${registerModel.message}',
          textColor: Colors.white,
          backgroundColor: Colors.greenAccent,
        );
        emit(RegisterSuccessState().copyWith(registerModel: registerModel,),);
      } else {
        showToast(
          text: '${registerModel.message}',
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (error) {
      emit(RegisterErrorState(message: error.toString()));
      debugPrint(error.toString());
    }

    // DioHelper.postData(
    //   path: event.path,
    //   data: {
    //     'email': event.email,
    //     'password': event.password,
    //   },
    // ).then((value) {
    //   RegisterModel = UserModel.fromJson(value.data);
    //   print(value.data);
    //   ProgressCircleDialog.dismiss(event.context);
    //   ShowToast.display(
    //     context: event.context,
    //     message: RegisterModel!.message,
    //     color: Colors.greenAccent,
    //     icon: Icons.check,
    //   );
    //   emit(RegisterSuccessState(RegisterModel: RegisterModel!));
    // }).catchError((error) {
    //   emit(ErrorState(message: error.toString()));
    // });
  }

  void suffixVisibility(RegisterPasswordVisibilityEvent? event, Emitter<RegisterStates>? emit) {
    isVisible = !isVisible;
    suffixIcon = isVisible ? Icons.visibility_outlined : Icons.visibility_off;
    emit!(RegisterPasswordVisibility(suffixIcon: suffixIcon, isVisible: isVisible));
  }
}
