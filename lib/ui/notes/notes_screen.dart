import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/helpers/formatter.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/date_picker.dart';
import 'package:base_flutter/ui/common/text_view.dart';
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
    viewModel.selectedDate = widget.note?.date ?? "";
    viewModel.message = widget.note?.message ?? "";
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
                InkWell(
                  onTap: () {
                    showDatePickerDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        TextView(text: viewModel.selectedDate)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: InputFieldBorderless(
                        inputText: viewModel.message,
                        animated: false,
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
                    child: const Icon(
                      Icons.check,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 20,
                )
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

  @override
  void onAddNotesSuccess() {
    pop();
  }

  Future<void> showDatePickerDialog() async {
    final date = DateTime.parse(viewModel.selectedDate);
    final selectedDate = await displayDatePicker(context);
    if(selectedDate == null) return;

    viewModel.updateSelectDate(getDate(selectedDate));
  }
}
