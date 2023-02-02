import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/dashboard/widgets/input_field_borderless.dart';
import 'package:base_flutter/ui/notes/notes_navigator.dart';
import 'package:base_flutter/ui/notes/notes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  final Notes? note;
  const NotesScreen({this.note, Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends BaseState<NotesScreen, NotesViewModel>
    implements NotesNavigator {

  @override
  void initState() {
    viewModel.note = widget.note;
    super.initState();
  }
  @override
  AppBarWidget buildAppBar() {
    return AppBarWidget(scaffoldKey);
  }

  @override
  Widget buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Consumer<NotesViewModel>(
          builder: (_, __, ___) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: InputFieldBorderless(
                        inputText: widget.note?.message ?? "",
                        onTextChange: (value) {
                          viewModel.message = value;
                        },
                        labelText: "Type something...",
                        validator: (value) {}),
                  ),
                ),
                FloatingActionButton(
                    backgroundColor: Colors.white60,
                    onPressed: () {
                  viewModel.createOrUpdate();
                },
                    child: const Icon(Icons.check, color: Colors.black,)),
                SizedBox(height: 20,)
              ],
            );
          },
        ),
      );
    });
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.notes;

  @override
  void loadPageData({value}) {}

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);
}
