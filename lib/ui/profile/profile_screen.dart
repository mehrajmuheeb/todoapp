import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/profile/profile_navigator.dart';
import 'package:base_flutter/ui/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen, ProfileViewModel>
    implements ProfileNavigator {

  @override
  void initState() {
    viewModel.setInitialData();
    super.initState();
  }

  @override
  AppBarWidget buildAppBar() {
    return AppBarWidget(scaffoldKey);
  }

  @override
  Widget buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(child: Consumer<ProfileViewModel>(
        builder: (_, __, ___) =>
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: viewModel.image.isEmpty
                    ? null
                    : NetworkImage(
                      viewModel.image ?? "",
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Hero(
                    tag: "name",
                    child: TextView(
                      text: viewModel.user?.name ?? "",
                      typeFace: TypeFace.bold,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
      ));
    });
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.profile;

  @override
  void loadPageData({value}) {}

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);

}
