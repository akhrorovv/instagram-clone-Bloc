import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/upload_page/upload_bloc.dart';
import '../bloc/upload_page/upload_event.dart';
import '../bloc/upload_page/upload_state.dart';

class MyUploadPage extends StatefulWidget {
  final PageController? pageController;

  const MyUploadPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  late UploadBloc uploadBloc;

  @override
  void initState() {
    super.initState();

    uploadBloc = BlocProvider.of<UploadBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state){
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
                  context.read<UploadBloc>().add(UploadPostEvent(widget.pageController!));
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
                          uploadBloc.showPicker(context);
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
                                padding: EdgeInsets.all(10),
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
      },
    );
  }
}
