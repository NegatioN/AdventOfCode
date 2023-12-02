import scala.io.Source
object Day2 extends App {

  val fname = "data/day2"

  def parseExample(line: String): (Int, Seq[Map[String, Int]]) = {
    val s"Game $game: $examples" = line
    val r = examples.split(";").map(ex => {
      ex.split(",").map{exSub =>
        val s"$num $color" = exSub.strip()
        (color, num.toInt)
      }.toMap
    })
    (game.toInt, r)
  }

  val currentRules = Map("green" -> 13, "red" -> 12, "blue" -> 14)

  def validGame(games: Seq[Map[String, Int]], ruleMap: Map[String, Int]): Boolean = {
    val resp = games.map(oneGame => {
      oneGame.map {
        case (key, value) => ruleMap(key) >= value
      }
    }).flatten.exists(_ == false)
    resp != true
  }

  def part1(fname: String) = {
    val games = Source.fromFile(fname).getLines().map(line => {
      parseExample(line)
    }).toMap
    games.map{ case (key, value) => if(validGame(value, currentRules)) key else 0 }.sum
  }

  println(part1(fname))
}

