/// Expression of the "accidental notes" as either Sharps or Flats
enum AdjSymbol {
  No,
  Sharp,
  Flat
}

/// the adjustment symbol (Sharp or Flat) that begins a given name (e.g. the Root of a chord, scale or key)
AdjSymbol adjSymbolBegin(String name) {
  if (_rgxSharpBegin.hasMatch(name)) {
    return AdjSymbol.Sharp;
  } else if (_rgxFlatBegin.hasMatch(name)) {
    return AdjSymbol.Flat;
  } else {
    return AdjSymbol.No;
  }
}

/// the adjustment symbol (Sharp or Flat) for a given name (e.g. of a chord, scale or key)
AdjSymbol adjSymbolOf(String name) {
  var numSharps = _rgxSharpIn.allMatches(name)?.length ?? 0;
  var numFlats = _rgxFlatIn.allMatches(name)?.length ?? 0;
  var numSharpish = _rgxSharpishIn.allMatches(name)?.length ?? 0;
  var numFlattish = _rgxFlattishIn.allMatches(name)?.length ?? 0;
  // sharp/flat has precedent over sharpish/flattish; overall default is sharp
  if (numSharps > 0 && numSharps > numFlats) {
    return AdjSymbol.Sharp;
  } else if (numFlats > 0) {
    return AdjSymbol.Flat;
  } else if (numSharpish > 0 && numSharpish > numFlattish) {
    return AdjSymbol.Sharp;
  } else if (numFlattish > 0) {
    return AdjSymbol.Flat;
  }

  return AdjSymbol.Sharp;
}

/*
Private
 */
final _rgxSharpIn =    RegExp(r'[♯#]|major');
final _rgxFlatIn =     RegExp(r'^F|[♭b]');
final _rgxSharpBegin = RegExp(r'^[♯#]');
final _rgxFlatBegin =  RegExp(r'^[♭b]');
final _rgxSharpishIn = RegExp(r'(M|maj|major|aug)');
final _rgxFlattishIn = RegExp(r'([^a-z]|^)(m|min|minor|dim)');
