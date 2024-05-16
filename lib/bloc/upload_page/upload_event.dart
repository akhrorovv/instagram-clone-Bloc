import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UploadEvent extends Equatable {}

class UploadPostEvent extends UploadEvent {
  final PageController pageController;

  UploadPostEvent(this.pageController);

  @override
  List<Object?> get props => [];
}