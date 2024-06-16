extension DoubleExtensions on double {
  String removeDecimalPoint() {
    var response = toString();

    if (toString().split('.').isNotEmpty) {
      final decmialPoint = toString().split('.')[1];
      if (decmialPoint == '0') {
        response = response.split('.0').join();
      }
      if (decmialPoint == '00') {
        response = response.split('.00').join();
      }
    }

    return response;
  }
}
