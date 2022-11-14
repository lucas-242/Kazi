extension EnumExtension on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
