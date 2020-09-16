import "package:flutter_test/flutter_test.dart";
import "package:mahjong_tutor/main.dart";
import 'package:mahjong_tutor/sorter.dart';

void main() {
  test("Pungs", () {
    expect(sortHand(["1 Dot","1 Dot","1 Dot"]), ["1 Dot","1 Dot","1 Dot"," A pung of 1 Dot, "]);
  });
  test("Kongs", () {
    expect(sortHand(["1 Dot","1 Dot","1 Dot","1 Dot"]), ["1 Dot","1 Dot","1 Dot","1 Dot"," A kong of 1 Dot, "]);
  });
  test("Chow", () {
    expect(sortHand(["1 Dot","2 Dot","3 Dot"]), ["3 Dot","2 Dot","1 Dot"," A chow of Dots, "]);
  });
  test("Full Hand", () {
    expect(sortHand(["4 Dot","6 Dot","5 Dot","Green Dragon","Green Dragon","Green Dragon","Red Dragon", "North", "9 Bam","9 Bam","9 Bam","9 Bam", "3 Crack", "8 Crack"]),
        ["Green Dragon","Green Dragon","Green Dragon","9 Bam","9 Bam","9 Bam","9 Bam","6 Dot","5 Dot","4 Dot","3 Crack","8 Crack","North","Red Dragon"," A pung of Green Dragon,  A kong of 9 Bam,  A chow of Dots, "]);
  });
}