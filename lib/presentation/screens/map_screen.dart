import 'package:flutter/material.dart';  // Importa el paquete necesario para Flutter.
import 'package:flutter_map/flutter_map.dart';  // Importa el paquete para trabajar con mapas interactivos.
import 'package:latlong2/latlong.dart';  // Importa el paquete para manejar coordenadas geográficas.

const MAPBOX_ACCES_TOKEN =
    'pk.eyJ1IjoibWFubnlsZW52IiwiYSI6ImNsbXRidHMzdjAxYTEybWxiYnA1Z3c5M2QifQ.A_F0i1F1hbmOnt3uGkqwBA';  // Define un token de acceso a Mapbox.

final myPosition = LatLng(6.98789, -73.04953);  // Define una variable que representa una coordenada geográfica.

class MapScreen extends StatelessWidget {  // Define la clase MapScreen que extiende StatelessWidget.
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {  // Define el método 'build' para construir la pantalla.
    return Scaffold(  // Define la estructura básica de la pantalla.
      // appBar: AppBar(  // Configura la barra de la aplicación en la parte superior.
      //   centerTitle: true,  // Centra el título en la barra.
      //   title: const Text('Map'),  // Establece el título de la barra de la aplicación.
      //   backgroundColor: Colors.blueAccent,  // Establece el color de fondo de la barra.
      // ),
      body: FlutterMap(  
     // Widget para mostrar un mapa interactivo.
        options: MapOptions(  // Opciones del mapa.
            center: myPosition,  // Define el centro del mapa en base a la variable 'myPosition'.
            minZoom: 10,  // Nivel de zoom mínimo.
            maxZoom: 35,  // Nivel de zoom máximo.
            zoom: 18  // Nivel de zoom inicial.
        ),
        nonRotatedChildren: [  // Elementos que no se rotarán con el mapa.
          TileLayer(  // Capa de teselas del mapa.
            urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',  // Plantilla de URL para las teselas del mapa.
            additionalOptions: const {
              'accessToken': MAPBOX_ACCES_TOKEN,  // Token de acceso a Mapbox.
              'id': 'mapbox/streets-v12'  // Estilo del mapa (puede ser 'mapbox/streets-v12' o 'mapbox/satellite-v9', en este caso).
            },
          ),
          MarkerLayer(  // Capa de marcadores en el mapa.
            markers: [
              Marker(  // Define un marcador en una ubicación específica.
                point: myPosition,  // Ubicación del marcador basada en 'myPosition'.
                builder: (context) {  // Constructor del marcador.
                  return Container(  // Contenedor del marcador.
                    child: const Icon(  // Icono del marcador.
                      Icons.person_pin,  // Ícono de ubicación de persona.
                      color: Colors.blueAccent,  // Color del ícono.
                      size: 40,  // Tamaño del ícono.
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
