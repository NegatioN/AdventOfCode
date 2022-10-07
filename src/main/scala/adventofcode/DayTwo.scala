package adventofcode

import scala.io.Source

object DayTwo extends App{
  val filename = "~/projects/AdventOfCode/data/day2".replaceFirst("^~", System.getProperty("user.home"))
  val lines = Source.fromFile(filename).getLines.toList.map(x => x.split("\\W+")).map{case Array(x, y) => (x, y.toInt)}

  //part1
  val aim = lines.map {
    case Tuple2("up", y) => -y
    case Tuple2("down", y) => y
    case _ => 0
  }

  val x = lines.map{
    case Tuple2("forward", y) => y
    case _ => 0
  }
  println(x.sum * aim.sum)

  //part2
  val (horiz, vert, _) = lines.foldLeft((0,0,0)){ // fold becomes a tuple3 in first pos? so I have (tuple3, tuple2)
    case ((horiz, vert, aim), (command, amount)) =>
      command match {
        case "forward" => (horiz + amount, vert + (aim*amount), aim)
        case "down" => (horiz, vert, aim + amount)
        case "up" => (horiz, vert, aim - amount)
      }
  }
  println(horiz * vert)

  def calculate(lines: List[Tuple2[String, Int]]): Seq[Int] = {
    val (horizontal, vertical, aim) = lines.foldLeft(0, 0, 0) {
      case ((horizontal, vertical, aim), (command, amount)) =>
        command match {
          case "forward" => (horizontal + amount, vertical + (aim * amount), aim)
          case "down" => (horizontal, vertical, aim + amount)
          case "up" => (horizontal, vertical, aim - amount)
        }
    }
    Seq(horizontal, vertical, aim)
  }

  val res = calculate(lines)
  println(res.head * res(2)) // part1
  println(res.head * res(1)) // part2

}
