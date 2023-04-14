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
  final int showSeparator;
  final int highlightVowel;
  final int randomWordOrder;
  final int maximumWords;
  final int countWords;
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

  // Constructor from Map
  LeseConfig.fromMap(Map<String, dynamic> queryResult)
      : id = queryResult["id"],
        name = queryResult["name"],
        backgroundColor = queryResult["backgroundColor"],
        textColor = queryResult["textColor"],
        vowelColor = queryResult["vowelColor"],
        fontSize = queryResult["fontSize"],
        font = queryResult["font"],
        delay = queryResult["delay"],
        showSeparator = queryResult["showSeparator"],
        highlightVowel = queryResult["highlightVowel"],
        randomWordOrder = queryResult["randomWordOrder"],
        maximumWords = queryResult["maximumWords"],
        countWords = queryResult["countWords"],
        wordSet = queryResult["wordSet"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
      'vowelColor': vowelColor,
      'fontSize': fontSize,
      'font': font,
      'delay': delay,
      'showSeparator': showSeparator,
      'highlightVowel': highlightVowel,
      'randomWordOrder': randomWordOrder,
      'maximumWords': maximumWords,
      'countWords': countWords,
      'wordSet': wordSet
    };
  }
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

  Word.fromMap(Map<String, dynamic> queryResult)
      : id = queryResult["id"],
        setId = queryResult["setId"],
        word = queryResult["word"],
        partialWord = queryResult["partialWord"];

  Map<String, dynamic> toMap() {
    return {'id': id, 'setId': setId, 'word': word, 'partialWord': partialWord};
  }

  @override
  String toString() {
    return '$word';
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
