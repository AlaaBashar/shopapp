import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ApiEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEvent extends ApiEvents {
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

class SignOutEvent extends ApiEvents {}

class SignUpEvent extends ApiEvents {}
