import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/create_group_supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_radio_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class SupervisorCreateMemorizationGroupContentScreen
    extends GetView<SupervisorCreateGroupController> {
  const SupervisorCreateMemorizationGroupContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CustomLoadingWidget(
                        imagePath: 'assets/images/loaderLottie.json',
                        width: 600,
                        height: 600,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 16.0,
                        ),
                        _buildCreateGroupContent(context),
                        const SizedBox(height: 16.0),
                        //_buildCreateGroupButton(context),
                        const SizedBox(height: 16.0),
                        _buildCreateGroupButton(context),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateGroupContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: "اختر المحتوى الذي تريد تعليمه",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          const SizedBox(height: 16.0),
          _buildGroupContentChoice(context),
        ],
      ),
    );
  }

  Widget _buildGroupContentChoice(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            children: controller.teachingMethods
                .take(2)
                .map(
                  (method) => Expanded(
                    child: CustomRadioListTile<GroupTeachingMethodEnum>(
                      title: CustomGoogleTextWidget(
                        text: method.methodNameArabic!,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                      ),
                      value: GroupTeachingMethodEnum.values.firstWhere(
                          (filter) => filter.name == method.methodNameEnglish),
                      groupValue: controller.selectedTeachingMethod.value,
                      selected:
                          controller.selectedTeachingMethod.value.toString() ==
                              method.methodNameEnglish,
                      onChanged: (value) {
                        if (value != null) {
                          debugPrint("Selected content: $value");
                          controller.selectedTeachingMethod.value = value;
                          controller.setSelectedTeachingMethodId();
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16.0),
          ...controller.teachingMethods.skip(2).map(
                (method) => Column(
                  children: [
                    CustomRadioListTile<GroupTeachingMethodEnum>(
                      title: CustomGoogleTextWidget(
                        text: method.methodNameArabic!,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                      ),
                      value: GroupTeachingMethodEnum.values.firstWhere(
                          (filter) => filter.name == method.methodNameEnglish),
                      groupValue: controller.selectedTeachingMethod.value,
                      selected:
                          controller.selectedTeachingMethod.value.toString() ==
                              method.methodNameEnglish,
                      onChanged: (value) {
                        if (value != null) {
                          debugPrint(" selectedTeachingMethod: $value");
                          if (value == GroupTeachingMethodEnum.extractsQuran ||
                              value == GroupTeachingMethodEnum.surahsQuran) {
                            controller.selectedSurahs.clear();
                          }

                          controller.selectedTeachingMethod.value = value;
                          controller.setSelectedTeachingMethodId();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (controller.selectedTeachingMethod.value.name ==
                        method.methodNameEnglish)
                      Obx(() => _buildPartOfQuranChoice()),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildExtractSurahSelection() {
    return Column(children: [
      Obx(
        () => controller.selectedTeachingMethod.value ==
                GroupTeachingMethodEnum.extractsQuran
            ? Column(
                children: [
                  MultiSelectDialogField<Surah>(
                    searchable: true,
                    initialValue: controller.selectedSurahs,
                    items: controller.surahs
                        .map((surah) =>
                            MultiSelectItem<Surah>(surah, surah.name!))
                        .toList(),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    title: const CustomGoogleTextWidget(
                      text: "اختر السور",
                      fontSize: 16.0,
                    ),
                    selectedColor: AppColors.primaryColor,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryColor,
                    ),
                    buttonText: Text(
                      "اختر السور",
                      style: GoogleFonts.almarai(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                      ),
                    ),
                    onConfirm: (values) {
                      debugPrint("Selected surahs: $values");
                      debugPrint("Selected surahs: ${values.isEmpty}");

                      controller.selectedSurahs.value = values;
                      controller.ayatForSurahs.clear();
                      controller.textControllers.clear();

                      controller.textControllers.addAll({
                        for (var surah in controller.selectedSurahs)
                          surah.id!: TextEditingController()
                      });
                    },
                  ),
                  Obx(
                    () => controller.selectedSurahs.isNotEmpty &&
                            controller.selectedTeachingMethod.value ==
                                GroupTeachingMethodEnum.extractsQuran
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24.0,
                            ),
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          color: AppColors.primaryColor
                                              .withOpacity(0.3),
                                          child: const CustomGoogleTextWidget(
                                            text: "السور",
                                            fontSize: 16.0,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          color: AppColors.primaryColor
                                              .withOpacity(0.3),
                                          child: const CustomGoogleTextWidget(
                                            text: "الايات",
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  ...controller.selectedSurahs.map((surah) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: CustomGoogleTextWidget(
                                                text: surah.name!,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextFormField(
                                                  textFormFieldValidator:
                                                      GroupValidations
                                                          .validateAyat,
                                                  maxLines: 1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  controller: controller
                                                          .textControllers[
                                                      surah.id!]!,
                                                  enableBorder: false,
                                                  textFormLabelText:
                                                      "ادخل الايات",
                                                  textFormHintText: "5-1,15-10",
                                                  onChanged: (value) {
                                                    controller
                                                        .textControllers[
                                                            surah.id!]!
                                                        .text = value;

                                                    debugPrint(
                                                        "selected text controllers: ${controller.textControllers.map((key, value) => MapEntry(key, value.text))}");
                                                    debugPrint(
                                                        "Selected surahs: ${controller.selectedSurahs.toString()}");
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  )
                ],
              )
            : Container(),
      )
    ]);
  }

  Widget _buildPartOfQuranChoice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMultiSurahSelection(),
        // const SizedBox(height: 16.0),
        _buildMultiJuzzaSelection(),
        //const SizedBox(height: 16.0),
        _buildExtractSurahSelection(),
      ],
    );
  }

  Widget _buildMultiSurahSelection() {
    return Column(
      children: [
        if (controller.selectedTeachingMethod.value ==
            GroupTeachingMethodEnum.surahsQuran)
          Obx(
            () => MultiSelectDialogField<Surah>(
              searchable: true,
              initialValue: controller.selectedSurahs,
              items: controller.surahs
                  .map((surah) => MultiSelectItem<Surah>(surah, surah.name!))
                  .toList(),
              chipDisplay: MultiSelectChipDisplay<Surah>(
                chipColor: AppColors.primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                items: controller.selectedSurahs
                    .map((surah) => MultiSelectItem<Surah>(surah, surah.name!))
                    .toList(),
                onTap: (value) {
                  controller.selectedSurahs.remove(value);
                },
              ),
              title: const CustomGoogleTextWidget(
                text: "اختر السور",
                fontSize: 16.0,
              ),
              selectedColor: AppColors.primaryColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryColor,
              ),
              buttonText: Text(
                "اختر السور",
                style: GoogleFonts.almarai(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              ),
              onConfirm: (values) {
                debugPrint("Selected surahs: $values");
                debugPrint("Selected surahs: ${values.isEmpty}");

                controller.selectedSurahs.value = values;
                debugPrint(
                    "Selected surahs: ${controller.selectedSurahs.toString()}");
              },
            ),
          )
      ],
    );
  }

  Widget _buildMultiJuzzaSelection() {
    return Column(
      children: [
        if (controller.selectedTeachingMethod.value ==
            GroupTeachingMethodEnum.juzasQuran)
          MultiSelectDialogField(
            searchable: true,
            searchHint: 'ابحث عن الجزء',
            items: controller.juzas
                .map((juz) => MultiSelectItem(juz, juz.arabicPart!))
                .toList(),
            chipDisplay: MultiSelectChipDisplay<Juza>(
              chipColor: AppColors.primaryColor,
              textStyle: GoogleFonts.getFont(
                'Almarai',
                color: Colors.white,
                fontSize: 16.0,
              ),
              items: controller.selectedJuzzas
                  .map((juz) => MultiSelectItem<Juza>(juz, juz.arabicPart!))
                  .toList(),
              onTap: (value) {
                controller.selectedJuzzas.remove(value);
              },
            ),
            title: const CustomGoogleTextWidget(
              text: "اختر الأجزاء",
              fontSize: 16.0,
            ),
            selectedColor: AppColors.primaryColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            buttonIcon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.primaryColor,
            ),
            buttonText: Text(
              "اختر الأجزاء",
              style: GoogleFonts.almarai(
                fontSize: 16.0,
                color: AppColors.blackColor,
              ),
            ),
            onConfirm: (values) {
              controller.selectedJuzzas.value = values;
              debugPrint(
                  "Selected juzs: ${controller.selectedJuzzas.toString()}");
            },
          ),
      ],
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: CustomButton(
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : null,
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: "استمر",
            buttonTextColor: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              var response = await controller.createANewMemorizationGroup();
              if (!context.mounted) return;

              if (response['statusCode'] == 201) {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.success,
                  "تم انشاء المجموعة بنجاح",
                  response['message'],
                );
                controller.navigateToSupervisorDashboardScreen();
              } else {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.error,
                  "حدث خطأ",
                  response['message'],
                );
              }
            },
          ),
        ));
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
