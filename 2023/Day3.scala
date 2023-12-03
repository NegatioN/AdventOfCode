import scala.io.Source
object Day3 extends App {
  val fname = "data/day3"
  val text = Source.fromFile(fname).getLines().toSeq

  case class Num(n: Int, start: Int, end: Int, row: Int){
    def isInvalid(schematic: Seq[String], condition: (Char) => Boolean): Boolean = {
      val localText = schematic.lift
      boundingBox.forall{case (y, i) => {
        val c = for {
          r <- localText(y)
          char <- r.lift(i)
          notSymbol = condition(char)
        } yield (notSymbol)
        c.getOrElse(true)
      }
      }
    }

    def symbolBounds: Set[(Int, Int)] = Seq(row-1, row, row+1).map(y => Seq(start-1, start, start+1).map((y, _))).flatten.toSet

    def boundingBox: Set[(Int, Int)] = Seq(row-1, row, row+1).map(y => Range(start-1, end+1).map((y, _))).flatten.toSet
    def occupies: Set[(Int, Int)] = Seq(start, end-1).map((row, _)).toSet
  }


  def overlappingBounds(a: Set[(Int, Int)], b: Set[(Int, Int)]): Boolean = a.intersect(b).nonEmpty

  val rgx = """\d+""".r
  def part1(text: Seq[String]) = {
    val nums = text.zipWithIndex.map { case (line, i) => {
      rgx.findAllMatchIn(line).map(matched => Num(matched.matched.toInt, matched.start, matched.end, i)).toList
      }
    }
    nums.flatten.filter(!_.isInvalid(text, (char: Char) => char.isDigit || char == '.')).map(_.n).sum
  }


  val ans = part1(text)
  //assert(ans == 4361)

  def part2(text: Seq[String]) = {
    val nums = text.zipWithIndex.map { case (line, i) => {
      rgx.findAllMatchIn(line).map(matched => Num(matched.matched.toInt, matched.start, matched.end, i)).toList
    }
    }.flatten

    val symbols = text.zipWithIndex.map { case (line, i) => {
      """\*""".r.findAllMatchIn(line).map(matched => Num(-1, matched.start, matched.end, i)).toList
    }
    }.flatten

    val a = symbols.map{s => nums.filter(n => {
      overlappingBounds(s.symbolBounds, n.occupies)
    })}.filter(_.size > 1)
    a.map(_.map(_.n).reduce(_*_)).sum
  }

  val ans2 = part2(text)
  println(ans2)
  //assert(ans2 == 467835)
}