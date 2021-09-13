import 'package:calender_uploader/models/event.dart';
import 'package:calender_uploader/provider/event.dart';
import 'package:calender_uploader/screen/event_form.dart';
import 'package:calender_uploader/widget/list_elem_event.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() {
    print("refreshing list");
    return _EventListState();
  }
}

class _EventListState extends State<EventList> {
  List<Event> elems = [];

  Future<void> getdata() async {
    elems = await EventAPIHandler.getAllEvents();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("builing data");
    return FutureBuilder(
      future: getdata(),
      builder: builder,
    );
  }

  Widget builder(BuildContext ctx, AsyncSnapshot<dynamic> snp) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: ListView(
              children: [for (var elem in elems) ListElem(elem, refresh)],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (context) => EventForm(""),
                    ),
                  ).then((value) => setState(() {}));
                }),
          ),
        ],
      ),
    );
  }
}
