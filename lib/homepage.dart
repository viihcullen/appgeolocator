import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? latitude;
  double? longitude;

  String? endereco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          latitude != null
              ? Text(
                  'Latitude: $latitude',
                  textAlign: TextAlign.center,
                )
              : Text('Latitude: '),
          longitude != null
              ? Text('Longitude: $longitude', textAlign: TextAlign.center)
              : Text('Longitude: '),
          endereco != null ? Text('Endereço: $endereco') : Text('Endereço: '),
          TextButton(
            child: Text('Pegar Posição'),
            onPressed: () {
              pegarPosicao();
            },
          ),
        ],
      ),
    );
  }

  pegarPosicao() async {
    Position posicao = await Geolocator.getCurrentPosition();
    setState(() {
      this.latitude = posicao.latitude;
      this.longitude = posicao.longitude;
    });
    List<Placemark> locais =
        await placemarkFromCoordinates(posicao.latitude, posicao.longitude);
    if (locais != null) {
      print(locais[0]);
    }
  }
}
