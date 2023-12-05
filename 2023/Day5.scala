import scala.io.Source
import collection.mutable.HashMap
import scala.math.pow

object Day5 extends App {
  val fname = "data/day5"
  val text = Source.fromFile(fname).mkString.split("\n\n")

  val s"seeds: $seeds" = text(0)
  val seedList = seeds.split(" +").map(_.toLong)

  case class ARange(sourceTo: Long, sourceFrom: Long, range: Long) {
    def valueInRange(input: Long): Option[Long] = if (input >= sourceFrom && input <= sourceFrom+range) {
      Some(input - sourceFrom + sourceTo)
    } else {
      None
    }
  }
  val maps = text.drop(1).map{m =>
    val parts = m.split("\n")
    val s"$name map:" = parts(0)
    val ranges = parts.drop(1).map{p =>
      val ps = p.split(" +").map(_.toLong)
      ARange(ps(0), ps(1), ps(2))
    }.toSeq
    (name, ranges)
  }.toMap

  def mapper(ranges: Seq[ARange], input: Long): Long = {
    val v = ranges.map(_.valueInRange(input)).flatten.headOption
    v.getOrElse(input)
  }

  def part1(seeds: Seq[Long], maps: Map[String, Seq[ARange]]) = {
    val seedToSoil = maps("seed-to-soil")
    val soilToFertilizer = maps("soil-to-fertilizer")
    val fertilizerToWater = maps("fertilizer-to-water")
    val waterToLight = maps("water-to-light")
    val lightToTemp = maps("light-to-temperature")
    val tempToHumid = maps("temperature-to-humidity")
    val humidToLoc = maps("humidity-to-location")

    seeds.map(mapper(seedToSoil, _))
         .map(mapper(soilToFertilizer, _))
         .map(mapper(fertilizerToWater, _))
         .map(mapper(waterToLight, _))
         .map(mapper(lightToTemp, _))
         .map(mapper(tempToHumid, _))
         .map(mapper(humidToLoc, _))
      .min
  }

  val a = part1(seedList, maps)
  println(a)

}