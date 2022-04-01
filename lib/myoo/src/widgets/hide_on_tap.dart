import 'package:flutter/material.dart';

/// Widget that appears/fades on tap
class HideOnTap extends StatefulWidget {
  /// The Widget whose opacity will be messed with
  final Widget child;
  const HideOnTap({Key? key, required this.child}) : super(key: key);

  @override
  State<HideOnTap> createState() => _HideOnTapState();
}

class _HideOnTapState extends State<HideOnTap> {
  bool isVisible;

  _HideOnTapState(): isVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => isVisible = !isVisible),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: isVisible ? widget.child : IgnorePointer(child: widget.child),
      )
    );
  }
}
