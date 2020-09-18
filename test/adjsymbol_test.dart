import '../note/adjsymbol.dart';
import 'package:test/test.dart';

void main() {
  group('', (){
    testAdjSymbolOf();
    testAdjSymbolBegin();
  });
}

void testAdjSymbolOf() {
  test('Expect adjSymbol of an input string to match the sharpness or '
      'flattness its supposed to have', () {
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("C")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("CMb5b7")));
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("C#")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("Gb")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("G♭M")));
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("A#m")));
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("A♯M♯5")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("c minor")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("c dim")));
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("CM M9 m7")));
    expect(AdjSymbol.Flat, equals(adjSymbolOf("cm m9 M7")));
    expect(AdjSymbol.Sharp, equals(adjSymbolOf("C major")));
  });
}

void testAdjSymbolBegin() {
  test('', () {
    expect(AdjSymbol.No, equals(adjSymbolBegin("C".substring(1))));
    expect(AdjSymbol.No, equals(adjSymbolBegin("CMb5b7".substring(1))));
    expect(AdjSymbol.Sharp, equals(adjSymbolBegin("C#".substring(1))));
    expect(AdjSymbol.Flat, equals(adjSymbolBegin("Gb".substring(1))));
    expect(AdjSymbol.Flat, equals(adjSymbolBegin("G♭M".substring(1))));
    expect(AdjSymbol.Sharp, equals(adjSymbolBegin("A#m".substring(1))));
    expect(AdjSymbol.Sharp, equals(adjSymbolBegin("A♯M♯".substring(1))));
  });
}
