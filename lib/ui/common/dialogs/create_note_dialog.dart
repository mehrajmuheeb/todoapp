import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/ui/common/button.dart';
import 'package:base_flutter/ui/common/input_field.dart';
import 'package:base_flutter/ui/dashboard/widgets/input_field_borderless.dart';
import 'package:flutter/material.dart';

class CreateNoteDialog extends StatefulWidget {
  final Notes? note;
  final Function(String) onSubmit;

  const CreateNoteDialog({this.note, required this.onSubmit, Key? key})
      : super(key: key);

  @override
  State<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Dialog(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: LayoutBuilder(
          builder: (context, constraint) => Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                alignment: Alignment.bottomRight,
                child: const Icon(Icons.cancel),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: InputFieldBorderless(
                      inputText: widget.note?.message ?? "",
                      onTextChange: (value) {
                        message = value;
                      },
                      labelText: "Type something...",
                      validator: (value) {}),
                ),
              ),
              Button(
                  title: "Save",
                  onClick: () {
                    widget.onSubmit(message);
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
