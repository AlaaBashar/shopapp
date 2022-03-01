import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class SearchEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchEvent extends SearchEvents {
  final String path;
  final String text;

  SearchEvent({
    required this.path,
    required this.text,
  });
}
