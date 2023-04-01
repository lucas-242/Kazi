extension StringExtensions on String {
  /// Return normalized date.
  String normalizeDate() {
    final splitedDate = _splitDate(this);
    final normalizedDate = _createNewDate(splitedDate);
    return normalizedDate;
  }

  List<String> _splitDate(String date) {
    var splitedDate = date.split('/');
    if (splitedDate.length == 1) {
      splitedDate = date.split('-');
    }

    return splitedDate;
  }

  String _createNewDate(List<String> splitedDate) {
    String normalizedDate = '';
    int count = 1;

    for (var part in splitedDate) {
      normalizedDate += _addZeroToNumber(part);
      normalizedDate += _addSlash(splitedDate, count);
      count++;
    }

    return normalizedDate;
  }

  String _addZeroToNumber(String part) {
    if (part.length == 1) {
      return '0$part';
    }

    return part;
  }

  String _addSlash(List<String> splitedDate, int count) {
    if (splitedDate.length != count) {
      return '/';
    }

    return '';
  }

  String capitalize() {
    if (length <= 1) {
      return toUpperCase();
    }

    final List<String> words = split(' ');
    final capitalizedWords = _capitalizeWords(words);
    return capitalizedWords.join(' ');
  }

  Iterable<String> _capitalizeWords(List<String> words) {
    return words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });
  }
}
