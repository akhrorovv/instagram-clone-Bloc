import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/post_model.dart';
import '../../services/db_service.dart';
import '../../services/file_service.dart';
import 'upload_event.dart';
import 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitialState()) {
    on<UploadPostEvent>((event, emit) {
      _uploadNewPost(event.pageController);
      emit(UploadPostState());
    });
  }

  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _uploadNewPost(PageController pageController) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (imageFile == null) return;
    _apiPostImage(pageController);
  }

  void _apiPostImage(PageController pageController) {
    emit(UploadLoadingState());

    FileService.uploadPostImage(imageFile!).then((downloadUrl) => {
          _resPostImage(downloadUrl, pageController),
        });
  }

  void _resPostImage(String downloadUrl, PageController pageController) {
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    _apiStorePost(post, pageController);
  }

  void _apiStorePost(Post post, PageController pageController) async {
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then((value) => {
          _moveToFeed(pageController),
        });
  }

  _moveToFeed(PageController pageController) {
    emit(UploadLoadingState());

    captionController.text = "";
    imageFile = null;
    pageController.animateToPage(
      0,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeIn,
    );
  }

  // upload image

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    imageFile = File(image!.path);
    emit(UploadImageState());
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    imageFile = File(image!.path);
    emit(UploadImageState());
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take Photo'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
