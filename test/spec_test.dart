import 'package:test/test.dart';
import '../scale/scale.dart' as scale;
import '../scale/spec.dart' as spec;

void main() {
  test('', () {
    var c = scale.of("Cm769-5");
    var out = spec.toJson(c);
    expect(out, equals("""{"root":"C","tones":"{1: C, 2: D, 3: Eb, 4: F, 5: G, 6: Ab, 7: Bb}"}"""));
  });
}