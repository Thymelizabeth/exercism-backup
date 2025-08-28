import gleam/float.{compare}
import gleam/list.{sort}
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

fn get_celsius(t: Temperature) -> Float {
  case t {
    Celsius(c) -> c
    Fahrenheit(f) -> fahrenheit_to_celsius(f)
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  compare(get_celsius(left), get_celsius(right))
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  sort(cities, by: fn(c1: City, c2: City) -> Order {
    compare_temperature(c1.temperature, c2.temperature)
  })
}
