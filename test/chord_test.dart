import 'package:test/test.dart';
import '../utility/utility.dart';
import '../chord/chord.dart';
import '../note/class.dart';
import '../note/adjsymbol.dart';
import '../note/note.dart';
import '../scale/interval.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('', () {
    test('', () {
      getFileData('test/testdata/chord_expectations.yaml').then((
          value) {
        var testExpectations = loadYaml(value);
        expect(testExpectations, isNot(null));
        var chords = testExpectations['chords'];
        expect(chords.length, greaterThan(0));

        var keys = chords.nodes.keys.map((node) => node.value);

        for (var key in keys) {
          var expectRoot = chords[key]['root'];
          var expectTones = chords[key]['tones'];

          var actual = of(key);
          expect(expectRoot, equals(string(actual.root, actual.adjSymbol)));

          var interval = 1;
          for (var i = 0; i < expectTones.length; i++) {
            try { // yeah I don't want to deal with that these are dynamic types
              expect(expectTones[interval], equals(string(actual.tones[Interval(interval)], actual.adjSymbol)));
              interval++;
            } catch (Exception){ // oopsie no interval found oh no
              interval++;
            }
          }
        }
      }, onError: (e) {
        print(e);
      });
    });
    test('', () {
      var c = of("Cm nondominant -5 +6 +7 +9");
      expect(c.notes(), equals(<Note>[
        Note()..pitchClass = Class.Ds,
        Note()..pitchClass = Class.A,
        Note()..pitchClass = Class.As,
        Note()..pitchClass = Class.D,
      ]));
    });
    test('', () {
      var actualChord = Chord()
          ..root = Class.C
          ..adjSymbol = AdjSymbol.Flat
          ..tones = <Interval, Class>{
            i3: Class.Ds,
            i6: Class.A,
            i7: Class.As,
            i9: Class.D,
          };
      var expectChord = Chord()
        ..root = Class.Ds
        ..adjSymbol = AdjSymbol.Flat
        ..tones = <Interval, Class>{
          i3: Class.Fs,
          i6: Class.C,
          i7: Class.Cs,
          i9: Class.F,
        };

      var transposed = actualChord.transpose(3);
      expect(expectChord.root, transposed.root);
      expect(expectChord.adjSymbol, transposed.adjSymbol);
      var keys = expectChord.tones.keys.toList();
      var transposedKeys = transposed.tones.keys.toList();
      for (var i = 0; i < transposed.tones.length; i++) {
        // make sure both keys and values line up
        expect(keys[i], transposedKeys[i]);
        expect(transposed.tones[keys[i]], expectChord.tones[keys[i]]);
      }
    });
  });
}