import scala.io.Source
import scala.math.pow

object Day4 extends App {
  val fname = "data/day4"
  val text = Source.fromFile(fname).getLines().toSeq

  case class CardGame(num: Int, winningNums: Set[Int], myNums: Set[Int]){
    def score = pow(2, myNums.intersect(winningNums).size-1).intValue
  }
  def parse(line: String): CardGame = {
    val s"$num: $winningNums | $myNums" = line
    CardGame(num.split(" +").last.toInt, winningNums.strip.split(" +").map(_.toInt).toSet, myNums.strip.split(" +").map(_.toInt).toSet)
  }

  def part1(fname: String) = {
    Source.fromFile(fname).getLines().map(line => {
      parse(line)
    }).map(_.score).sum
  }

  val a = part1(fname)
  println(a)
}