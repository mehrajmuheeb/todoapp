import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class DateRowWidget extends StatefulWidget {
  final DatePickerController? datePickerController;

  const DateRowWidget({this.datePickerController, Key? key}) : super(key: key);

  @override
  State<DateRowWidget> createState() => _DateRowWidgetState();
}

class _DateRowWidgetState extends State<DateRowWidget> {
  DatePickerController? datePickerController;
  @override
  void initState() {
    super.initState();
    datePickerController = widget.datePickerController;
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          DatePicker(
            DateTime(DateTime.now().year),
            initialSelectedDate: DateTime.now(),
            controller: datePickerController,
            selectionColor: Colors.black,
            monthTextStyle: const TextStyle(color: Colors.white),
            width: constraints.maxWidth / 7,
            onDateChange: (date) {
              setState(() {
                datePickerController?.animateToDate(date,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              });
            },
          ),
    );
  }
}
