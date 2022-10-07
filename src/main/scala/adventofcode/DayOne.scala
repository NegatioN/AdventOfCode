package adventofcode

import scala.io.Source

object DayOne extends App{
  val filename = "~/projects/AdventOfCode/data/day1".replaceFirst("^~", System.getProperty("user.home"))
  val lines = Source.fromFile(filename).getLines.toList.map(x => x.toInt)

  val stuff = lines.zip(lines.tail)//.map(x => x[0] < x[1]) this did not work b/c types
  println(stuff.count{case Tuple2(val1, val2) => val1 < val2}) // Types are a pain with Tuples (?) yuck
  val stuff2 = lines.sliding(2).count{case Seq(x, y) => x < y} // Stolen solution. Pattern matching + sliding. Code-block as input
  println(stuff2)


  //part2
  val out = lines.sliding(3).map(x => x.sum).sliding(2).count{case Seq(x, y) => x < y}
  println(out)

  implicit class MyCountable(l : Iterable[Int]) {
    def increased(): Int = {
      l.sliding(2).count{case Seq(x,y) => x < y}
    }
  }

  // "cleaner" part1 and part2 ?
  println(lines.increased())
  println(lines.sliding(3).map(x => x.sum).toList.increased()) // annoying that I cant find a common ancestor of iterable and list.

}
