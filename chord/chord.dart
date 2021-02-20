// A chord, in music, is any harmonic set of three or more notes that is heard as if sounding simultaneously.
//
// https://en.wikipedia.org/wiki/Chord_(music)
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

// note: I found that a good chunk of the code in this module could be lifted
// straight from the scale module, so I didn't reinvent the wheel.

import '../note/class.dart';
import '../note/note.dart';
import '../note/root.dart';
import 'form.dart';
import '../note/adjsymbol.dart';
import '../scale/interval.dart' as scale; // to clarify

/// Chord in a particular key
class Chord {
  Class root;
  AdjSymbol adjSymbol;
  Map<scale.Interval, Class> tones;

  List<Note> notes() {
    var n = List<Note>();
    scale.forAllIn(tones, (Class c) => n.add(ofClass(c)));

    assert(n.length > 0);
    return n;
  }

  Chord transpose(int semitones) {
    var transposedChord = Chord()
      ..adjSymbol = this.adjSymbol
      ..tones = Map<scale.Interval, Class>()
      ..root = step(this.root, semitones).item1;

    this.tones.forEach((key, value) {
      transposedChord.tones[key] = step(value, semitones).item1;
    });

    return transposedChord;
  }

  void parseForms(String name) {
    // TODO: minmaj 7 failing
    var toDelete = <scale.Interval>[];
    forms.forEach((element) {
      if (element.pos == null || element.pos.hasMatch(name)) {
        var deletions = this.applyForm(element);
        deletions?.forEach((element) {
          toDelete.add(element);
        });
      }
    });

    toDelete.forEach((element) {
      this.tones.remove(element);
    });
  }

  List<scale.Interval> applyForm(Form f) {
    f.add?.forEach((key, value) {
      this.tones[key] = step(this.root, value).item1;
    });

    return f.omit;
  }

  void _parse(String name) {
    this.tones = Map<scale.Interval, Class>();
    this.adjSymbol = adjSymbolOf(name);

    var result = rootAndRemaining(name);
    this.root = result.item1;
    name = result.item2;

    this.parseForms(name);
  }
}

Chord of(String name) {
  return Chord().._parse(name);
}
