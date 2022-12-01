package adventofcode

import scala.io.Source

object DayFour extends App{
  val filename = "~/projects/AdventOfCode/data/day4test".replaceFirst("^~", System.getProperty("user.home"))
  val inputdata = Source.fromFile(filename).getLines.toSeq
  val numbers = inputdata.head.split(",").map(x => Integer.parseInt(x)).toSeq
  println(numbers)

  val boards = inputdata.drop(2)

  def f(i: Int): Int = i + 1

  val n: Option[Int] = None
  val res: Option[Int] = for {
    a <- Some(1)
    b <- None
    c <- Some("hei")
    d = c.length
  } yield a + f(b) + d

  println(res)


}
