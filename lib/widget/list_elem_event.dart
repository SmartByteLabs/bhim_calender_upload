import 'package:calender_uploader/models/event.dart';
import 'package:calender_uploader/screen/event_form.dart';
import 'package:flutter/material.dart';

class ListElem extends StatelessWidget {
  final Event e;

  ListElem(this.e);

  onClick(BuildContext context) {
    print("redirecting for ${e.uid}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventForm(e.uid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: () {
          onClick(context);
        },
        child: Container(
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
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                child: e.icon != "" ? Image.network(e.icon) : Text("I"),
              ),
              Column(
                children: [
                  Container(padding: EdgeInsets.all(5), child: Text(e.name)),
                  Container(
                      padding: EdgeInsets.all(5), child: Text(e.description)),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(5),
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
