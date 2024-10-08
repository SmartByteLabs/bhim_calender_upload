import 'package:calender_uploader/models/element.dart';
import 'package:calender_uploader/models/event.dart';
import 'package:calender_uploader/provider/event.dart';
import 'package:calender_uploader/utils/form.dart';
import 'package:calender_uploader/widget/element_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EventForm extends StatefulWidget {
  String id = "";

  EventForm(this.id);

  @override
  _EventFormState createState() {
    print("called create state with $id");
    return _EventFormState(id);
  }
}

class _EventFormState extends State<EventForm> {
  String textVal = "";
  Event e = Event("", "", "", "", DateType.english, [], DateTime.now());
  String id = "";

  _EventFormState(this.id);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: this.e.actualDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));

    if (picked != null && picked != e.actualDate) {
      setState(() {
        e.actualDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  Widget builder(BuildContext ctx, AsyncSnapshot<dynamic> s) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
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
                                decoration: getLabelDecoration("Icon"),
                                controller: TextEditingController(text: e.icon),
                                onChanged: (value) {
                                  e.icon = value;
                                },
                              ),
                            ),
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
                                    child: Text("${e.actualDate.toLocal()}"
                                        .split(' ')[0]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child:
                                  ElementListWidget(e.elements, removeElement),
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
            left: 10,
            bottom: 10,
            child: FloatingActionButton(
              heroTag: "save_btn",
              child: Text("Save"),
              onPressed: () => id == "" ? createEvent() : updateEvent(),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              heroTag: "add_btn",
              child: Icon(Icons.add),
              onPressed: () => addField(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getDate() async {
    if (id == "") return;
    print("fetching data for id $id");
    e = await EventAPIHandler.getEventByID(id);
  }

  Future<void> createEvent() async {
    await EventAPIHandler.createEvent(e);
    Navigator.pop(context);
  }

  Future<void> updateEvent() async {
    await EventAPIHandler.updateEvent(e);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (e.icon != "") Image.network(e.icon);
    return FutureBuilder(future: getDate(), builder: builder);
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
