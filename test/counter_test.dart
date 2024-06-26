import 'package:flutter_tdd/models/counter.dart';
import 'package:test/test.dart';

void main() {
  group("Tests for counter", () {
    final counter = Counter();
    test("Counter value shuld be incremented", () {
      counter.increment();

      expect(counter.value, 1);
    });

    test("Counter value should be decremented", () {
      counter.decrement();

      expect(counter.value, 0);
    });
  });
}
