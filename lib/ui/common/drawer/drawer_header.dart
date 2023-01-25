import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class DrawerHead extends StatefulWidget {
  const DrawerHead({Key? key}) : super(key: key);

  @override
  State<DrawerHead> createState() => _DrawerHeadState();
}

class _DrawerHeadState extends State<DrawerHead> {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Image(image: AssetImage("assets/images/app_icon.png"),),
    );
  }
}
