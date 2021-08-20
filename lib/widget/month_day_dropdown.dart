import 'package:flutter/material.dart';

class MonthDayDropdown extends StatelessWidget {
  final int day;
  final int month;
  void Function(int, int) onChange;
  MonthDayDropdown(this.day, this.month, this.onChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: DropdownButton<String>(
              value: "$month",
              items:
                  <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((int value) {
                return DropdownMenuItem<String>(
                  value: '$value',
                  child: Text('$value'),
                );
              }).toList(),
              onChanged: (String? v) {
                if (v != "") {
                  int m = int.parse(v!);
                  onChange(day, m);
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: DropdownButton<String>(
              value: "$day",
              items: List<DropdownMenuItem<String>>.generate(
                31,
                (int i) => DropdownMenuItem<String>(
                  value: '${i + 1}',
                  child: Text('${i + 1}'),
                ),
              ),
              onChanged: (String? v) {
                if (v != "") {
                  if (v != "") {
                    int d = int.parse(v!);
                    onChange(d, month);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
