import 'dart:io';
import 'package:calender_uploader/models/element.dart';
import 'package:calender_uploader/models/event.dart';
import 'package:calender_uploader/utils/form.dart';
import 'package:calender_uploader/widget/element.dart';
import 'package:calender_uploader/widget/element_list.dart';
import 'package:calender_uploader/widget/image_selector.dart';
import 'package:calender_uploader/widget/month_day_dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class EventForm extends StatefulWidget {
  String id = "";

  EventForm(this.id);

  @override
  _EventFormState createState() {
    return _EventFormState();
  }
}

class _EventFormState extends State<EventForm> {
  String textVal = "";
  DateTime d = DateTime(2020, 12, 11);

  Event e =
      Event("", "Name", "", "description", DateType.english, [], 11, 12, 2020);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: d,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != d) {
      setState(() {
        d = picked;
        e.day = d.day;
        e.month = d.month;
        e.year = d.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (e.icon != "") Image.network(e.icon);
    return Stack(
      children: [
        Container(
          height: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ImageSelector(e.icon, (icon) {
              //   e.icon = icon;
              //   // setState(() {});
              // }),
              Expanded(
                // color: Colors.grey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: getLabelDecoration("Name"),
                              controller: TextEditingController(text: e.name),
                              onChanged: (value) {
                                e.name = value;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: getLabelDecoration("Description"),
                              controller:
                                  TextEditingController(text: e.description),
                              onChanged: (value) {
                                e.description = value;
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                MaterialButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text("${d.toLocal()}".split(' ')[0]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ElementListWidget(e.elements, removeElement),
                          )
                        ],
                      ),
                    ),
                    // height: 2000,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
              child: Icon(Icons.add), onPressed: () => addField(context)),
        ),
      ],
    );
  }

  void removeElement(String id) {
    setState(() {
      int i = e.elements.indexWhere((element) => element.id == id);
      e.elements.removeAt(i);
    });
  }

  void addField(BuildContext context) {
    String id = Uuid().v4();

    showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                width: 150,
                height: 150,
                child: Column(
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          e.elements.add(IElement(id: id, type: "text"));
                          Navigator.pop(context);
                        }),
                        child: Text("Add Text"),
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          e.elements.add(IElement(id: id, type: "image"));
                          Navigator.pop(context);
                        }),
                        child: Text("Add Image"),
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          e.elements.add(IElement(id: id, type: "video"));
                          Navigator.pop(context);
                        }),
                        child: Text("Add Video"),
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ));
  }
}
