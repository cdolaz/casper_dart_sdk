/// Returns true if all chars in a string are uppercase or lowercase.
/// Returns false if the string is mixed case or if there are no alphabetic chars.
bool isHexStringSameCase(String hex) {
  int m = 0;
  for (int i = 0; i < hex.length; i++) {
    int c = hex.codeUnitAt(i);
    if (c >= 'A'.codeUnitAt(0) && c <= 'F'.codeUnitAt(0)) {
      m |= 1;
    } else if (c >= 'a'.codeUnitAt(0) && c <= 'f'.codeUnitAt(0)) {
      m |= 2;
    } else if (c >= '0'.codeUnitAt(0) && c <= '9'.codeUnitAt(0)) {
      m |= 0;
    } else {
      throw ArgumentError("Invalid hexadecimal string: $hex");
    }
  }
  return m != 3;
}
