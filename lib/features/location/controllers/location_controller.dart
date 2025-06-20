import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController{
  Rx<Position?> position = Rx<Position?>(null);
  RxString locationAddress = ''.obs;
  var isLoading = false.obs;
  Future<void> determinePosition(BuildContext context) async {
    isLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show a message
      // permissionDeniedMessage.value =
      //     'Location services are disabled, Please Enabled to Continue';
      
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      
        
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      
     
    }

 
    position.value = await Geolocator.getCurrentPosition();
    
    if (kDebugMode) {
      print("lat is ${position.value?.latitude.toString()}");
      print("long is ${position.value?.longitude.toString()}");
    }

    if (position.value != null) {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.value!.latitude,
      position.value!.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      locationAddress.value =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
        
      if(context.mounted&& locationAddress.value!= ''){
        showModalBottomSheet(
          isScrollControlled: true,
          context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 16
            ),
            child: Text(locationAddress.value),
          );
        },);
      }
    }
    }
    isLoading.value = false;
  }
  
}