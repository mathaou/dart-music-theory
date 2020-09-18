import '../note/class.dart';
import '../note/root.dart';
import 'package:test/test.dart';

void main() {
  group('', () {
    _assertRootAndRemaining("C", Class.C, "");
    _assertRootAndRemaining("Cmaj", Class.C, "maj");
    _assertRootAndRemaining("B♭min", Class.As, "min");
    _assertRootAndRemaining("C#dim", Class.Cs, "dim");
    _assertRootAndRemaining("JAMS", Class.Nil, "JAMS");
  });
}

void _assertRootAndRemaining(String fromChord, Class expectedRoot,
    String expectRemaining) {
  test('', () {
    var result = rootAndRemaining(fromChord);
    var root = result.item1;
    var remaining = result.item2;
    expect(expectedRoot, equals(root));
    expect(expectRemaining, equals(remaining));
  });
}