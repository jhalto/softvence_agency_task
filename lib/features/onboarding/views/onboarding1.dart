import 'package:flutter/material.dart';
import 'package:softvence_agency_task/constants/app_colors.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.asset("assets/gifs/image1.gif",height: 480,width: double.infinity,fit: BoxFit.cover,)),
              ],
            ),
          ),
        ],
      ),
    );

  }
}