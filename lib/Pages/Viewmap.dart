// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMapPage extends StatefulWidget {
  ViewMapPage({Key? key}) : super(key: key);

  @override
  State<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  Position? userLocation;
  double? lag, lng;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: userLocation == null
              ? CircularProgressIndicator()
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {},
                  markers: _getMarkers(),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lag!, lng!),
                    zoom: 15,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();

    setState(() {
      lag = userLocation!.latitude;
      lng = userLocation!.longitude;
    });

    print(lag);
    print(lng);
  }

  Set<Marker> _getMarkers() => <Marker>[
        Marker(
          position: LatLng(lag!, lng!),
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(
            title: 'ตำแหน่งของคุณ',
            snippet: 'ตำแหน่งของคุณ',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
        Marker(
          position: LatLng(lag!, lng!),
          markerId: MarkerId('2'),
          infoWindow: InfoWindow(
            title: 'ตำแหน่งของลูกค้า',
            snippet: 'ตำแหน่งของลูกค้า',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      ].toSet();
}
