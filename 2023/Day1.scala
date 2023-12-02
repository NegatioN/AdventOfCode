import scala.io.Source
object Day1 extends App {

  val fname = "data/day1"
  def part1(fname: String) = {
    Source.fromFile(fname).getLines().map(line => {
      val ints = line.filter(_.isDigit).map(_.asDigit)
      s"${ints.head}${ints.last}".toInt
    }).sum
  }

  val numberMap: Map[String, String] = Map("one" -> "1",
                                            "two" -> "2",
                                            "three" -> "3",
                                            "four" -> "4",
                                            "five" -> "5",
                                            "six" -> "6",
                                            "seven" -> "7",
                                            "eight" -> "8",
                                            "nine" -> "9" )
  def toDigit(v: String) = v match {
    case v => numberMap.get(v) match {
      case Some(value) => value
      case _ => v
    }
  }

  def part2(fname: String) = {
    val regex = s"[0-9]|${numberMap.keys.mkString("|")}".r
    val revRegex = s"[0-9]|${numberMap.keys.mkString("|").reverse}".r
    Source.fromFile(fname).getLines().map(line => {
        val first = regex.findFirstIn(line).get
        val last = revRegex.findFirstIn(line.reverse).get.reverse
        s"${toDigit(first)}${toDigit(last)}".toInt
      }).sum
  }


  println(part2(fname))
}

