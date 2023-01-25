import 'package:base_flutter/ui/common/progress_bar.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatefulWidget {
  final bool isLoading;
  final Widget button;

  const LoaderButton(this.isLoading, {required this.button, Key? key})
      : super(key: key);

  @override
  State<LoaderButton> createState() => _LoaderButtonState();
}

class _LoaderButtonState extends State<LoaderButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      duration: const Duration(milliseconds: 300),
      child: widget.isLoading ? ProgressBar() : widget.button,
    );
  }
}
