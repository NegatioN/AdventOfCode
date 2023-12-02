import scala.io.Source
object Day1 extends App {

  val fname = "data/day1"
  val ans = Source.fromFile(fname).getLines().map(line => {
    val ints = line.filter(_.isDigit).map(_.asDigit)
    s"${ints.head}${ints.last}".toInt
  }).sum
  println(ans)
}

