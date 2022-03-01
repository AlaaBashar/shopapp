import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterEvent extends RegisterEvents {
  final BuildContext context;
  final String path;
  final String email;
  final String password;
  final String phone;
  final String name;

  RegisterEvent({
    required this.context,
    required this.path,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });




}



class RegisterPasswordVisibilityEvent extends RegisterEvents{}