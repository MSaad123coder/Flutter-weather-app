import 'package:flutter/material.dart';
// Imports Material Design library for building UI components.

import 'package:flutter_application_1/const.dart';
// Imports constants, likely containing the API key or other config settings.

import 'package:intl/intl.dart';
// Imports package for formatting dates and times.

import 'package:weather/weather.dart';
// Imports weather library to fetch weather data.

// HomePage widget with state management.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => HomePageState();
}

// The state of the HomePage.
class HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  // Initializes a WeatherFactory with API key for fetching weather data.

  Weather? _weather;
  // Holds weather data to be displayed on the UI.

  @override
  void initState() {
    super.initState();
    // Called when the widget is inserted into the widget tree.

    _wf.currentWeatherByCityName("Kolkata").then((w) {
      // Fetches current weather data for Islamabad.
      setState(() {
        // Updates the UI once data is fetched.
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI());
    // Returns the main UI wrapped in a Scaffold.
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
      // Shows a loading spinner while weather data is being fetched.
    }

    // Builds the main UI when weather data is available.
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _locationheader(),
          // Shows location header.

          SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
          // Adds vertical spacing.

          _datetimeinfo(),
          // Displays current date and time info.

          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          // Adds vertical spacing.

          _weatherIcon(),
          // Shows weather icon and description.

          SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
          // Adds vertical spacing.

          _currentTemperature(),
          // Displays current temperature.

          SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
          // Adds vertical spacing.

          _extrainfo(),
          // Displays additional weather information (wind, humidity, etc.).
        ],
      ),
    );
  }

  Widget _locationheader() {
    // Displays the city name or "Unknown Location" if not available.
    return Text(
      _weather?.areaName ?? "Unknown Location",
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  Widget _datetimeinfo() {
    // Displays the current date and time.
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("EEEE, d MMMM y").format(now),
          // Formats and displays date, e.g., "Monday, 1 January 2025".
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        Row(
          // Displays day name and date in a row.
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              // Formats and displays day, e.g., "Monday".
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              // Formats and displays date, e.g., "1.1.2025".
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    // Displays weather icon and description.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          // Creates a container with a weather icon from the internet.
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "Unknown",
          // Displays the weather description, e.g., "Clear Sky".
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _currentTemperature() {
    // Displays current temperature.
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? "Unknown"}°C",
      // Formats and displays temperature with one decimal, e.g., "25°C".
      style: const TextStyle(
          fontSize: 90, fontWeight: FontWeight.w700, color: Colors.blue),
    );
  }

  Widget _extrainfo() {
    // Displays additional weather information like wind speed and humidity.
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.20,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
        // Styles the container with rounded corners and background color.
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First row: Wind speed and humidity.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0) ?? "Unknown"}m/s",
                // Displays wind speed in meters per second.
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "humidity: ${_weather?.humidity?.toStringAsFixed(0) ?? "Unknown"}%",
                // Displays humidity in percentage.
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
          // Second row: Max and Min temperatures.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0) ?? "Unknown"}°C",
                // Displays maximum temperature.
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0) ?? "Unknown"}°C",
                // Displays minimum temperature.
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
