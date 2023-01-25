import 'package:base_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String topLine;
  final String bottomLine;

  const HeadingWidget(
      {required this.topLine, required this.bottomLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
            text: topLine,
            style: const TextStyle(
              fontFamily: "Messina_Cond_Bold",
              fontSize: 46,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                  text: "\n$bottomLine",
                  style: const TextStyle(
                    fontFamily: "Messina_Cond_Bold",
                    fontSize: 46,
                    fontWeight: FontWeight.w500,
                    color: textColorPrimary,
                  ))
            ]),
      ),
    );
  }
}
