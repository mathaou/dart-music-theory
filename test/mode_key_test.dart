import '../key/mode.dart';
import 'package:test/test.dart';

void main() {
  group('', () {
    test('', () {
      var majorString = string(Mode.Major);
      var minorString = string(Mode.Minor);
      var nilString = string(Mode.Nil);
      expect(majorString, equals("Major"));
      expect(minorString, equals("Minor"));
      expect(nilString, equals("Nil"));
      // modes are enum so don't need to do the least check
    });
    test('', () {
      expect(Mode.Major, modeOf("Major"));
      expect(Mode.Major, modeOf("M"));
      expect(Mode.Major, modeOf("major"));

      expect(Mode.Minor, modeOf("Minor"));
      expect(Mode.Minor, modeOf("min"));
      expect(Mode.Minor, modeOf("m"));

      expect(Mode.Major, modeOf("joe")); // testing default
    });
  });
}