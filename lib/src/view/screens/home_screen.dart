import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      preferredSize: const Size.fromHeight(180.0),
      backgroundColor: AppColors.primaryColor,
      appBarBackgroundImage: ('assets/images/quran.png'),
      appBarChilds: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRemainingTimeToNextPrayer(),
            const SizedBox(height: 16.0),
            _buildUserLocation(),
            const SizedBox(height: 16.0),
            _buildCurrentCurrentDate(),
          ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      backgroundColor: AppColors.primaryBackgroundColor,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark),
          label: 'الاذكار',
        ),
      ],
    );
  }

  Widget _buildRemainingTimeToNextPrayer() {
    return const SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomGoogleTextWidget(
            text: "الفجر بعد",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          SizedBox(width: 12.0),
          CustomGoogleTextWidget(
            text: "03:02:00",
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildUserLocation() {
    return const Row(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white,
          size: 24.0,
        ),
        SizedBox(width: 12.0),
        CustomGoogleTextWidget(
          text: "فلسطين - نابلس",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildCurrentCurrentDate() {
    return const Row(
      children: [
        Icon(
          Icons.date_range,
          color: Colors.white,
          size: 24.0,
        ),
        SizedBox(width: 12.0),
        CustomGoogleTextWidget(
          text: "الأحد ١٤٤٣/١١/١٤",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ],
    );
  }
}
