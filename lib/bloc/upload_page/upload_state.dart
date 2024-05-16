import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {}

class UploadImageState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadPostState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadInitialState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadErrorState extends UploadState {
  final String message;

  UploadErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadLoadingState extends UploadState {
  @override
  List<Object?> get props => [];
}
