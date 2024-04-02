import gleeunit
import gleeunit/should
import gleam/string
import aoc2023d1

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
}

const testinput = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

const testinput2 = "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"

pub fn part1_test() {
  let lines = string.split(testinput, "\n")
  aoc2023d1.solve_p1(lines)
  |> should.equal("142")
}

pub fn part2_test() {
  let lines = string.split(testinput2, "\n")
  aoc2023d1.solve_p2(lines)
  |> should.equal("281")
}
