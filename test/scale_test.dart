import 'package:test/test.dart';
import '../scale/scale.dart';
import '../scale/interval.dart';
import '../note/note.dart';
import '../note/class.dart';
import '../utility/utility.dart';

import 'package:yaml/yaml.dart';

void main() {
  group('', () {
    test('', () {
      getFileData('test/testdata/expectations.yaml').then((value) {
        var testExpectations = loadYaml(value);
        expect(testExpectations['scales'].length, greaterThan(0));
        var scales = testExpectations['scales'];
        var keys = scales.nodes.keys.map((node) => node.value);
        for (var key in keys) {
          var expectRoot = scales[key]['root'];
          var expectTones = scales[key]['tones'];
          var actual = of(key);
          expect(expectRoot, equals(string(actual.root, actual.adjSymbol)));
          for (var i = 1; i <= expectTones.length; i++) {
            expect(expectTones[i], string(actual.tones[Interval(i)], actual.adjSymbol));
          }
          // second for loop from original redundant is far as I can tell in Dart
        }
      }, onError: (e) {
        print(e);
      });
    });
    test('', () {
      var c = of("C natural minor");
      expect(<Note>[
        Note()..pitchClass = Class.C,
        Note()..pitchClass = Class.D,
        Note()..pitchClass = Class.Ds,
        Note()..pitchClass = Class.F,
        Note()..pitchClass = Class.G,
        Note()..pitchClass = Class.Gs,
        Note()..pitchClass = Class.As,
      ], c.notes());
    });
    test('', () {
    // TODO
    // key goes here
  //    var k =
    });
  });
}