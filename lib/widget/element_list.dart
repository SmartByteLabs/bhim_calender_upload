import 'package:calender_uploader/models/element.dart';
import 'package:calender_uploader/widget/element.dart';
import 'package:flutter/material.dart';

class ElementListWidget extends StatelessWidget {
  List<IElement> elms;
  void Function(String id) onRemove;

  ElementListWidget(this.elms, this.onRemove);

  List<Widget> getElementWidgets() {
    List<Widget> out = [];
    for (IElement elm in elms) {
      out.add(
          ElementWidget(Key(elm.id), elm, () => onRemove(elm.id), (val) => {}));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        key: Key(elms.length.toString()),
        // onReorder: (oldIndex, newIndex) {},
        children: this.getElementWidgets(),
      ),
    );
  }
}
