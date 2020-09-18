// The key of a piece is a group of pitches, or scale upon which a music composition is created in classical, Western art, and Western pop music.
//
// https://en.wikipedia.org/wiki/Key_(music)
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

import '../note/class.dart';
import '../note/root.dart';
import '../note/adjsymbol.dart';
import '../note/diff.dart' as note;
import 'mode.dart' as keyMode;

import 'mode.dart';

/// Key is a model of a musical key signature
class Key {
  Class root;
  AdjSymbol adjSymbol;
  keyMode.Mode mode;

  void _parse(String name) {
    this.adjSymbol = adjSymbolOf(name);

    var result = rootAndRemaining(name);
    this.root = result.item1;
    name = result.item2;

    parseMode(name);
  }

  void parseMode(String name) {
    this.mode = keyMode.modeOf(name);
  }

  int diff(Key targetKey) {
    return note.diff(this.root, targetKey.root);
  }

  Key relativeMinor() {
    var rk = Key()..mode=this.mode..adjSymbol=this.adjSymbol..root=this.root;
    if (rk.mode == Mode.Major) {
      rk.mode = Mode.Minor;
      rk.adjSymbol = AdjSymbol.Flat;
      var result = step(rk.root, -3);
      rk.root = result.item1;
    }

    return rk;
  }

  Key relativeMajor() {
    var rk = Key()..mode=this.mode..adjSymbol=this.adjSymbol..root=this.root;
    if (rk.mode == Mode.Minor) {
      rk.mode = Mode.Major;
      rk.adjSymbol = AdjSymbol.Sharp;
      var result = step(rk.root, 3);
      rk.root = result.item1;
    }

    return rk;
  }

  String toJson() {
    // note: this is pretty annoying to do in dart with the minimal yaml support
    // that exists, and jsonEncode only works with primitive data types. Makes
    // me sorely miss the 'ol %+v from Go.
    // i.e. I don't want to do this because I don't use it but if you need it
    // give it a go. I didn't do a test on this because w/e.
    //TODO
    return null;
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is Key &&
            other.root == root &&
            other.adjSymbol == adjSymbol &&
            other.mode == mode;

  @override
  int get hashCode => root.hashCode ^ adjSymbol.hashCode ^ mode.hashCode;
}

/// Of a particular key, e.g. Of("C minor 7")
Key of(String name) {
  return Key().._parse(name);
}
