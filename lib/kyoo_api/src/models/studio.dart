import 'package:myoo/kyoo_api/src/models/json.dart';

extension StudioParsing on String {
  static String? fromJson(JSONData? input) => input?['name'];
}
