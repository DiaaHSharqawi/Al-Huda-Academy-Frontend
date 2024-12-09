import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/home_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  final String name = 'Loading...'; // Default value

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomGoogleTextWidget(text: 'This is Home Screen'),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return CustomAppBar(
      preferredSize: const Size.fromHeight(150.0),
      backgroundColor: AppColors.primaryColor,
      appBarChilds: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 80.0,
                  height: 80.0,
                ),
                /* child: CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/dvqxt060a/image/upload/v1731927088/uploads/tabsfvu8obg4gjeryock.png",
                      scale: 3.5,
                    ),
                  ),
                ),*/
                const SizedBox(width: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomGoogleTextWidget(
                      text: 'السلام عليكم',
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    const SizedBox(height: 8.0),
                    controller.welcomeName.value.isNotEmpty
                        ? CustomGoogleTextWidget(
                            text: controller.welcomeName.value,
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        }),
      ),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return const CustomBottomNavigationBar();
  }
}
