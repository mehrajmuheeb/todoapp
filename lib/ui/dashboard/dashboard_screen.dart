import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/dialogs/create_note_dialog.dart';
import 'package:base_flutter/ui/common/dialogs/success_dialog_widget.dart';
import 'package:base_flutter/ui/dashboard/widgets/dashboard_header_widget.dart';
import 'package:base_flutter/ui/dashboard/widgets/date_row_widget.dart';
import 'package:base_flutter/ui/dashboard/widgets/note_item_widget.dart';
import 'package:base_flutter/ui/notes/notes_screen.dart';
import 'package:base_flutter/ui/profile/Profile_screen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_navigator.dart';
import 'dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends BaseState<DashboardScreen, DashboardViewModel>
    implements DashboardNavigator {

  final datePickerController = DatePickerController();
  @override
  void initState() {
    viewModel.setUserData();
    super.initState();
  }

  @override
  AppBarWidget? buildAppBar() {
    return null;
  }

  @override
  Widget buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: Consumer<DashboardViewModel>(
          builder: (_, __, ___) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/app_bg.jpg"), fit: BoxFit.fitHeight)
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Stack(
              children: [
                Column(children: [
                  DashboardHeaderWidget(viewModel, () {
                    push(widget: const ProfileScreen());
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  DateRowWidget(datePickerController: datePickerController,),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.notes.length,
                        itemBuilder: (context, position) => NotesItem(
                          viewModel.notes[position],
                          index: position,
                          viewModel: viewModel,
                          onClick: onListItemClick,
                        )),
                  )
                ]),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white60,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      push(widget: const NotesScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void showCreateNotesDialog({Notes? note}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (builder) {
          return CreateNoteDialog(note: note, onSubmit: onSubmitNoteClick,);
        });
  }
  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.dashboard;

  @override
  void loadPageData({value}) {
    viewModel.getNotes();

  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);

  @override
  void onAddNoteSuccess() {
    showSuccessDialog(
        context,
        SuccessDialog(
            title: "Notes added",
            onClick: () {
              pop();
            }));
  }

  onSubmitNoteClick(String note) {
    if(note.isEmpty) return;

    viewModel.addNotes(note);
    viewModel.addNoteToOfflineList(note);
  }

  onListItemClick(Notes note) {
    push(widget: NotesScreen(note: note));
  }

  @override
  void updateState() {
    datePickerController.animateToDate(DateTime.now());
  }
}
