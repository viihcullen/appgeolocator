import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Purple Maps',
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  //Crie um controller para o mapa

  final _mapController = Completer<GoogleMapController>();

  //Defina a posição inicial da câmera quando o mapa carregar

  final _initialPosition = const CameraPosition(
    target: LatLng(-20.17161, -50.99691),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purple Maps'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GoogleMap(
        //Posição inicial

        initialCameraPosition: _initialPosition,

        //Obtendo o controller do mapa

        onMapCreated: (controller) {
          _mapController.complete(controller);
        },

        mapType: MapType.normal,

        //Ao clicar no mapa, recebe as coordenadas do click

        onTap: (coordenadas) async {
          //Apenas mover a câmera com base nas novas coordenadas

          (await _mapController.future).animateCamera(
            CameraUpdate.newLatLng(coordenadas),
          );

          //Mover a câmera e alterar o zoom da visualização

          // (await _mapController.future)

          //     .animateCamera(CameraUpdate.newLatLngZoom(

          //   coordenadas,

          //   13,

          // ));
        },

        markers: {
          const Marker(
            markerId: MarkerId('marker_id'), //Único para cada marcador

            position: LatLng(-20.17161, -50.99691),

            infoWindow: InfoWindow(
              title: 'Localização Desejada',
              snippet: 'Ao clicar no "Marker", isto será exibido',
            ),
          ),
        },
      ),
    );
  }
}
