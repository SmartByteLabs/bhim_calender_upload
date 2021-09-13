import 'package:calender_uploader/models/event.dart';
import 'package:calender_uploader/provider/event.dart';
import 'package:calender_uploader/screen/event_form.dart';
import 'package:flutter/material.dart';

class ListElem extends StatelessWidget {
  final Event e;
  void Function() refresh;

  ListElem(this.e, this.refresh) : super(key: ObjectKey(e));

  onClick(BuildContext context) {
    print("redirecting for ${e.uid}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventForm(e.uid),
      ),
    ).then((value) => refresh());
  }

  Future<void> deleteItem() async {
    await EventAPIHandler.deleteElementByID(e.uid);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 3,
            spreadRadius: 1,
            color: Colors.black26,
          )
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                onClick(context);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    child: e.icon != "" ? Image.network(e.icon) : Text("I"),
                  ),
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5), child: Text(e.name)),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text(e.description)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                MaterialButton(
                  onPressed: deleteItem,
                  child: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
