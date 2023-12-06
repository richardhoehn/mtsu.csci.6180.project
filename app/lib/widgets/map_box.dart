import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBox extends StatefulWidget {
  MapBox({super.key, required this.ticket});
  Ticket ticket;

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    LatLng centerMap = getTicketLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: centerMap, zoom: 16),
    ));
  }

  LatLng getTicketLocation() {
    return LatLng(widget.ticket.geoLocation.lat, widget.ticket.geoLocation.lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Config.colors.backgroundColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(11)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
            markers: {
              Marker(
                infoWindow: InfoWindow(
                  title: widget.ticket.name,
                  snippet: widget.ticket.licencePlate,
                ),
                markerId: MarkerId(widget.ticket.id),
                position: getTicketLocation(),
              ), // Marker
            },
          ),
        ),
      ),
    );
  }
}
