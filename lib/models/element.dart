import 'package:uuid/uuid.dart';

class IElement {
  String id = "";
  final String type;
  String detail;

  IElement({String id = "", this.type = "", this.detail = ""}) {
    if (id != "") {
      this.id = id;
    } else {
      this.id = const Uuid().v4();
    }
  }
}
