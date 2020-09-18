import '../note/adjsymbol.dart';
import '../note/class.dart';
import '../note/octave.dart';
import 'package:test/test.dart';

void main() {
  group('', () {
    /*
    nameOf
     */
    _testNameOf("C", Class.C, Octave("0"), "C", "C");
    _testNameOf("C#", Class.Cs, Octave("0"), "C#", "Db");
    _testNameOf("Cb", Class.B, Octave("-1"), "B", "B");
    _testNameOf("D", Class.D, Octave("0"), "D", "D");
    _testNameOf("D#", Class.Ds, Octave("0"), "D#", "Eb");
    _testNameOf("D♭", Class.Cs, Octave("0"), "C#", "Db");
    _testNameOf("E", Class.E, Octave("0"), "E", "E");
    _testNameOf("E#", Class.F, Octave("0"), "F", "F");
    _testNameOf("E♭", Class.Ds, Octave("0"), "D#", "Eb");
    _testNameOf("F", Class.F, Octave("0"), "F", "F");
    _testNameOf("F#", Class.Fs, Octave("0"), "F#", "Gb");
    _testNameOf("F♭", Class.E, Octave("0"), "E", "E");
    _testNameOf("G", Class.G, Octave("0"), "G", "G");
    _testNameOf("G♯", Class.Gs, Octave("0"), "G#", "Ab");
    _testNameOf("Gb", Class.Fs, Octave("0"), "F#", "Gb");
    _testNameOf("A", Class.A, Octave("0"), "A", "A");
    _testNameOf("A#", Class.As, Octave("0"), "A#", "Bb");
    _testNameOf("Ab", Class.Gs, Octave("0"), "G#", "Ab");
    _testNameOf("B", Class.B, Octave("0"), "B", "B");
    _testNameOf("B#", Class.C, Octave("1"), "C", "C");
    _testNameOf("E♭", Class.Ds, Octave("0"), "D#", "Eb");
    _testNameOf("Bb", Class.As, Octave("0"), "A#", "Bb");
    _testNameOf("z", Class.Nil, Octave("0"), "-", "-");
    _testNameOf("zzzz", Class.Nil, Octave("0"), "-", "-");
    /*
    string
     */
    _testString();
    _testBaseNameOf();
  });
}

void _testBaseNameOf() {
  test('', () {
    expect(Class.C, baseNameOf("C# Major"));
    expect(Class.G, baseNameOf("GbM"));
    expect(Class.Nil, baseNameOf("XXX"));
    expect(Class.Nil, baseNameOf(""));
  });
}

void _testString() {
  test('', () {
    expect("C#", string(Class.Cs, AdjSymbol.Sharp));
    expect("Db", string(Class.Cs, AdjSymbol.Flat));
    expect("-", string(Class.Cs, AdjSymbol.No));
  });
}

void _testNameOf(String name, Class expectClass, Octave expectOctave, String expectStringSharp, String expectStringFlat) {
  test('', () {
    var result = nameOf(name);
    var o = result.item2;
    var c = result.item1;
    expect(expectOctave, equals(o));
    expect(expectClass, equals(c));
    expect(expectStringSharp, string(c, AdjSymbol.Sharp));
    expect(expectStringFlat, string(c, AdjSymbol.Flat));
  });
}