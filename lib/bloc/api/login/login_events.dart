import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class LoginEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEvent extends LoginEvents {
  final BuildContext context;
  final String path;
  final String email;
  final String password;

  LoginEvent({
    required this.context,
    required this.path,
    required this.email,
    required this.password,
  });




}

class SignOutEvent extends LoginEvents {}

class SignUpEvent extends LoginEvents {}

class PasswordVisibilityEvent extends LoginEvents{}