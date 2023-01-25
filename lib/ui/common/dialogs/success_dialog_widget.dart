import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/ui/common/button.dart';
import 'package:base_flutter/ui/common/rounded_button.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String btnLabel;
  final Function onClick;

  const SuccessDialog(
      {required this.title, this.description, required this.onClick, this.btnLabel = "Home", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: LayoutBuilder(
        builder: (context, constraints) => Wrap(
          children: [
            Container(
              height: 50,
            ),
            const Align(
                alignment: Alignment.center,
                child:
                    Image(image: AssetImage("assets/images/ic_success.png"))),
            Container(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.center,
                child: TextView(
                  text: title,
                  size: 30,
                  textAlign: TextAlign.center,
                  typeFace: TypeFace.boldCondensed,
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            description == null
            ? Container()
            : Align(
              alignment: Alignment.center,
              child: TextView(
                text: description ?? "",
                size: 18,
                color: color63,
                typeFace: TypeFace.normalCondensed,
              ),
            ),
            Container(
              height: description == null ? 0 : 40,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: constraints.maxWidth * 2 / 3,
                child: RoundedButton(
                    title: btnLabel, hasIcon: false, onClick: () {
                      onClick();
                }),
              ),
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
