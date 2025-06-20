import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:softvence_agency_task/constants/app_colors.dart';
import 'package:softvence_agency_task/constants/app_image.dart';
import 'package:softvence_agency_task/constants/app_text_style.dart';
import 'package:softvence_agency_task/features/home/home.dart';
import 'package:softvence_agency_task/features/location/controllers/location_controller.dart';

class LocationView extends StatelessWidget {
   LocationView({super.key});
   final controller = Get.put(LocationController());
  @override
   Widget build(BuildContext context) {
   var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
     
      backgroundColor: AppColors.bgColor,
      body: Obx(() => controller.isLoading ==true?CircularProgressIndicator():Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height:screenHeight>700? 134.h:100),
            Text(
              "Welcome! Your Personalized Alarm",
              style: globalPoppinStyle(fs: 28, fw: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            Text(
              "Allow us to sync your sunset alarm based on your location.",
              style: globalTextStyle(),
            ),
            SizedBox(height: 44.h),
            Image.asset(AppImage.image4),
            MaterialButton(
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8)
              ),
              onPressed: () {
                controller.determinePosition(context);
              },
              color: Color(0xff4D4D4D),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text("Use Current Location ",style: globalPoppinStyle(
                  fs: 16,
                  fw: FontWeight.w400 
                 ),),
                SvgPicture.asset(AppImage.location),
              ],
              ),
            ),
            SizedBox(height: 7,),
            MaterialButton(
              
              minWidth: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8)
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
              },
              color: Color(0xff4D4D4D),
              child: Text("Home",style: globalPoppinStyle(
                  fs: 16.sp,
                  fw: FontWeight.w400 
                 ),),
            ),
          ],
        ),
      ),)
    );
  }
}
