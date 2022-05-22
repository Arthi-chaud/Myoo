import 'dart:async';

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
  Timer? visibleTimer;

  @override
  void dispose() {
    visibleTimer?.cancel();
    super.dispose();
  }

  void unsetTimer() {
    visibleTimer?.cancel();
    visibleTimer = null;
  }

  void setTimer() {
    visibleTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => unsetTimer()
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isVisible = visibleTimer != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() {
        if (visibleTimer == null) {
          setTimer();
        } else {
          unsetTimer();
        }
      }),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: isVisible ? widget.child : IgnorePointer(child: widget.child),
      )
    );
  }
}
