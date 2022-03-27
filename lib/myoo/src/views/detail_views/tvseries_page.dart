import 'package:flutter/widgets.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';
import 'package:myoo/myoo/src/app_state.dart';
import 'package:myoo/myoo/src/widgets/detail_page/scaffold.dart';

/// View to display cuurentMovie of [AppState]
class TVSeriesPage extends StatelessWidget {
  const TVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPageScaffold(
      isLoading: (store) => store.state.currentTVSeries == null,
      builder: (context, store) {
        TVSeries tvSeries = store.state.currentTVSeries!;
        return Center(child: Text("Series: ${tvSeries.name}"));
      }
    );
  }
}
