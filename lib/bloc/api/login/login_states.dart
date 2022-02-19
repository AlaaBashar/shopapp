import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../export_feature.dart';

abstract class LoginStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLoginState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel? loginModel;

  LoginSuccessState({
    this.loginModel,
  });

  LoginSuccessState copyWith({
    final UserModel? loginModel,

  }) {
    return LoginSuccessState(
      loginModel: loginModel ?? this.loginModel,
    );
  }

  @override
  List<Object?> get props => [loginModel,];
}

class ErrorState extends LoginStates {
  final String? message;

  ErrorState({required this.message});
}

class LoadingState extends LoginStates {}

// ignore: must_be_immutable
class PasswordVisibility extends LoginStates {
   IconData? suffixIcon = Icons.visibility;
   bool? isVisible = true;

  PasswordVisibility({
    this.suffixIcon,
    this.isVisible,
  });

  PasswordVisibility copyWith({
    IconData? suffixIcon ,
    bool? isVisible,
  }) {
    return PasswordVisibility(
      suffixIcon: suffixIcon ?? this.suffixIcon,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [isVisible,suffixIcon,];
}
