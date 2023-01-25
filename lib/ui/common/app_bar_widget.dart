import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/ui/common/dialogs/guest_user_error_dialog.dart';
import 'package:base_flutter/ui/common/notification_dot_widget.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDashboard;
  final String title;
  final Widget? location;

  AppBarWidget(this.scaffoldKey,
      {this.title = "",
      this.isDashboard = false,
      this.location,
      Key? key})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: widget.isDashboard ? textColorPrimary : Colors.white,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  widget.isDashboard
                      ? widget.scaffoldKey.currentState!.openDrawer()
                      : Navigator.pop(context);
                },
                icon: Icon(
                  widget.isDashboard
                      ? Icons.menu
                      : Icons.arrow_back_ios_new_rounded,
                  color: widget.isDashboard ? Colors.white : Colors.black,
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                  alignment: Alignment.center,
                  child: widget.location ??
                      TextView(
                        text: widget.title,
                        weight: FontWeight.w400,
                        color: textColorPrimary,
                        size: 24,
                        typeFace: TypeFace.normalCondensed,
                        textAlign: TextAlign.center,
                      )),
            )),
            widget.isDashboard
                ? Stack(
                    children: [
                      IconButton(
                        onPressed: () async {

                        },
                        icon: const Icon(Icons.notifications_rounded),
                        color: Colors.white,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
