import 'package:flutter/material.dart';

/// Buton with tap callback
/// Like [TextButton] with an icon, but disposed as column
class DetailPageIconButton extends StatelessWidget {
  /// The text below the icon
  final String label;
  /// The icon to display
  final IconData icon;
  /// Callback on button tap
  final void Function() onTap;

  const DetailPageIconButton({Key? key, required this.label, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    InkWell(
      onTap: onTap,
      radius: 20,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          Icon(icon, size: 20),
          Text(label)
        ],
      )
    );
}
