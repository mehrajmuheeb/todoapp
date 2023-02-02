import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/helpers/formatter.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/dashboard/dashboard_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesItem extends StatefulWidget {
  final Notes note;
  final int index;
  final DashboardViewModel viewModel;
  final Function(Notes) onClick;

  const NotesItem(this.note,
      {required this.onClick,
      required this.index,
      required this.viewModel,
      Key? key})
      : super(key: key);

  @override
  State<NotesItem> createState() => _NotesItemState();
}

class _NotesItemState extends State<NotesItem> {
  late Notes note;
  late String dateTime;
  late DashboardViewModel viewModel;
  late int index;

  @override
  void initState() {
    note = widget.note;
    dateTime = getFormattedDate(note.timestamp ?? "");
    index = widget.index;
    viewModel = widget.viewModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextView(
                  text: "Deleting.....",
                  color: Colors.white,
                )),
          ],
        ),
      ),
      onDismissed: (_) {
        viewModel.notes.removeAt(index);
        viewModel.deleteNote(note);
      },
      child: InkWell(
        onTap: () {
          widget.onClick(note);

        },
        child: Card(
          color: Colors.grey.shade100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextView(
                        text: note.message ?? "",
                        typeFace: TypeFace.medium,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextView(
                            text: dateTime ?? "",
                            textAlign: TextAlign.end,
                            size: 10,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedDate(String timestamp) {
    var dateTime = DateTime.parse(timestamp);
    return formatDate(dateTime);
  }
}
