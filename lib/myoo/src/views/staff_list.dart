import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';
import 'package:myoo/myoo/src/theme_data.dart';
import 'package:myoo/myoo/src/widgets/poster.dart';

/// Horizontal, scrollable list of [Staff] members
class StaffList extends StatelessWidget {
  /// A List of [StaffMember]
  final Staff staff;
  const StaffList(this.staff, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scrollbar(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: staff.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 80,
                child: Poster(
                  height: 100,
                  titleSize: 10,
                  posterURL: staff[index].poster,
                  title: staff[index].name,
                  subtitle: staff[index].role ?? staff[index].type ?? '',
                ),
              );
            }),
      ),
    );
  }
}

/// Wrapper of [StaffList] in an [ExpandablePanel] widget
class ExpandableStaffList extends StatelessWidget {
    /// A List of [StaffMember]
  final Staff staff;
  const ExpandableStaffList(this.staff, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            iconColor: getColorScheme(context).onBackground,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            iconPlacement: ExpandablePanelIconPlacement.right,
          ),
          header: const Align(
            child: Text("Staff"),
            alignment: Alignment.centerRight
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: StaffList(staff),
          ),
        ),
      ),
    );
  }
}
