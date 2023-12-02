import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 19.454498, longitude: -99.148634),
    areaLimit: BoundingBox(
      east: 5.4922941,
      north: 23.8084648,
      south: 22.817995,
      west:  2.9559113,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed:()async {
          await controller.enableTracking(enableStopFollow:false,);
          controller.setZoom(zoomLevel: 19);
        },
        hoverColor: Colors.orange,
        child: const Icon(Icons.location_on)
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OSMFlutter(
        controller:controller,
        trackMyPosition: false,
        initZoom: 19,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )
        ),
      ),
    );
  }
}