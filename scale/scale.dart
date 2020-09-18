import '../note/adjsymbol.dart';
import '../note/class.dart';
import '../note/note.dart';
import '../note/root.dart';

import 'interval.dart';
import 'mode.dart';

class Scale {
  Class root;
  AdjSymbol adjSymbol;
  Map<Interval, dynamic> tones;

  List<Note> notes() {
    var notesList = <Note>[];
    forAllIn(this.tones, (Class c) {
      notesList.add(ofClass(c));
    });

    return notesList;
  }

  /// Build the scale by processing all Modes against the given name.
  void parseModes(String name) {
    for(var mode in modes) {
      if(mode.matchString(name)) {
        var toRemove = this.applyMode(mode);
        if (toRemove != null && toRemove.length > 0) {
          this.tones.removeWhere((key, value) => toRemove.contains(key));
        }
      }
    }
  }

  List<Interval> applyMode(Mode f) {
    var ct = 1; // type not as important in this case as it is the value
    this.tones[Interval(ct)] = this.root;
    for(var c in f.set) {
      ct++;
      var result = step(this.tones[Interval(ct - 1)], c);
      this.tones[Interval(ct)] = result.item1;
    }

    return f.omit; // augmented mode is the only one with omissions as far as I
                   // can tell
  }

  void parse(String name) {
    this.tones = Map<Interval, dynamic>();
    this.adjSymbol = adjSymbolOf(name);

    var result = rootAndRemaining(name);
    this.root = result.item1;
    name = result.item2;

    this.parseModes(name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Scale &&
              root == other.root &&
              adjSymbol == other.adjSymbol && tones == other.tones;

  @override
  int get hashCode => root.hashCode ^ adjSymbol.hashCode ^ tones.hashCode;
}

Scale of(String name) {
  return Scale()..parse(name);
}
