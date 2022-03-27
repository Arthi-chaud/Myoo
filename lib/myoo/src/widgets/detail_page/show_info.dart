import 'package:flutter/material.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';

/// A [Column] to list a [Movie]'s or [TVSeries]'s information
class ShowInfo extends StatelessWidget {
  /// Title of the item
  final String title;
  /// List of [Genre]s to describe the [Movie] or [TVSeries]
  final List<Genre> genres;
  /// Optional release date of the item
  final DateTime? releaseDate;
  /// Optional endDate of the item (if it's a [TVSeries])
  final DateTime? endDate;
  /// Name of the studio who produced the [Movie] or [TVSeries]
  final String? studio;
  const ShowInfo({Key? key, required this.title, required this.genres, required this.releaseDate, required this.studio, this.endDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500, height: 1.3, fontSize: 19
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(releaseDate != null
            ? releaseDate!.year.toString() + (studio != null ? ", $studio" : "")
            : studio ?? ""
          )
        ),
        if (genres.isNotEmpty) 
        ...[
          const Text("Genre:"),
          ...genres.take(3).map((genre) => Text("   • $genre"))
        ]
      ],
    );
  }
}
