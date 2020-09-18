import 'package:test/test.dart';
import 'package:yaml/yaml.dart';
import '../utility/utility.dart';
import '../key/key.dart';
import '../key/mode.dart';
import '../note/note.dart';
import '../note/class.dart';

void main() {
  group('', () {
    test('', () {
      getFileData('test/testdata/expectations.yaml').then((value) {
        var testExpectations = loadYaml(value);
        var scales = testExpectations['scales'];
        var keys = scales.nodes.keys.map((node) => node.value);
        expect(keys.length, greaterThan(0));
        for (var key in keys) {
          var expectRoot = scales[key]['root'];
          var actual = of(key);
          var expectMode = modeOf(key);
          expect(classNamed(expectRoot), actual.root);
          expect(expectMode, actual.mode);
        }
      }, onError: (e) {
        print(e);
      });
    });
    test('', () {
      var k = of("P-funk");
      expect(k.root, Class.Nil);
    });
  });
}