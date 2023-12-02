import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String longitude1 ="";
  String latitude1 ="";

  Future<Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();

  }

  void getCurrentLocation() async{
    Position position=await determinePosition();
    setState(() {
      latitude1=position.latitude.toString();
      longitude1=position.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[

              SizedBox(
                height: 50,
                width: 500,
                child: Text(
                  "Latitude: " + latitude1,style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: Text(
                  "Longitude: " + longitude1,style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    getCurrentLocation();
                  },
                  child: const Text('Tomar Location', style: TextStyle(fontSize: 30)),
                ),
              ),
            ]
        ),
      ),
    );
  }
}