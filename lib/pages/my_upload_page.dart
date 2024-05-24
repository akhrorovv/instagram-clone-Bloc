import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/upload/image_picker_bloc.dart';
import '../bloc/upload/image_picker_event.dart';
import '../bloc/upload/upload_bloc.dart';
import '../bloc/upload/upload_event.dart';
import '../bloc/upload/upload_state.dart';

class MyUploadPage extends StatefulWidget {
  final PageController? pageController;

  const MyUploadPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  late UploadBloc uploadBloc;
  late ImagePickerBloc pickerBloc;
  var captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  _moveToFeed() {
    captionController.text = "";
    pickerBloc.add(ClearedPhotoEvent());
    widget.pageController!.animateToPage(0,
        duration: const Duration(microseconds: 200), curve: Curves.easeIn);
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    pickerBloc.add(SelectedPhotoEvent(image: File(image!.path)));
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    pickerBloc.add(SelectedPhotoEvent(image: File(image!.path)));
  }

  void _showPicker(context) {
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

  //
  _uploadNewPost() {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (pickerBloc.image == null) return;
    uploadBloc.add(UploadPostEvent(caption: caption, image: pickerBloc.image!));
  }

  @override
  void initState() {
    super.initState();

    uploadBloc = context.read<UploadBloc>();
    pickerBloc = context.read<ImagePickerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadBloc, UploadState>(
      listener: (context, state) {
        if (state is UploadSuccessState) {
          _moveToFeed();
        }
      },
      builder: (context, state) {
        if (state is UploadLoadingState) {
          return viewOfMyUploadPage(true);
        }
        if (state is UploadSuccessState) {
          return viewOfMyUploadPage(false);
        }
        return viewOfMyUploadPage(false);
      },
    );
  }

  Widget viewOfMyUploadPage(bool isLoading) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Upload",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _uploadNewPost();
            },
            icon: const Icon(
              Icons.drive_folder_upload,
              color: Color.fromRGBO(193, 53, 132, 1),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      color: Colors.grey.withOpacity(0.4),
                      child: uploadBloc.imageFile == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : Stack(
                              children: [
                                Image.file(
                                  uploadBloc.imageFile!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.black12,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            uploadBloc.imageFile = null;
                                          });
                                        },
                                        icon:
                                            const Icon(Icons.highlight_remove),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextField(
                      controller: uploadBloc.captionController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Caption",
                          hintStyle:
                              TextStyle(fontSize: 17, color: Colors.black38)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          uploadBloc.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
