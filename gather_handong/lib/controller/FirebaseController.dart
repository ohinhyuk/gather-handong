import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gather_handong/model/product.dart';
import 'package:gather_handong/model/user.dart';

class FirebaseController {
  /// static accessors
  static get collection => FirebaseFirestore.instance.collection('products');
  static get ordered => collection.orderBy('price', descending: true);
  static get get => ordered.get();
  static get snapshots => ordered.snapshots();

  /// static methods
  // firebase query methods (add, update & delete)
  static void add(Product product) =>
      collection.doc(product.id).set(product.toJson());
  static void update(Product product) =>
      collection.doc(product.id).set(product.toJson());
  static void delete(String id) => collection.doc(id).delete();

  // static get collectionUser => FirebaseFirestore.instance.collection('users');
  static void userAdd(UserDB user) => FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set(user.toJson());
}
