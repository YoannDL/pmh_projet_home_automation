import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(HomeAutomationApp());
}

class HomeAutomationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Automation',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _lightStatus = false;
  bool _fanStatus = false;
  double _temperature = 0;
  double _humidity = 0;

  String _apiUrl = 'https://your-home-automation-api.com';
  String _apiKey = 'your-api-key';

  Future<void> _sendLightCommand(bool status) async {
    String url = '$_apiUrl/light?api_key=$_apiKey&status=${status ? 'on' : 'off'}';
    await http.get(Uri.parse(url));
  }

  Future<void> _sendFanCommand(bool status) async {
    String url = '$_apiUrl/fan?api_key=$_apiKey&status=${status ? 'on' : 'off'}';
    await http.get(Uri.parse(url));
  }

  // Add functions to fetch states and DHT11 sensor data here
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Automation'),
      ),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Components', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 16),
                  Image.asset('assets/light.png', height: 48),
                  SizedBox(height: 8),
                  Text('Light', style: TextStyle(color: Colors.white)),
                  Switch(
                    value: _lightStatus,
                    onChanged: (value) async {
                      setState(() {
                        _lightStatus = value;
                      });
                      await _sendLightCommand(value);
                    },
                  ),
                  Image.asset('assets/fan.png', height: 48),
                  SizedBox(height: 8),
                  Text('Fan', style: TextStyle(color: Colors.white)),
                  Switch(
                    value: _fanStatus,
                    onChanged: (value) async {
                      setState(() {
                        _fanStatus = value;
                      });
                      await _sendFanCommand(value);
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature & Humidity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 16),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    percent: _temperature / 100,
                    center: Text('${_temperature.toStringAsFixed(1)}°C', style: TextStyle(color: Colors.white)),
                    progressColor: Colors.orange,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.orange.withOpacity(0.2),
                  ),
                  SizedBox(height: 16),
                  Text('Temperature', style: TextStyle(color: Colors.white)),
                                    SizedBox(height: 32),
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 13.0,
                    percent: _humidity / 100,
                    center: Text('${_humidity.toStringAsFixed(1)}%', style: TextStyle(color: Colors.white)),
                    progressColor: Colors.blue,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                  ),
                  SizedBox(height: 16),
                  Text('Humidity', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                // Add navigation to the Sign Up page
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                // The current page is the Dashboard page
              },
              child: Text('Dashboard', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
  // Inside the _HomePageState class
  Widget _componentState(String componentName, bool state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${componentName} is ', style: TextStyle(color: Colors.white)),
        Text(state ? 'ON' : 'OFF',
            style: TextStyle(
                color: state ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

                 
