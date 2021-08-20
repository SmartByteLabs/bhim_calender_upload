import 'package:calender_uploader/models/element.dart';
import 'package:uuid/uuid.dart';

class Event {
  ///
  /// _id
  /// name
  /// icon
  /// description
  /// actual date
  /// repeat on = "english or gujarati"
  /// []elements
  /// date, month
  /// createdDate
  /// updatedDate

  String uid;
  String name;
  String icon;
  String description;
  DateTime actualDate;
  DateType dateType;
  List<IElement> elements;
  int date, month;
  DateTime createdDate = DateTime.now(), updatedDate = DateTime.now();

  Event(
    this.uid,
    this.name,
    this.icon,
    this.description,
    this.actualDate,
    this.dateType,
    this.elements,
    this.date,
    this.month,
  ) {
    updatedDate = DateTime.now();
    if (uid == "") {
      uid = const Uuid().v4();
      createdDate = DateTime.now();
    }
  }
}

enum DateType { english, vikram }
