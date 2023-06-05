import 'package:firebase_auth/firebase_auth.dart';
import 'package:gather_handong/model/ChatRoom.dart';
import 'package:gather_handong/model/myUser.dart';

final user = FirebaseAuth.instance.currentUser;

checkDuplicated(myUser clickedUser){

  final
}

Future<List<ChatRoom>> getChatRoom async(){
  try{
    final snapshot =
        await _firestore.collection('ChatRoom').doc()
  }
}