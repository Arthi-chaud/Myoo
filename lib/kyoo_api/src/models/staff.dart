import 'package:json_annotation/json_annotation.dart';
import 'package:myoo/kyoo_api/kyoo_api.dart';

part 'staff.g.dart';

typedef Staff = List<StaffMember>;

/// A Person who worked on a [TVSeries] or a [Movie]
/// They're identified by their name, their role and their type
@JsonSerializable()
class StaffMember extends IllustratedResource {

  /// The name of the role the [StaffMember] starred as
  final String? role;
  /// The type of the role the [StaffMember] took part as in the making of the [Movie]/[TVSeries]
  final String? type;
  StaffMember({
    required this.role,
    required this.type,
    required int id,
    required String slug,
    required String name,
    required String? poster,
  }): super(
    id: id,
    slug: slug,
    name: name,
    poster: poster,
    overview: '',
    thumbnail: null,
  );
  /// Unserialize [StaffMember] from [JSONData]
  factory StaffMember.fromJson(JSONData input) => _$StaffMemberFromJson(input);
}
