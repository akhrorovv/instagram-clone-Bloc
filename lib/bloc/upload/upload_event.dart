import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();
}

class UploadPostEvent extends UploadEvent {
  String caption;
  File image;

  UploadPostEvent({required this.caption, required this.image});

  @override
  List<Object> get props => [];
}