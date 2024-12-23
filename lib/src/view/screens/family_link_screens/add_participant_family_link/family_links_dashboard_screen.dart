import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class FamilyLinksDashboardScreen extends GetView<FamilyLinkController> {
  const FamilyLinksDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  _buildWelcomeText(),
              const SizedBox(height: 64.0),
              const SizedBox(
                width: double.infinity,
                child: CustomGoogleTextWidget(
                  text: 'الحسابات المرتبطة',
                  fontSize: 20.0,
                ),
              ),
              const Divider(
                color: AppColors.primaryColor,
                thickness: 1.0,
              ),
              _buildYourFamilyLinkAccounts(),
            ],
          ),
        ),
      ),
    );
  }

/*  Widget _buildWelcomeText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const CustomGoogleTextWidget(
        text: 'مرحبا بك في عائلتك',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }*/

  Widget _buildYourFamilyLinkAccounts() {
    return SizedBox(
      height: 300.0,
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: controller.familyLinks.length,
        itemBuilder: (context, index) {
          //   final familyLink = controller.familyLinks[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120.0,
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/islamic_family1.png'),
                                // image: NetworkImage(f),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: CustomGoogleTextWidget(
                                text: 'hi',
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: CustomGoogleTextWidget(
                                text: "child",
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return const CustomAppBar(
      showBackArrow: true,
      preferredSize: Size.fromHeight(150.0),
      backgroundColor: AppColors.primaryColor,
      appBarChilds: Padding(
          padding: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomGoogleTextWidget(
                  text: "متابعة حالة الابناء",
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          )),
      child: SizedBox.expand(),
    );
  }
}
