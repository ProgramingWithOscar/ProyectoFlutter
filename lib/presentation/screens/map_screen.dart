import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapExample extends StatefulWidget {
  @override
  _GoogleMapExampleState createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {
  late GoogleMapController _controller;
  Position? _currentPosition;
  int _selectedIndex = 0;
  TextEditingController _locationController = TextEditingController();
  String _enteredLocation = "";

  final titles = ["Mi Ubicación"];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      await _getCurrentLocation();
      _startListeningForLocationUpdates();
    } else if (status.isDenied) {
      // Handle permission denied here
    }
  }

  Future<void> _getCurrentLocation() async {
    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      _currentPosition = currentPosition;
    });
  }

  void _startListeningForLocationUpdates() {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(titles[_selectedIndex]),
        ),
        body: _getPage(_selectedIndex),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildMap();
      default:
        return Container();
    }
  }

  Widget _buildMap() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Ingrese la ubicación',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchLocation();
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                _enteredLocation = value;
              });
            },
          ),
        ),
        Expanded(
          child: _currentPosition != null
              ? GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("currentLocation"),
                      position: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      infoWindow: InfoWindow(
                        title: "Mi Ubicación Actual",
                        snippet:
                            "Latitud: ${_currentPosition!.latitude}, Longitud: ${_currentPosition!.longitude}",
                      ),
                    ),
                  },
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  void _searchLocation() async {
    if (_enteredLocation.isNotEmpty) {
      List<Location> locations =
          await locationFromAddress(_enteredLocation);
      if (locations.isNotEmpty) {
        _controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(locations[0].latitude, locations[0].longitude),
          ),
        );
      } else {
        print('Ubicación no encontrada');
      }
    }
  }
}