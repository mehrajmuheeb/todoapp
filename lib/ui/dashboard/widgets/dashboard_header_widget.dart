import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';

class DashboardHeaderWidget extends StatefulWidget {
  final DashboardViewModel _viewModel;
  final Function onClick;

  const DashboardHeaderWidget(this._viewModel, this.onClick, {Key? key})
      : super(key: key);

  @override
  State<DashboardHeaderWidget> createState() => _DashboardHeaderWidgetState();
}

class _DashboardHeaderWidgetState extends State<DashboardHeaderWidget> {
  String image = "";
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    image = widget._viewModel.user?.image ?? "";
    name = widget._viewModel.user?.name ?? "";

    return Row(
      children: [
        InkWell(
          onTap: () {
            widget.onClick();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: image.isEmpty
                ? null
                : NetworkImage(
                    image,
                  ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Hero(
          tag: "name",
          child: TextView(
            text: name,
            typeFace: TypeFace.medium,
            size: 16,
          ),
        )
      ],
    );
  }
}
