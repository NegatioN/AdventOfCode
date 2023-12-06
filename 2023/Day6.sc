//> using scala 2.13

import scala.io.Source

val fname = "data/day6"
val text = Source.fromFile(fname).getLines().toSeq
val times = text(0).split(" +").drop(1).map(_.toInt)
val distances = text(1).split(" +").drop(1).map(_.toInt)

def part1(times: Seq[Int], dist: Seq[Int]) =
  times.zip(dist).map{ case (tt, d) =>
    Range(0, tt).map { t =>
      val remainingTime = tt - t
      remainingTime * t
    }.count(_ > d)
  }.product

println(part1(times, distances))