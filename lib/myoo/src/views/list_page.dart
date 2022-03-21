import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/poster_tile.dart';

/// Page to list all libraries and their content from a server
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PosterTile(
          imageURL: 'http://arthichaud.me/api/show/sophie-ellis-bextor-live-from-shepherds-bush-empire/poster2',
          title: '1001 Pattes et ses supers ami',
          subtitle: '2001'
        )
      )
    );
  }
}
