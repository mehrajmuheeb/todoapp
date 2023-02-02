import 'dart:collection';
import 'dart:developer';

import 'package:base_flutter/base/base_navigator.dart';
import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/constants/app_constants.dart';
import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/helpers/location/location_helper.dart';
import 'package:base_flutter/helpers/mixin/auth_mixin.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/helpers/service_locator.dart';
import 'package:base_flutter/main.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/dialogs/guest_user_error_dialog.dart';
import 'package:base_flutter/ui/common/drawer/app_drawer_widget.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class BaseState<W extends StatefulWidget, VM extends BaseViewModel>
    extends State<W> with AuthMixin implements BaseNavigator {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  VM viewModel = serviceLocator<VM>();

  String? currentLocation;
  String? addressLine1;
  String? pincode;
  double? latitude;
  double? longitude;

  bool isGuest = false;

  Widget buildBody();

  dynamic getNavigator();

  AppBarWidget? buildAppBar();

  PageIdentifier getPageIdentifier();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    loadPageData();
    if (getNavigator() != null) {
      viewModel.setNavigator(getNavigator());
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: provideOnWillPopScopeCallBack,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: appBgColor,
        //Sets custom AppBar Widget on Dashboard only
        drawer: getPageIdentifier() == PageIdentifier.dashboard
            ? AppDrawerWidget(
                onDrawerItemClick,
                isGuestUser: isGuest,
              )
            : null,

        //Sets AppBar based on the result from setAppBar()
        appBar: buildAppBar(),
        body: SafeArea(
          child: ChangeNotifierProvider(
            create: (_) => viewModel,
            child: buildBody(),
          ),
        ),
      ),
    );
  }

  setIsGuest(bool isGuest) {
    this.isGuest = isGuest;
  }

  void loadPageData({dynamic value});

  void push({required Widget widget}) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => widget))
        .then((value) => loadPageData());
  }

  //Clears the Backstack and starts a new screen
  void pushReplace({required Widget widget}) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (r) => false);
  }

  void pop({dynamic result}) {
    Navigator.of(context).pop();
  }


  Future<bool> provideOnWillPopScopeCallBack();

  Future<void> onDrawerItemClick(int position) async {
    switch (position) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:

        break;
      case 4:
        // launchUrl(Uri.parse(AppConstants.privacyPolicy),
        //     mode: LaunchMode.platformDefault);
        break;
      case 5:
        break;
      case 6:
        break;
    }
  }

  @override
  void onError(String message) {
    if (message.contains("401")) {
      onSessionTimedOut();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: TextView(
        text: message,
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: TextView(
        text: message,
        color: textColorPrimary,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
    ));
  }

  void showAppBottomSheet(BuildContext context, Widget bottomSheet) {
    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (builder) => bottomSheet,
    );
  }

  void showSuccessDialog(BuildContext context, Widget dialog) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return dialog;
        });
  }

  void showGuestUserDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return const GuestUserErrorDialog();
        });
  }

  @override
  void onSessionTimedOut() {
    clearAuthToken();
    setIsLoggedIn(false);
    pushReplace(widget: const LoginScreen());
  }
}
