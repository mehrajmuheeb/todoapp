import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/constants/strings.dart';
import 'package:base_flutter/ui/common/rounded_button.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class GuestUserErrorDialog extends StatelessWidget {
  const GuestUserErrorDialog({Key? key}) : super(key: key);

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
                child: Icon(Icons.wallet),
            ),
            Container(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.center,
                child: TextView(
                  text: heyThere,
                  size: 30,
                  textAlign: TextAlign.center,
                  typeFace: TypeFace.boldCondensed,
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            const Align(
              alignment: Alignment.center,
              child: TextView(
                text: signUpToUse,
                size: 18,
                color: color63,
                typeFace: TypeFace.normalCondensed,
              ),
            ),
            Container(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: constraints.maxWidth * 2 / 3,
                child: RoundedButton(
                    title: signUp,
                    hasIcon: false,
                    onClick: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Container()));
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
