package adventofcode

import scala.io.Source

object DayThree extends App{
  val filename = "~/projects/AdventOfCode/data/day3".replaceFirst("^~", System.getProperty("user.home"))
  val lines = Source.fromFile(filename).getLines.map(x => x.map(y => y.toInt - 48)).toSeq

  def parseBinary(nums: Seq[Int]): Int = {
    Integer.parseInt(nums.mkString(""), 2)
  }
  val gammaNums = lines.transpose.map(x => if ((x.sum.toFloat / x.length) > 0.5) 1 else 0)
  val epsilon = parseBinary(gammaNums.map(x => if (x == 1) 0 else 1))

  println(parseBinary(gammaNums) * epsilon)
}
