import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition; // Inicializada como nula

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purple Localization"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_currentPosition != null)
                Text(
                  "LATITUDE: ${_currentPosition!.latitude}, LONGITUDE: ${_currentPosition!.longitude}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18.0),
                ),
                child: Text("Obter Localização"),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position? position) {
      if (position != null) {
        setState(() {
          _currentPosition = position;
        });
      } else {
        print("Erro: Não foi possível obter a localização.");
      }
    }).catchError((e) {
      print(e);
    });
  }
}
