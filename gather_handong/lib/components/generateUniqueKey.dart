import 'package:uuid/uuid.dart';

String generateUniqueKey() {
  var uuid = Uuid();
  return uuid.v4();
}
