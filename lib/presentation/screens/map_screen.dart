import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 
const MAPBOX_ACCES_TOKEN =
      'pk.eyJ1IjoibWFubnlsZW52IiwiYSI6ImNsbXRidHMzdjAxYTEybWxiYnA1Z3c5M2QifQ.A_F0i1F1hbmOnt3uGkqwBA';

final myPosition = LatLng(6.98789, -73.04953); // latitude, longitude
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
         return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Map'),
          backgroundColor: Colors.blueAccent,
        ),
        body: FlutterMap(
          options:MapOptions(
              center: myPosition,
              minZoom: 10,
              maxZoom: 35,
              zoom: 18
          ),
          nonRotatedChildren: [
             TileLayer(
              urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken':MAPBOX_ACCES_TOKEN,
                 'id':'mapbox/streets-v12' //sattelite-v9
              },
             ),
     MarkerLayer(
                  markers: [
                    Marker(
                      point: myPosition,
                      builder: (context) {
                        return Container(
                          child: const Icon(
                            Icons.person_pin,
                            color: Colors.blueAccent,
                            size: 40,
                                                      
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