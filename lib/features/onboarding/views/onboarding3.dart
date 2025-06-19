import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softvence_agency_task/common_widget/custom_button.dart';
import 'package:softvence_agency_task/constants/app_colors.dart';
import 'package:softvence_agency_task/constants/app_image.dart';
import 'package:softvence_agency_task/constants/app_text_style.dart';
import 'package:softvence_agency_task/features/location/views/location_view.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
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
                  child: Image.asset(
                    AppImage.image3,
                    height:screenHeight>700? 429.h:300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 18.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Relax & Unwind",
                          style: globalPoppinStyle(
                            fs: 28.h,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: Color.fromARGB(0, 0, 0, 25),
                              ),
                            ],

                            fw: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "hope to take the courage to pursue your dreams.",
                          style: globalTextStyle(),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dotColor,
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dotColor,
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          title: "Next",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationView(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height:screenHeight>700? 69.h:44),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 42.h,
            right: 22.w,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LocationView()),
                );
              },
              child: Text(
                "Skip",
                style: globalTextStyle(fs: 16, fw: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
