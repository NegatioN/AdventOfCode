package adventofcode

import scala.io.Source

object DayThree extends App{
  val filename = "~/projects/AdventOfCode/data/day3test".replaceFirst("^~", System.getProperty("user.home"))
  val lines = Source.fromFile(filename).getLines.map(x => x.map(y => y.toInt - 48)).toSeq

  def parseBinary(nums: Seq[Int]): Int = Integer.parseInt(nums.mkString(""), 2)
  def dominantBit(nums: Seq[Int]): Int = if ((nums.sum.toFloat / nums.length) > 0.5) 1 else 0
  val gammaNums = lines.transpose.map(x => dominantBit(x))
  val epsilon = parseBinary(gammaNums.map(x => if (x == 1) 0 else 1))

  println(parseBinary(gammaNums) * epsilon) // part1

  // Part2

  val vs = lines.transpose.toSeq
  println(vs(0))

  println(vs)
  println(vs.map(y => y.sum))
  println(vs.indices.map(i => vs(0)(i)))

  // check domninant number, not very hard.
  val firstDominant = dominantBit(vs(0))
  val allInds = vs.head.indices.toSet
  println(allInds -- Set(1,2,3))
  println(allInds)
  def getValidIndices(nums: Seq[Int], pred: Int): Seq[Int] = nums.zipWithIndex.map(x => if (x._1 == pred) x._2 else -1).filter(x => x != -1)

  println(getValidIndices(vs(0), firstDominant))

}
