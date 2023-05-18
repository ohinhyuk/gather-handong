import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/controller/FirebaseController.dart';
import 'package:image_picker/image_picker.dart';

import 'model/product.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPage createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  final firebaseRef = FirebaseStorage.instance.ref();

  var uploadImageUrl = 'https://handong.edu/site/handong/res/img/logo.png';
  // _pickedFile;
  // _selectedImage = "";
  // final ImagePicker picker = ImagePicker();

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //     final pickedImage = ImagePicker().pickImage(source: ImageSource.gallery);/
    //     final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    //     print(image);s
    //   setState(() {
    //     _selectedImage = image.path;
    //   });

    if (image?.path == null) return null;

    final ref = firebaseRef.child('product_image').child(image!.name);

    await ref.putFile(File(image!.path));
    // print("!!");
    //
    // print("!!");
    // print(ref.getDownloadURL().then((value) => print(value)));
    //
    // print(ref.getDownloadURL());
    setState(() {
      ref.getDownloadURL().then((value) => {uploadImageUrl = value});
    });
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> productRef;
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Add'),
          actions: [
            TextButton(
                onPressed: () => {
                      productRef = FirebaseFirestore.instance
                          .collection('products')
                          .doc(),
                      FirebaseController.add(Product(
                          id: productRef.id,
                          name: _nameController.text,
                          price: int.parse(_priceController.text),
                          description: _descriptionController.text,
                          imageUrl: uploadImageUrl,
                          likeUsers: [])),
                    },
                child: const Text('Save'))
          ],
        ),
        body: ListView(
          children: [
            Image.network(uploadImageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => _pickImage()

                    // final ImagePicker picker = ImagePicker();
                    // print(ImagePicker().pickImage(source: ImageSource.gallery)),
                    ,
                    icon: const Icon(Icons.camera_alt))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Product Name',
                    ),
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Price',
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
