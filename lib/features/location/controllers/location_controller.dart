import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:softvence_agency_task/constants/app_colors.dart';
import 'package:softvence_agency_task/constants/app_text_style.dart';

class LocationController extends GetxController{



  Rx<Position?> position = Rx<Position?>(null);
  RxString locationAddress = ''.obs;
  var isLoading = false.obs;
  Future<void> determinePosition(BuildContext context) async {
    isLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      
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
            
            decoration: BoxDecoration(
              color: AppColors.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            ),
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 16
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min  ,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Current location",style: globalPoppinStyle(),)),
                SizedBox(height: 10,),
                Text(locationAddress.value,style: globalPoppinStyle(),),
              ],
            ),
          );
        },);
      }
    }
    }
    isLoading.value = false;
   }
  
   
}