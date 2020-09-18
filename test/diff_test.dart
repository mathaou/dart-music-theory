import '../note/class.dart';
import '../note/diff.dart';
import 'package:test/test.dart';

void main() {
  test('', () {
    expect(5, diff(Class.Cs, Class.Fs));
    expect(-5, diff(Class.Fs, Class.Cs));
    expect(2, diff(Class.Gs, Class.As));
    expect(-3, diff(Class.C, Class.A));
    expect(4, diff(Class.D, Class.Fs));
    expect(-6, diff(Class.F, Class.B));
  });
}