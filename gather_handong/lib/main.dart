import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gather_handong/app.dart';
import 'package:gather_handong/firebase_options.dart';
import 'package:gather_handong/model/product.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, child) => const App()));
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  List<Product> cart = [];
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  void addCart(Product product) {
    cart.add(product);
    notifyListeners();
  }

  void deleteCart(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  bool checkIsProduct(Product product) {
    for (var item in cart) {
      if (item.id == product.id) return true;
    }
    return false;
  }

  void changeLoggedIn(bool isLogined) {
    _loggedIn = isLogined;
    notifyListeners();
  }

  String sorting = 'ASC';

  void changeSorting(String? value) {
    // This is called when the user selects an item.

    sorting = value!;
    notifyListeners();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
