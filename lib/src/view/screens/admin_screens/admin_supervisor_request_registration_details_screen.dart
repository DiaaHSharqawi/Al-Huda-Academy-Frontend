import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_request_registration_details_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/accept_supervisor_request_registration_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/reject_supervisor_request_registration_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminSupervisorRequestRegistrationDetailsScreen
    extends GetView<AdminSupervisorRequestRegistrationDetailsController> {
  const AdminSupervisorRequestRegistrationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Lottie.asset(
                        'assets/images/loaderLottie.json',
                        width: 600,
                        height: 600,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderSection(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildSupervisorRequestDetails(context),
                          const SizedBox(
                            height: 32.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildAcceptButton(),
                              const SizedBox(
                                width: 16.0,
                              ),
                              _buildRejecttButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupervisorCertificates(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        const Icon(
          CupertinoIcons.person,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 16.0),
        const Expanded(
          child: CustomGoogleTextWidget(
            text: "الصورة الشخصية",
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        Expanded(
          child: Center(
            child: CustomButton(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.primaryColor,
              buttonText: 'اضغط لعرض الشهادات والخبرات',
              buttonTextAlign: TextAlign.center,
              buttonTextColor: AppColors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(
                              controller
                                  .supervisorRequestRegistrationDetails
                                  .value!
                                  .supervisorCertificates[index]
                                  .certificateImage!,
                            ),
                            initialScale: PhotoViewComputedScale.contained * 1,
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 4.0,
                            heroAttributes: PhotoViewHeroAttributes(
                              tag: controller
                                      .supervisorRequestRegistrationDetails
                                      .value!
                                      .supervisorCertificates[index]
                                      .id ??
                                  'defaultTag',
                            ),
                          );
                        },
                        itemCount: controller
                            .supervisorRequestRegistrationDetails
                            .value!
                            .supervisorCertificates
                            .length,
                        loadingBuilder: (context, event) => Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: event == null
                                  ? null
                                  : event.cumulativeBytesLoaded.toDouble() /
                                      (event.expectedTotalBytes?.toDouble() ??
                                          1.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildAcceptButton() {
    return CustomButton(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primaryColor,
      buttonText: 'قبول الطلب',
      buttonTextColor: AppColors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      onPressed: () {
        debugPrint(" accept Button Pressed");
        showAcceptSupervisorRequestDialog();
      },
    );
  }

  void showAcceptSupervisorRequestDialog() {
    debugPrint("accept Supervisor Request");

    debugPrint("accept Button Pressed");

    CustomAwesomeDialog.showAwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.info,
      title: "هل انت متأكد من قبول الطلب؟",
      description: "سيتم قبول الطلب",
      btnOkOnPress: () async {
        debugPrint("btnOkOnPress");

        AcceptSupervisorRequestRegistrationResponseModel
            acceptSupervisorRequestRegistrationResponseModel =
            await controller.acceptSupervisorRequestRegistration();

        debugPrint(
            "acceptSupervisorRequestRegistrationResponseModel: $acceptSupervisorRequestRegistrationResponseModel");

        if (acceptSupervisorRequestRegistrationResponseModel.statusCode ==
            200) {
          CustomAwesomeDialog.showAwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.success,
            title: "تم قبول الطلب بنجاح",
            description: "تم قبول الطلب بنجاح",
            btnOkOnPress: () {
              controller.navigateToAdminSupervisorRequests();
            },
            btnCancelOnPress: null,
          );
        } else {
          CustomAwesomeDialog.showAwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.error,
            title: "فشل في قبول الطلب",
            description:
                acceptSupervisorRequestRegistrationResponseModel.message!,
            btnOkOnPress: () {},
            btnCancelOnPress: null,
          );
        }
      },
      btnCancelOnPress: () {},
    );
  }

  Widget _buildRejecttButton() {
    return CustomButton(
      foregroundColor: AppColors.white,
      backgroundColor: const Color(0xFF844343),
      buttonText: 'رفض الطلب',
      buttonTextColor: AppColors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      onPressed: () {
        debugPrint("reject Button Pressed");
        CustomAwesomeDialog.showAwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.info,
          title: "هل انت متأكد من رفض الطلب؟",
          description: "سيتم رفض الطلب",
          btnOkOnPress: () async {
            debugPrint("btnOkOnPress");

            RejectSupervisorRequestRegistrationResponseModel
                rejectSupervisorRequestRegistrationResponseModel =
                await controller.rejectSupervisorRequestRegistration();

            debugPrint(
                "rejectSupervisorRequestRegistrationResponseModel: $rejectSupervisorRequestRegistrationResponseModel");

            if (rejectSupervisorRequestRegistrationResponseModel.statusCode ==
                200) {
              CustomAwesomeDialog.showAwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.success,
                title: "تم رفض الطلب بنجاح",
                description: "تم رفض الطلب بنجاح",
                btnOkOnPress: () {
                  controller.navigateToAdminSupervisorRequests();
                },
                btnCancelOnPress: null,
              );
            } else {
              CustomAwesomeDialog.showAwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                title: "فشل في قبول الطلب",
                description:
                    rejectSupervisorRequestRegistrationResponseModel.message!,
                btnOkOnPress: () {},
                btnCancelOnPress: null,
              );
            }
          },
          btnCancelOnPress: () {},
        );
      },
    );
  }

  Widget _buildSupervisorRequestDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTableHeader(),
        _buildSupervisorName(),
        _buildSupervisorGender(),
        _buildSupervisorBirthOfDate(),
        _buildSupervisorPhoneNumber(),
        _buildSupervisorCountry(),
        _buildSupervisorCity(),
        _buildSupervisorDescription(),
        _buildSupervisorImageProfile(context),
        _buildSupervisorRequestRegistrationDateTime(),
        _buildSupervisorCertificates(context),
        const SizedBox(
          height: 12.0,
        ),
        _buildGroupJuza(),
      ],
    );
  }

// start juza
  Widget _buildGroupJuza() {
    return Column(
      children: [
        _buildGroupContentJuzaDetailsHeader(),
        _buildGroupContentJuzaRows(),
      ],
    );
  }

  Widget _buildGroupContentJuzaRows() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: controller.supervisorRequestRegistrationDetails.value!.juzas
            .map((content) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.id.toString(),
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.arabicPart!,
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGroupContentJuzaDetailsHeader() {
    return Center(
      child: Container(
        color: const Color(0xffd1c7af),
        padding: const EdgeInsets.all(12.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomGoogleTextWidget(
                text: "رقم الجزء",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            Expanded(
              child: CustomGoogleTextWidget(
                text: "اسم الجزء",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
// end juza

  Widget _buildSupervisorRequestRegistrationDateTime() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.calendar,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "تاريخ الطلب",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text:
                  "${controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().day}/${controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().month}/${controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().year}\n"
                  "${(controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().hour % 12 == 0 ? 12 : controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().hour % 12)}:${controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().minute.toString().padLeft(2, '0')} ${controller.supervisorRequestRegistrationDetails.value!.createdAt!.toLocal().hour >= 12 ? 'مساءاً' : 'صباحاً'}",
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorImageProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        const Icon(
          CupertinoIcons.person,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 16.0),
        const Expanded(
          child: CustomGoogleTextWidget(
            text: "الصورة الشخصية",
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        CustomButton(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.primaryColor,
          buttonText: 'اضغط لعرض الصورة',
          buttonTextColor: AppColors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Image.network(
                    controller.supervisorRequestRegistrationDetails.value!
                        .profileImage!,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const CustomGoogleTextWidget(
                        text: "الصورة غير متوفرة",
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Center(
                        child: CustomGoogleTextWidget(
                          text: "اغلاق",
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ]),
    );
  }

  Widget _buildSupervisorDescription() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.description,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "الوصف",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .supervisorRequestRegistrationDetails.value!.details!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorCity() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.location_city,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "المدينة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text:
                  controller.supervisorRequestRegistrationDetails.value!.city!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorCountry() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.location,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "الدولة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .supervisorRequestRegistrationDetails.value!.country!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorGender() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.person,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "الجنس",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .supervisorRequestRegistrationDetails.value!.gender!.nameAr!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorPhoneNumber() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.phone,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "رقم الهاتف",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .supervisorRequestRegistrationDetails.value!.phone!
                  .replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{4})'),
                      (Match m) => '${m[1]}-${m[2]}-${m[3]}'),
              textDecoration: TextDecoration.underline,
              onTap: () {
                final phone = controller
                    .supervisorRequestRegistrationDetails.value!.phone!;
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: phone,
                );
                launchUrl(launchUri);
              },
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorBirthOfDate() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.calendar,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "تاريخ الميلاد",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text:
                  "${controller.supervisorRequestRegistrationDetails.value!.dateOfBirth!.toLocal().day}/${controller.supervisorRequestRegistrationDetails.value!.dateOfBirth!.toLocal().month}/${controller.supervisorRequestRegistrationDetails.value!.dateOfBirth!.toLocal().year}",
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorName() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.group,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.supervisorRequestRegistrationDetails.value!
                          .gender!.nameEn! ==
                      "male"
                  ? "اسم المشرف"
                  : "اسم المشرفة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .supervisorRequestRegistrationDetails.value!.fullName!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppColors.primaryColor.withOpacity(0.4),
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        children: [
          Expanded(
            child: CustomGoogleTextWidget(
              text: "المعلومات",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: "التفاصيل",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      children: [
        CustomGoogleTextWidget(
          text: "تفاصيل طلب التسجيل كمشرف",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ],
    );
  }

  PreferredSize _buildAppBar() {
    return const CustomAppBar(
      showBackArrow: true,
      arrowMargin: 16.0,
      preferredSize: Size.fromHeight(150.0),
      appBarBackgroundImage: "assets/images/ornament1.png",
      appBarChilds: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      child: SizedBox.expand(),
    );
  }
}
