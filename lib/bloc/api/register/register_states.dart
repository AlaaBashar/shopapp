import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../export_feature.dart';

abstract class RegisterStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialRegisterState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
   UserModel? registerModel;

  RegisterSuccessState({
    this.registerModel,
  });

  RegisterSuccessState copyWith({
     UserModel? registerModel,

  }) {
    return RegisterSuccessState(
      registerModel: registerModel ?? this.registerModel,
    );
  }

  @override
  List<Object?> get props => [registerModel,];
}

class RegisterErrorState extends RegisterStates {
  final String? message;

  RegisterErrorState({required this.message});
}


class RegisterPasswordVisibility extends RegisterStates {
  IconData? suffixIcon = Icons.visibility;
  bool? isVisible = true;

  RegisterPasswordVisibility({
    this.suffixIcon,
    this.isVisible,
  });

  RegisterPasswordVisibility copyWith({
    IconData? suffixIcon ,
    bool? isVisible,
  }) {
    return RegisterPasswordVisibility(
      suffixIcon: suffixIcon ?? this.suffixIcon,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [isVisible,suffixIcon,];
}
