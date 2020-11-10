// In music, a pitch class is a set of all pitches that are a whole number of
// octaves apart, e.g., the pitch class C consists of the Cs in all octaves.

import '../utility/utility.dart';
import 'adjsymbol.dart';
import 'octave.dart';

/// Class of pitch for a note (across all octaves)
enum Class { Nil, C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B }

/// a note will return its Class and Octave
Tuple<Class, Octave> nameOf(String text) {
  return step(baseNameOf(text), baseStepOf(text));
}

/// from a class to another class, +/- semitones, +/- octave
Tuple<Class, Octave> step(Class c, int inc) {
  return _stepFrom(c, inc);
}

/// of the note, expressed with Sharps or Flats
String string(Class c, AdjSymbol adj) {
  return _stringOf(c, adj);
}

/*
PRIVATE
 */

String _stringOf(Class c, AdjSymbol adj) {
  switch (c) {
    case Class.C:
      return "C";
    case Class.D:
      return "D";
    case Class.E:
      return "E";
    case Class.F:
      return "F";
    case Class.G:
      return "G";
    case Class.A:
      return "A";
    case Class.B:
      return "B";
  }

  if (adj == AdjSymbol.Sharp) {
    return _stringSharpOf(c);
  } else if (adj == AdjSymbol.Flat) {
    return _stringFlatOf(c);
  }

  return "-";
}

String _stringFlatOf(Class c) {
  switch (c) {
    case Class.Cs:
      return "Db";
    case Class.Ds:
      return "Eb";
    case Class.Fs:
      return "Gb";
    case Class.Gs:
      return "Ab";
    case Class.As:
      return "Bb";
  }

  return "-";
}

String _stringSharpOf(Class c) {
  switch (c) {
    case Class.Cs:
      return "C#";
    case Class.Ds:
      return "D#";
    case Class.Fs:
      return "F#";
    case Class.Gs:
      return "G#";
    case Class.As:
      return "A#";
  }

  return "-";
}

Class baseNameOf(String text) {
  if (text.length > 0) {
    switch (text.substring(0, 1)) {
      case "C":
        return Class.C;
      case "D":
        return Class.D;
      case "E":
        return Class.E;
      case "F":
        return Class.F;
      case "G":
        return Class.G;
      case "A":
        return Class.A;
      case "B":
        return Class.B;
      default:
        return Class.Nil;
    }
  }

  return Class.Nil;
}

int baseStepOf(String text) {
  if (text.length < 2) {
    return 0;
  }

  switch (adjSymbolBegin(text.substring(1))) {
    case AdjSymbol.Sharp:
      return 1;
    case AdjSymbol.Flat:
      return -1;
    default:
      return 0;
  }
}

Tuple<Class, Octave> _stepFrom(Class c, int inc) {
  if (inc > 0) {
    return _stepFromUp(c, inc);
  } else if (inc < 0) {
    return _stepFromDown(c, -inc);
  }

  return Tuple<Class, Octave>(item1: c, item2: Octave());
}

Tuple<Class, Octave> _stepFromUp(Class c, int inc) {
  var octave = Octave();
  for (var i = 0; i < inc; i++) {
    var shift = _stepUp[c];
    c = shift.name;
    octave.o += shift.octave.o;
  }

  return Tuple<Class, Octave>(item1: c, item2: octave);
}

Tuple<Class, Octave> _stepFromDown(Class c, int inc) {
  var octave = Octave();
  for (var i = 0; i < inc; i++) {
    var shift = _stepDown[c];
    c = shift.name;
    octave.o += shift.octave.o;
  }

  return Tuple<Class, Octave>(item1: c, item2: octave);
}

final _stepUp = {
  Class.Nil: _Step(Class.Nil, Octave()),
  Class.C: _Step(Class.Cs, Octave()),
  Class.Cs: _Step(Class.D, Octave()),
  Class.D: _Step(Class.Ds, Octave()),
  Class.Ds: _Step(Class.E, Octave()),
  Class.E: _Step(Class.F, Octave()),
  Class.F: _Step(Class.Fs, Octave()),
  Class.Fs: _Step(Class.G, Octave()),
  Class.G: _Step(Class.Gs, Octave()),
  Class.Gs: _Step(Class.A, Octave()),
  Class.A: _Step(Class.As, Octave()),
  Class.As: _Step(Class.B, Octave()),
  Class.B: _Step(Class.C, Octave()..o = 1)
};

final _stepDown = {
  Class.Nil: _Step(Class.Nil, Octave()),
  Class.C: _Step(Class.B, Octave()..o = -1),
  Class.Cs: _Step(Class.C, Octave()),
  Class.D: _Step(Class.Cs, Octave()),
  Class.Ds: _Step(Class.D, Octave()),
  Class.E: _Step(Class.Ds, Octave()),
  Class.F: _Step(Class.E, Octave()),
  Class.Fs: _Step(Class.F, Octave()),
  Class.G: _Step(Class.Fs, Octave()),
  Class.Gs: _Step(Class.G, Octave()),
  Class.A: _Step(Class.Gs, Octave()),
  Class.As: _Step(Class.A, Octave()),
  Class.B: _Step(Class.As, Octave())
};

class _Step {
  Class name;
  Octave octave;

  _Step(Class c, Octave octave) {
    name = c;
    this.octave = octave;
  }
}
