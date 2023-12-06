//> using scala 2.13

import scala.io.Source

val fname = "data/day6"
val text = Source.fromFile(fname).getLines().toSeq
val times = text(0).split(" +").drop(1).map(_.toLong)
val distances = text(1).split(" +").drop(1).map(_.toLong)

def part1(times: Seq[Long], dist: Seq[Long]) =
  times.zip(dist).map{ case (tt, d) =>
    0L.to(tt).map { t =>
      val remainingTime = tt - t
      remainingTime * t
    }.count(_ > d)
  }.product

println(part1(times, distances))

val t2 = Seq(text(0).split(" +").drop(1).mkString.toLong)
val d2 = Seq(text(1).split(" +").drop(1).mkString.toLong)

println(part1(t2, d2))
