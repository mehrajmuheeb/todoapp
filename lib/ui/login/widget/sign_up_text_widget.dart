import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/constants/strings.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpTextWidget extends StatelessWidget {
  final Function(bool isSignUp) onClick;

  const SignUpTextWidget(this.onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onClick(true);
            },
            child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: notAMember,
                    style: TextStyle(
                      fontFamily: "Messina_Cond_Reg",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color63,
                    ),
                    children: [
                      TextSpan(
                          text: " $signUp",
                          style: TextStyle(
                            fontFamily: "Messina_Cond_Reg",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColorPrimary,
                          ),)
                    ])),
          ),
          InkWell(
            onTap: () {
              onClick(false);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextView(
                text: continueGuest,
                color: textColorPrimary,
                typeFace: TypeFace.normal,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
