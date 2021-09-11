import 'package:calender_uploader/models/element.dart';
import 'package:calender_uploader/utils/form.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ElementWidget extends StatelessWidget {
  IElement e;
  Key key;
  void Function() onRemove;
  void Function(String) onChange;

  ElementWidget(
    this.key,
    this.e,
    this.onRemove,
    this.onChange,
  );

  String getLabelName() {
    switch (e.type) {
      case "video":
        return "Video URL";
      case "image":
        return "Image URL";
      case "text":
        return "Enter Text";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: e.detail,
                  style: const TextStyle(color: Colors.black),
                  decoration: getLabelDecoration(getLabelName()),
                  onChanged: onChange,
                ),
              ),
              Container(
                child: removeButton(),
              )
            ],
          ),
          (e.type == "video" && e.detail != "")
              ? Container(
                  color: Colors.amber,
                  child: YoutubePlayer(
                    controller:
                        YoutubePlayerController(initialVideoId: e.detail),
                    showVideoProgressIndicator: true,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget removeButton() {
    return Container(
      width: 30,
      alignment: Alignment.center,
      child: MaterialButton(
          child: const Icon(
            Icons.remove_circle_outline_sharp,
            color: Colors.redAccent,
          ),
          onPressed: onRemove),
    );
  }
}
