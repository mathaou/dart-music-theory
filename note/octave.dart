/// models a musical octave
class Octave {
  final _rgxOctave = RegExp(r'(-?[0-9]+)$');
  int o = 0;

  Octave([String text]) {
    if (text != null && _rgxOctave.hasMatch(text)) {
      var match = _rgxOctave.firstMatch(text).group(1);
      o = int.parse(match);
    }
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Octave &&
      runtimeType == other.runtimeType &&
      o == other.o;

  @override
  int get hashCode => o.hashCode;
}