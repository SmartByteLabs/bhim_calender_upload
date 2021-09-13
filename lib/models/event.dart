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
  DateType dateType;
  List<IElement> elements;
  DateTime actualDate,
      createdDate = DateTime.now(),
      updatedDate = DateTime.now();

  Event(this.uid, this.name, this.icon, this.description, this.dateType,
      this.elements, this.actualDate) {
    print("icon $icon");
    updatedDate = DateTime.now();
    if (uid == "") {
      uid = const Uuid().v4();
      createdDate = DateTime.now();
    }
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime(json['year'], json['month'], json['day']);
    if (json['icon'] == null) json['icon'] = "";
    DateType dateType = DateType.english;
    if (json['date_type'] == "hindu") dateType = DateType.hindu;
    List<IElement> elements = [];
    if (json['elements'] != null) {
      for (Map<String, dynamic> elem in json['elements']) {
        elements.add(IElement(type: elem['type'], detail: elem['details']));
      }
    }

    return Event(json['_id'], json['name'], json['icon'], json['description'],
        dateType, elements, dateTime);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> out = {
      'name': name,
      'description': description,
      'year': actualDate.year,
      'month': actualDate.month,
      'day': actualDate.day,
      'icon': icon,
      'date_type': dateType == DateType.hindu ? 'hindu' : 'english',
      'elements': []
    };

    for (IElement elem in elements) {
      out['elements']
          .add({'type': elem.type, 'details': elem.detail, 'id': elem.id});
    }

    return out;
  }
}

enum DateType { english, hindu }
