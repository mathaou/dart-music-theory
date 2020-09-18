import '../note/class.dart';
import '../scale/interval.dart';
import 'package:test/test.dart';

void main() {
  group('', () {
    test('', () {
      expect(16, intervalOrder.length);
    });

    test('', () {
      var tones = <Interval, dynamic>{
        i2: Class.Ds,
        i5: Class.G,
        i7: Class.As
      };

      forAllIn(tones, (Class c) {
        expect(c, isNotNull);
      });
    });
  });
}