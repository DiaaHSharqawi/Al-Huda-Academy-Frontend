import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePickerDialog extends StatelessWidget {
  const CustomDatePickerDialog({
    super.key,
    required this.selectedDate,
    required this.markedDays,
  });

  final Rx<DateTime?> selectedDate;
  final List<dynamic> markedDays;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomGoogleTextWidget(
        text: "هل ترغب بتعديل يوم الخطة؟",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      content: SizedBox(
        width: 300.0,
        height: 450.0,
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    selectedDayPredicate: (day) =>
                        isSameDay(selectedDate.value, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      debugPrint("Selected Day: $selectedDay");
                      selectedDate(selectedDay);
                      selectedDate.refresh();
                    },
                    focusedDay: selectedDate.value ?? DateTime.now(),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: CustomGoogleTextWidget(
                          text: date.day.toString(),
                          fontSize: 16.0,
                          color: AppColors.white,
                        ),
                      ),
                      todayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: CustomGoogleTextWidget(
                          text: date.day.toString(),
                          fontSize: 16.0,
                          color: AppColors.white,
                        ),
                      ),
                      defaultBuilder: (context, date, events) {
                        int dayOfWeek = (date.weekday % 7) + 1;
                        Iterable<int?> listOfWeekDays = markedDays.map(
                          (e) => e.dayId,
                        );
                        bool isHighlighted = listOfWeekDays.contains(dayOfWeek);

                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? Colors.blue
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: CustomGoogleTextWidget(
                            text: date.day.toString(),
                            fontSize: 16.0,
                            color: isHighlighted
                                ? AppColors.white
                                : AppColors.blackColor,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: 'إلغاء',
            fontSize: 16.0,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: 'تأكيد',
            fontSize: 16.0,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
