// Create a Configuration table
class LeseConfig {
  final int id;
  final String name;
  final String backgroundColor;
  final String textColor;
  final String vowelColor;
  final int fontSize;
  final String font;
  final int delay;
  final bool showSeparator;
  final bool highlightVowel;
  final bool randomWordOrder;
  final int maximumWords;
  final bool countWords;
  final int wordSet;

  const LeseConfig(
      {required this.id,
      required this.name,
      required this.backgroundColor,
      required this.textColor,
      required this.vowelColor,
      required this.fontSize,
      required this.font,
      required this.delay,
      required this.showSeparator,
      required this.highlightVowel,
      required this.randomWordOrder,
      required this.maximumWords,
      required this.countWords,
      required this.wordSet});
}

// A Word Class
class Word {
  final int id;
  final int setId;
  final String word;
  final String partialWord;

  const Word(
      {required this.id,
      required this.setId,
      required this.word,
      required this.partialWord});
  Map<String, dynamic> toMap() {
    return {'id': id, 'setId': setId, 'word': word, 'partialWord': partialWord};
  }

  @override
  String toString() {
    return '{$word}';
  }
}

// A Word set representation
class WordSet {
  final int id;
  final String name;
  final int level;

  const WordSet({required this.id, required this.name, required this.level});

  // construct from a map
  WordSet.fromMap(Map<String, dynamic> queryResult)
      : id = queryResult["id"],
        name = queryResult["name"],
        level = queryResult["level"];

  // coonvert to a map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'level': level};
  }
}
