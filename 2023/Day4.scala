import scala.io.Source
import collection.mutable.HashMap
import scala.math.pow

object Day4 extends App {
  val fname = "data/day4"
  val text = Source.fromFile(fname).getLines().toSeq

  case class CardGame(num: Int, winningNums: Set[Int], myNums: Set[Int]){
    def score = pow(2, myNums.intersect(winningNums).size-1).intValue
    def cardCopies = {
      val overlap = myNums.intersect(winningNums).size
      Range(num+1, num+overlap+1).toSet
    }
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

  def part2(fname: String) = {
    val cardCounts = new HashMap[Int, Int]()
    val games = Source.fromFile(fname).getLines().map(line => {
      parse(line)
    }).map{c =>
      val existingCopies: Int = cardCounts.getOrElse(c.num, 0) + 1
      c.cardCopies.map { y => cardCounts.put(y, cardCounts.getOrElse(y, 0) + existingCopies) }
    }.toSet
    cardCounts.values.sum + games.size
  }

  val b = part2(fname)
  println(b)
}