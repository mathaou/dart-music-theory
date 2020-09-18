import '../scale/mode.dart';
import '../scale/list.dart';
import '../scale/scale.dart';
import '../scale/interval.dart';
import '../note/class.dart';
import 'package:test/test.dart';

void main() {
  group('', () {
    test('test list all modes', () {
      expect(modes.length, scaleModeList.length);
    });
    test('mode match string', () {
      // TODO
    });
    test('', () {
      var c = of("CM");
      expect(c.tones, equals(<Interval, dynamic>{
        i1: Class.C,
        i2: Class.D,
        i3: Class.E,
        i4: Class.F,
        i5: Class.G,
        i6: Class.A,
        i7: Class.B,
      }));
    });
  });
}