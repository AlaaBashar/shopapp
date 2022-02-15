import 'package:equatable/equatable.dart';

import '../../export_feature.dart';

abstract class ApiStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialState extends ApiStates {}

class LoginSuccessState extends ApiStates {
  final UserModel loginModel;

  LoginSuccessState({
    required this.loginModel,
  });
}

class ErrorState extends ApiStates {
  final String message;

  ErrorState({required this.message});
}

class LoadingState extends ApiStates {}
