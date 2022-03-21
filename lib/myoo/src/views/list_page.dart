import 'package:flutter/material.dart';
import 'package:myoo/myoo/src/widgets/poster_tile.dart';

/// Page to list all libraries and their content from a server
class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 2,
          children: [
            for (var i = 1; i <= 50; i++)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: PosterTile(
                  imageURL: 'http://arthichaud.me/api/show/sophie-ellis-bextor-live-from-shepherds-bush-empire/poster2',
                  title: '1001 Pattes et ses supers amis',
                  subtitle: '2001'
                )
              )
          ],
        )
      )
    );
  }
}
