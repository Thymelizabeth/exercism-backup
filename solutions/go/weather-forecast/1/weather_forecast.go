// Package weather provides tools to calculate the current weather.
package weather

var (
    // CurrentCondition represents the current weather conditions.
	CurrentCondition string
    // CurrentLocation represents the current location.
	CurrentLocation  string
)

// Forecast returns a string containing the current weather conditions
// for a given location and weather.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
