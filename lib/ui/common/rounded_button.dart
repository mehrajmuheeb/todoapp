import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final Color color;
  final Color textColor;
  final bool hasIcon;

  const RoundedButton(
      {required this.title,
      required this.onClick,
      this.color = buttonColor,
      this.textColor = Colors.white,
      this.hasIcon = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          minimumSize:
              MaterialStateProperty.all<Size>(const Size.fromHeight(60)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(38.0),
            ),
          )),
      onPressed: () {
        onClick();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          hasIcon
              ? const Image(
              image: AssetImage("assets/images/ic_google.png"), width: 20,)
              : Container(),
          const SizedBox(
            width: 8,
          ),
          TextView(
            text: title,
            typeFace: TypeFace.normal,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
