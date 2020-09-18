// A Note is used to represent the relative duration and pitch of a sound.
//
// https://en.wikipedia.org/wiki/Musical_note
//
// Credit
//
// Charney Kaye
// <hi@charneykaye.com>
// https://charneykaye.com
//
// Matthew Farstad (guy who ported it to Dart)
// <matthewwilliamfarstad@gmail.com>
// https://www.mfarstad.com
//
// XJ Music
// https://xj.io
//

import 'class.dart';
import 'octave.dart';

/// models a musical note
class Note {
  Class pitchClass;
  Octave octave = Octave(); // set as default for object-level comparisons

  String performer;
  double position;
  double duration;
  String code;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Note &&
      pitchClass == other.pitchClass &&
      octave == other.octave &&
      performer == other.performer &&
      duration == other.duration &&
      code == other.code;

  @override
  int get hashCode => pitchClass.hashCode ^
      octave.hashCode ^ performer.hashCode ^
      position.hashCode ^ duration.hashCode ^
      code.hashCode;
}

/// note returns a Note model
Note named(String text) {
  // First the name, including octave shift.
  // Class, Octave
  var result = nameOf(text);

  // Add originally named octave
  var newOctave = Octave(text);
  newOctave.o += result.item2.o;

  return Note()
      ..pitchClass = result.item1
      ..octave = newOctave;
}

/// pitch returns a Note model
Note ofClass(Class c) {
  return Note()
      ..pitchClass = c;
}

/// returns a pitch Class
Class classNamed(String text) {
  return named(text).pitchClass;
}
