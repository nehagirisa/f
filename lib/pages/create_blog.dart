import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_extensions/model/data.dart';

import 'package:firebase_extensions/pages/dashbord.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';


class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final ref = FirebaseFirestore.instance
      .collection('text_documents')
      .withConverter<DataModel>(
        fromFirestore: (snapshot, _) => DataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (model, _) => model.toJson(),
      );

  final TextEditingController _textController = TextEditingController(); 
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();

  @override
  void dispose() {
    _authorNameController.dispose();
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  String? docID;
  bool isItemSaved = false;
  String? imageUrl;
  
      
  String defaultImageUrl = 'https://img.freepik.com/free-icon/image_318-583412.jpg?t=st=1692377195~exp=1692377795~hmac=e989f89bef6470ad034148b3bfa2e89d3d39eaf1e09f2f7e238daa08c11b6b03';
 
  String selectedFile = '';
  late Uint8List selectedImageInBytes;

//pick image from gallary
  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      selectedFile = fileResult.files.first.name;
      fileResult.files.forEach((element) {
        setState(() {
          selectedImageInBytes = fileResult.files.first.bytes!;
        });
      });
    }
    print(selectedFile);
  }

  //upload image to firebase storage
  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('image')
          .child('/' + selectedFile);
      final metadata = firabase_storage.SettableMetadata(
        contentType: 'image/jpeg',
      );

      uploadTask = ref.putData(selectedImageInBytes, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();

      print(imageUrl);

      setState(() {});
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

//upload blog to firebase data base
  Future _uploadBlog() async {
    setState(() {
      isItemSaved = true;
    });
    String imageUrl = await _uploadFile();
    await ref
        .add(
      DataModel(
        text: _textController.text,
        title: _titleController.text,
        authorname: _authorNameController.text,
        ImageUrl: imageUrl,
      ),
      
    )
        .then((value) {
      setState(() {
        isItemSaved = false;
      });
      _authorNameController.clear();
      _textController.clear();
      _titleController.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => Dashboard())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  //image container
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    child: selectedFile.isEmpty
                        ? Image.network(
                            defaultImageUrl,
                            fit: BoxFit.fill,
                          )
                        : Image.memory(selectedImageInBytes),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // image picker and upload buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                             color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton.icon(
                          onPressed: () {
                            _selectFile(true);
                          },
                          icon: const Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Pick Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isItemSaved)
                    Container(
                      child: CircularProgressIndicator(),
                    ),
                  //text fieds
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      contentPadding: EdgeInsets.only(top: 15, left: 10),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _authorNameController,
                    decoration: const InputDecoration(
                      hintText: "Auther Name",
                      contentPadding: EdgeInsets.only(top: 15, left: 10),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 5, // <-- SEE HERE
                    maxLines: 50, // <-- SEE HERE
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Discription",
                      contentPadding:
                          EdgeInsets.only(top: 15, left: 10, bottom: 5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // upload button
                  Center(
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration:const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton.icon(
                          onPressed: () {
                            _uploadBlog();
                          },
                         icon: const Icon(
                            Icons.upload,
                            color: Colors.white,
                          ),
                          label: const Text("Upload",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
