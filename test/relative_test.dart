import 'package:test/test.dart';
import '../key/key.dart';

void main() {
  group('', () {
    test('', () {
      var k = of("A minor");
      var expectRk = of("C major");
      expect(expectRk, equals(k.relativeMajor()));
    });
    test('', () {
      var k = of("C major");
      var expectRk = of("A minor");
      expect(expectRk, equals(k.relativeMinor()));
    });
  });
}