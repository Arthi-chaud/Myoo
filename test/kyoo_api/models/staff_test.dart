import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoo/kyoo_api/src/models/staff.dart';
import 'package:myoo/kyoo_api/src/models/json.dart';

void main() {
  group('Staff', () {
    test('From JSON', () async {
      JSONData jsonLibrary = jsonDecode(await File('test/kyoo_api/assets/staff_member.json').readAsString());
      StaffMember staff = StaffMember.fromJson(jsonLibrary);

      expect(staff.id, 18469);
      expect(staff.slug, 'arnaud-leonard');
      expect(staff.name, "Arnaud Léonard");
      expect(staff.role, "Franz Hopper");
      expect(staff.type, "Actor");
      expect(staff.poster, "/api/people/arnaud-leonard/poster");
    });
  });
}
