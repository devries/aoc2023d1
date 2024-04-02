import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let filename = "day01.txt"

  let lines = read_lines(from: filename)
  case lines {
    Ok(text) -> {
      io.println("Part 1: " <> solve_p1(text))
      io.println("Part 2: " <> solve_p2(text))
    }
    Error(_) -> io.println("Error reading file")
  }
}

pub fn solve_p1(lines: List(String)) -> String {
  list.map(lines, extract_numerals)
  |> list.map(two_digit_result)
  |> list.filter(result.is_ok)
  |> result.all
  |> result.map(list.fold(_, from: 0, with: fn(b, a) { b + a }))
  |> result.map(int.to_string)
  |> result.unwrap("error running part 1")
}

pub fn solve_p2(lines: List(String)) -> String {
  list.map(lines, extract_numbers)
  |> list.map(two_digit_result)
  |> list.filter(result.is_ok)
  |> result.all
  |> result.map(list.fold(_, from: 0, with: fn(b, a) { b + a }))
  |> result.map(int.to_string)
  |> result.unwrap("error running part 2")
}

pub fn read_lines(
  from filepath: String,
) -> Result(List(String), simplifile.FileError) {
  result.map(simplifile.read(from: filepath), string.split(_, "\n"))
}

pub fn extract_numerals(line: String) -> List(Int) {
  let characters = string.to_utf_codepoints(line)
  let codepoints =
    list.filter(characters, keeping: fn(g) {
      string.utf_codepoint_to_int(g) >= 48
      && string.utf_codepoint_to_int(g) <= 57
    })
  list.map(codepoints, fn(g) { string.utf_codepoint_to_int(g) - 48 })
}

pub fn two_digit_result(numbers: List(Int)) -> Result(Int, Nil) {
  use f <- result.try(list.first(numbers))
  use l <- result.try(list.last(numbers))
  Ok(f * 10 + l)
}

pub fn extract_numbers(line: String) -> List(Int) {
  let line = string.replace(line, "one", "o1e")
  let line = string.replace(line, "two", "t2o")
  let line = string.replace(line, "three", "t3ree")
  let line = string.replace(line, "four", "f4ur")
  let line = string.replace(line, "five", "f5ve")
  let line = string.replace(line, "six", "s6x")
  let line = string.replace(line, "seven", "s7ven")
  let line = string.replace(line, "eight", "e8ght")
  let line = string.replace(line, "nine", "n9ne")
  extract_numerals(line)
}
