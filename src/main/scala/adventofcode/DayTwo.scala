package adventofcode

import scala.io.Source

object DayTwo extends App{
  val filename = "~/projects/AdventOfCode/data/day2test".replaceFirst("^~", System.getProperty("user.home"))
  val lines = Source.fromFile(filename).getLines.toList.map(x => x.toInt)

}
