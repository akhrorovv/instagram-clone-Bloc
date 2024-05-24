abstract class UploadState {}

class UploadInitialState extends UploadState {}

class UploadLoadingState extends UploadState {}

class UploadSuccessState extends UploadState {}

class UploadFailureState extends UploadState {
  final String errorMessage;

  UploadFailureState(this.errorMessage);
}
