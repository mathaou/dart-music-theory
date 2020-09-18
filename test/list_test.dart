import 'package:test/test.dart';
import '../scale/list.dart' as list;

void main() {
  test('', () {
    expect(list.toJson(list.scaleModeList), equals("""["Default (Major)","Minor","Major","Natural Minor","Diminished","Augmented","Melodic Minor Ascend","Melodic Minor Descend","Harmonic Minor","Ionian","Dorian","Phrygian","Lydian","Mixolydian","Aeolian","Locrian"]"""));
  });
}