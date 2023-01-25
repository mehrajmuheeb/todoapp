import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/helpers/mixin/auth_mixin.dart';
import 'package:base_flutter/ui/common/dialogs/guest_user_error_dialog.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

import 'drawer_header.dart';

const menuItems = {
  "Home": "assets/images/ic_home.png",
  "My Profile": "assets/images/ic_profile.png",
  "Notifications": "assets/images/ic_notification.png",
  "Change Password": "assets/images/ic_password_lock.png",
  "Privacy Policy": "assets/images/ic_privacy.png",
  "Terms & Conditions": "assets/images/ic_terms.png",
};

class AppDrawerWidget extends StatefulWidget {
  final Function(int position) onDrawerItemClick;
  final bool isGuestUser;

  const AppDrawerWidget(this.onDrawerItemClick, {required this.isGuestUser, Key? key})
      : super(key: key);

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> with AuthMixin {
  bool isGuest = false;
  @override
  void initState() {
    super.initState();
    isGuest = widget.isGuestUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: LayoutBuilder(
            builder: (context, constraints) =>
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  margin:
                  const EdgeInsets.only(
                      right: 26, left: 26, top: 40, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                        ),
                        const DrawerHead(),
                        Container(
                          height: 20,
                        ),
                        const SizedBox(height: 20),
                        getMenuList(widget.onDrawerItemClick),
                        const Spacer(),
                        logoutItem(widget.onDrawerItemClick),
                        const SizedBox(height: 30),
                      ]),
                ),
          )),
    );
  }

  Widget getMenuList(Function(int position) onDrawerItemClick) {
    return Column(children: getMenuItems(onDrawerItemClick));
  }

  List<Widget> getMenuItems(Function(int position) onDrawerItemClick) {
    var list = <Widget>[];
    int i = 0;
    menuItems.forEach((key, value) {
      list.add(getItem(key, value, i, onDrawerItemClick));
      i++;
    });

    return list;
  }

  Widget logoutItem(Function(int position) onDrawerItemClick) {
    if (isGuest) {
      return Container();
    } else {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
          onDrawerItemClick(6);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            children: const [
              Image(
                image: AssetImage("assets/images/ic_logout.png"),
                width: 18,
                height: 17,
              ),
              SizedBox(
                width: 10,
              ),
              TextView(
                text: "Logout",
                typeFace: TypeFace.boldCondensed,
                size: 17,
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget getItem(String name, String image, int position,
      Function(int position) onDrawerItemClick) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onDrawerItemClick(position);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Image(
              image: AssetImage(image),
              width: 18,
              height: 17,
            ),
            const SizedBox(
              width: 10,
            ),
            TextView(
              text: name,
              typeFace: TypeFace.boldCondensed,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}
