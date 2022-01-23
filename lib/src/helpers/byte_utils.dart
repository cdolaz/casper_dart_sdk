

Iterable<int> bytesToNibbles(List<int> bytes) {
  // Return an iterator that yields the nibbles of the given bytes.
  return bytes.expand((element) => [(element >> 4) & 0x0F, element & 0x0F]);
}

// Return an iterator that yields bits of the given bytes. 
Iterable<int> bytesToBits(List<int> bytes) {
  return bytes.expand((element) => [
    (element >> 7) & 0x01,
    (element >> 6) & 0x01,
    (element >> 5) & 0x01,
    (element >> 4) & 0x01,
    (element >> 3) & 0x01,
    (element >> 2) & 0x01,
    (element >> 1) & 0x01,
    element & 0x01
  ]);
}

