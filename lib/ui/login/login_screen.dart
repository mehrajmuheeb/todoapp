import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/constants/colors.dart';
import 'package:base_flutter/constants/dimens.dart';
import 'package:base_flutter/constants/strings.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/data/network/status.dart';
import 'package:base_flutter/helpers/extensions/validator_extension.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/heading_widget.dart';
import 'package:base_flutter/ui/common/input_field.dart';
import 'package:base_flutter/ui/common/loader_button.dart';
import 'package:base_flutter/ui/common/rounded_button.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/login/login_navigator.dart';
import 'package:base_flutter/ui/login/login_view_model.dart';
import 'package:base_flutter/ui/login/widget/sign_up_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  final key = GlobalKey<FormState>();

  @override
  AppBarWidget? buildAppBar() {
    return null;
  }

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget buildBody() {
    final topMargin = MediaQuery.of(context).size.height / 3;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                child: Consumer<LoginViewModel>(
                  builder: (_, __, ___) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Lottie.asset("assets/json/login_animation.json",
                              height: constraints.maxHeight * 2 / 3),
                          const Positioned(
                            bottom: 40,
                            child: TextView(
                              text: "Create. Plan. Execute",
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: constraints.maxWidth/2,
                        child: LoaderButton(
                            viewModel.isLoggingIn,
                            button: RoundedButton(
                              title: 'Sign Up with Google',
                              hasIcon: true,
                              color: Colors.black,
                              textColor: Colors.white,
                              onClick: () {
                                viewModel.signInWithGoogle();
                              },
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.login;

  @override
  void loadPageData({value}) {}

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);

  Widget iconImage(String asset) {
    return Image(image: AssetImage(asset));
  }

  @override
  void onSignInSuccess() {
    onError("Logged In");
  }
}
