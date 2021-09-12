import 'dart:convert';

import 'package:calender_uploader/models/event.dart';
import 'package:http/http.dart' as http;

class EventAPIHandler {
  static const String host = "http://localhost:3000";
  static Future<Event> getEventByID(String id) async {
    Uri uri = Uri.parse("$host/api/v1/event/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      return Event.fromJson(jsonDecode(response.body)['data']);
    }

    throw Exception(
        "not able to fetch data for given id $id: response from server is ${response.body} status code is ${response.statusCode}");
  }

  static Future<Event> createEvent(Event e) async {
    Uri uri = Uri.parse("$host/api/v1/event");
    String body = jsonEncode(e.toJson());
    print("calling server " + body);

    final response = await http.post(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    print("gettnig reponse from server");
    if (response.statusCode == 201) {
      dynamic respDecode = jsonDecode(response.body);
      print("created event with id ${respDecode['data']['id']}");
      return Event.fromJson(respDecode['data']);
    }

    throw Exception(
        "not able to save data $e: response from server is ${response.body} status code is ${response.statusCode}");
  }

  static Future<Event> updateEvent(Event e) async {
    Uri uri = Uri.parse("$host/api/v1/event/${e.uid}");
    String body = jsonEncode(e.toJson());
    print("calling server " + body);

    final response = await http.put(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
    print("gettnig reponse from server");
    if (response.statusCode == 201) {
      dynamic respDecode = jsonDecode(response.body);
      print("updated event with id ${respDecode['data']['id']}");
      return Event.fromJson(respDecode['data']);
    }

    throw Exception(
        "not able to save data $e: response from server is ${response.body} status code is ${response.statusCode}");
  }

  static Future<List<Event>> getAllEvents() async {
    Uri uri = Uri.parse("$host/api/v1/event");

    final response = await http.get(uri);
    print("gettnig reponse from server");
    if (response.statusCode == 200) {
      dynamic respDecode = jsonDecode(response.body);
      List<Event> out = [];
      for (Map<String, dynamic> elem in respDecode['data']) {
        out.add(Event.fromJson(elem));
      }
      return out;
    }

    throw Exception(
        "not able to fetch data: response from server is ${response.body} status code is ${response.statusCode}");
  }

  static Future<bool> deleteElementByID(String id) async {
    Uri uri = Uri.parse("$host/api/v1/event/$id");

    final response = await http.delete(uri);
    print("gettnig reponse from server");
    return response.statusCode == 201;
  }
}
