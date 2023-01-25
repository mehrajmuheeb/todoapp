import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationDot extends StatelessWidget {
  const NotificationDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.red
      ),
      width: 10,
      height: 10,
    );
  }
}
