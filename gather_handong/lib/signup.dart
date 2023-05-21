
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/app.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  final firebaseRef = FirebaseStorage.instance.ref();

  var uploadImageUrl = 'https://handong.edu/site/handong/res/img/logo.png';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
        title: Text('SignUp'),
      ),
      body:Padding(
        padding: EdgeInsets.only(left: 30 , right: 30, top: 50, bottom: 50),
        child: ListView(
        children: [
          Image.asset('assets/images/logo_gather_handong.png'),
        ],
      ),
      )

    );
  }

}