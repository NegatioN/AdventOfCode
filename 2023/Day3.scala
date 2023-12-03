import scala.io.Source
object Day3 extends App {
  val fname = "data/day3"
  val text = Source.fromFile(fname).getLines().toSeq

  case class Num(n: Int, start: Int, end: Int, row: Int){
    def isInvalid(schematic: Seq[String]): Boolean = Seq(row-1, row, row+1).forall{ y=>
      val localText = schematic.lift
      Range(start-1, end+1).flatMap {i =>
        for {
          r <- localText(y)
          char <- r.lift(i)
          notSymbol = char.isDigit || char == '.'
        } yield (notSymbol)
      }.forall(_ == true)
    }
  }

  val rgx = """\d+""".r
  def part1(text: Seq[String]) = {
    val nums = text.zipWithIndex.map { case (line, i) => {
      rgx.findAllMatchIn(line).map(matched => Num(matched.matched.toInt, matched.start, matched.end, i)).toList
      }
    }

    nums.flatten.filter(!_.isInvalid(text)).map(_.n).sum
  }


  val ans = part1(text)
  println(ans)
  assert(ans == 535351)
}