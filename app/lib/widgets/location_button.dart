import 'package:app/services/geo_location.dart';
import 'package:app/services/ticket.dart';
import 'package:app/util/config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  Position? position;
  bool isLoading = false;

  Future<void> updateLocation() async {
    widget.ticket.updateGeoLocation(await getLocation());
    setState(() => isLoading = false);
  }

  Future<GeoLocation> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();

    return GeoLocation(lng: position.longitude, lat: position.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: Config.colors.backgroundColor,
        ),
        onPressed: () async {
          setState(() => isLoading = true);
          await updateLocation();
        },
        child: isLoading
            ? Container(
              alignment: Alignment.center,
              height: 24,
              width: 24,
                padding: const EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ))
            : const Text(
                "Update Location",
                style: TextStyle(color: Colors.white),
              ));
  }
}
