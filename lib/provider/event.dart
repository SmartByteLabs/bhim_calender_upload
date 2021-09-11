import 'dart:convert';

import 'package:calender_uploader/models/event.dart';
import 'package:http/http.dart' as http;

class EventAPIHandler {
  static Future<Event> getEventByID(String id) async {
    Uri uri = Uri.parse("http://localhost:3000/api/v1/event/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body)['data']);
    }

    return Event("uid", "name", "icon", "description", DateType.hindu, [],
        DateTime.now());
  }
}
