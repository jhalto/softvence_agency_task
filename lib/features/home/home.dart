import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:softvence_agency_task/common_widget/custom_button.dart';
import 'package:softvence_agency_task/constants/app_colors.dart';
import 'package:softvence_agency_task/constants/app_image.dart';
import 'package:softvence_agency_task/constants/app_text_style.dart';
import 'package:softvence_agency_task/features/location/controllers/location_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
 final locationController = Get.find<LocationController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        
        statusBarIconBrightness: Brightness.light, // For dark icons on light bg
        
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 115,),
                  Text("Selected Location",
                  style: globalPoppinStyle(
                    fs: 16,
                    fw: FontWeight.w600,
                    lh: 1.5 ,
                                 
                  ),),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppImage.location2),
                      SizedBox(
                        width: 9,
                      ),
                      Expanded(child:Obx(() => Text(locationController.locationAddress.value.isEmpty?"Location is not fetched":locationController.locationAddress.value, style: globalPoppinStyle(
                        lh: 1.5,
                        fs: 16,
                        fw: FontWeight.w400
                      ),)) )
                    ],
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    onTap: (){
                      if(locationController.locationAddress.value.isEmpty){
                        Get.snackbar("Error", "Please fetch location first");
                      }
                    }, 
                    title: "Add Alarm",
                    radius: 4,
                    pv: 12,
                    clr: Color(0xff3C3D3F),
                    fs: 16,
                    fw: FontWeight.w400,
                    ),
                  SizedBox(height: 44,)
                ],
              ),
            ),
            Text("Alarms",style: globalTextStyle(
              fs: 18,
              fw: FontWeight.w500,
              lh: 1.55
            ),),
            SizedBox(
              height: 16,
            ),
             Container(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Color(0xff3C3D3F),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("7:10 pm"
                  ,style: globalPoppinStyle(
                    fs: 24,
                    fw: FontWeight.w400,
                    lh: 1.5
                  ),),
                  Row(
                    children: [
                      Text("Fri 21 Mar 2025"
                      ,style: globalPoppinStyle(
                        fs: 14,
                        lh: 1.42
                      ),),
                      SizedBox(width: 8,),
                      FlutterSwitch(
                        activeColor: AppColors.primaryColor,
                        
                        padding: 2,
                        toggleSize: 12,
                        width: 33,
                        height: 18,
                        value: true, onToggle: (bool value) { 
                        
                        value = false;
                       },)
                     
                    ],
                  )
                ],
              ),
             ),
          ],
        ),
      ),
    );
  }
}