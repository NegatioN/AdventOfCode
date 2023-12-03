import scala.io.Source
object Day2 extends App {

  val fname = "data/day2"

  case class GameSet(red: Int, green: Int, blue: Int)
  case class Game(id: Int, sets: Seq[GameSet])

  def parse(line: String): Game = {
    val s"Game $game: $examples" = line
    val gameSets = examples.split(";").map(ex => {
      val m = ex.split(",").map { exSub =>
        val s"$num $color" = exSub.strip()
        (color, num.toInt)
      }.toMap
      GameSet(m.getOrElse("red", 0), m.getOrElse("green", 0), m.getOrElse("blue", 0))
    })
    Game(game.toInt, gameSets)
  }

  val possibleGame = GameSet(12, 13, 14)

  def part1(fname: String) = {
    val games = Source.fromFile(fname).getLines().map(line => {parse(line)})
    games.filter{g =>
      g.sets.forall{s => s.red <= possibleGame.red && s.green <= possibleGame.green && s.blue <= possibleGame.blue}
    }.map(_.id).sum
  }

  println(part1(fname))

  def part2(fname: String) = {
    val games = Source.fromFile(fname).getLines().map(line => (parse(line)))
    games.map(g => {
      g.sets.map(_.red).max * g.sets.map(_.green).max * g.sets.map(_.blue).max
    }).sum
  }
  println(part2(fname))
}