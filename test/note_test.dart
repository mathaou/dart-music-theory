import '../note/class.dart';
import '../note/note.dart';
import 'package:test/test.dart';

void main() {
  test('', () {
      expect(named("C"), Note()..pitchClass = Class.C);
      expect(ofClass(Class.C), Note()..pitchClass = Class.C);
      expect(classNamed("C"), Class.C);
  });
}