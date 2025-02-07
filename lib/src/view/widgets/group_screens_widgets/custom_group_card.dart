import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomGroupCard extends StatelessWidget {
  final String groupName;
  final String? studentsCount;
  final String? language;
  final String? groupGoal;
  final String? groupGender;
  final VoidCallback onDetailsPressed;
  final String? days;
  final String? groupTime;
  final String? groupSupervisorName;
  final String? groupDescription;
  final String? groupCompletionRate;
  final int? recommendedFlag;

  const CustomGroupCard({
    super.key,
    required this.groupName,
    required this.onDetailsPressed,
    this.groupDescription,
    this.groupSupervisorName,
    this.studentsCount,
    this.language,
    this.groupGoal,
    this.groupGender,
    this.days,
    this.groupTime,
    this.groupCompletionRate,
    this.recommendedFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const Divider(
            color: AppColors.primaryColor,
            height: 20,
            thickness: 2,
          ),
          groupSupervisorName == null
              ? const SizedBox.shrink()
              : _buildSupervisorGroup(),
          groupDescription == null
              ? const SizedBox.shrink()
              : _buildGroupDescription(),
          studentsCount == null
              ? const SizedBox.shrink()
              : _buildStudentsCount(),
          groupCompletionRate == null
              ? const SizedBox.shrink()
              : _buildGroupCompletionRate(),
          groupGender == null
              ? const SizedBox.shrink()
              : _buildParticipantGender(),
          days == null ? const SizedBox.shrink() : _buildGroupDays(),
          groupTime == null ? const SizedBox.shrink() : _buildGroupTime(),
          const SizedBox(height: 16.0),
          (recommendedFlag == null || recommendedFlag == 0)
              ? const SizedBox.shrink()
              : _buildRecommendedFlag(),
          const SizedBox(height: 16.0),
          _buildDetailsButton(),
        ],
      ),
    );
  }

  Widget _buildRecommendedFlag() {
    if (recommendedFlag != 1) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.recommend,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 8.0),
              CustomGoogleTextWidget(
                text: "مقترح لك",
                fontSize: 18.0,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupCompletionRate() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.supervised_user_circle,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "معدل انجاز الحلقة",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: groupCompletionRate!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSupervisorGroup() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.supervised_user_circle,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "المشرف على المجموعة: ",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: groupSupervisorName!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupDescription() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.supervised_user_circle,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomGoogleTextWidget(
                    text: "وصف المجموعة: ",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  CustomGoogleTextWidget(
                    text: groupDescription!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupTime() {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: " وقت المجموعة: ",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: groupTime!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupDays() {
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_today_sharp,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "أيام المجموعة: ",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: days!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildParticipantGender() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.male,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "جنس المشاركين: ",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: groupGender!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.group,
          color: AppColors.primaryColor,
          size: 40.0,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomGoogleTextWidget(
                text: groupName,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16.0),
              groupGoal == null
                  ? const SizedBox.shrink()
                  : Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: CustomGoogleTextWidget(
                            text: "هدف المجموعة:",
                            fontSize: 18.0,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomGoogleTextWidget(
                            text: groupGoal!,
                            fontSize: 16.0,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsCount() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.people,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "عدد الطلاب:",
                    fontSize: 18.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12.0),
                  CustomGoogleTextWidget(
                    text: studentsCount!,
                    fontSize: 16.0,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailsButton() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
          buttonText: "عرض التفاصيل",
          onPressed: onDetailsPressed,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          buttonTextColor: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
