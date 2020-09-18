import 'package:test/test.dart';
import '../key/key.dart';

void main() {
  test('', () {
    expect(5, of("C#").diff(of("F#")));
    expect(-5, of("F#").diff(of("C#")));
    expect(2, of("Gb").diff(of("Ab")));
    expect(-3, of("C").diff(of("A")));
    expect(4, of("D").diff(of("F#")));
    expect(-6, of("F").diff(of("B")));
  });
}