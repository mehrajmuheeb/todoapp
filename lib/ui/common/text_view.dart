import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TypeFace {
  normal,
  bold,
  light,
  semiBold,
  normalCondensed,
  boldCondensed,
  lightCondensed,
  semiBoldCondensed,
}

class TextView extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TypeFace typeFace;
  final TextAlign textAlign;
  final bool underline;

  const TextView(
      {required this.text,
      this.color = Colors.black,
      this.size = 16,
      this.weight = FontWeight.w500,
      this.typeFace = TypeFace.normal,
      this.textAlign = TextAlign.start,
      this.underline = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: getFontFamily(),
          fontSize: size,
          fontWeight: weight,
          color: color,
          decoration: underline ? TextDecoration.underline : TextDecoration.none
        ));
  }

  String getFontFamily() {
    switch (typeFace) {
      case TypeFace.normal:
        return "Messina_Reg";
      case TypeFace.light:
        return "Messina_Light";
      case TypeFace.bold:
        return "Messina_Bold";
      case TypeFace.semiBold:
        return "Messina_Semi_Bold";
      case TypeFace.normalCondensed:
        return "Messina_Cond_Reg";
      case TypeFace.lightCondensed:
        return "Messina_Cond_Light";
      case TypeFace.boldCondensed:
        return "Messina_Cond_Bold";
      default:
        return "Messina_Reg";
    }
  }
}
