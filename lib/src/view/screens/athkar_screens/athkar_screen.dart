import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/athkar_controllers/athkar_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AthkarScreen extends GetView<AthkarController> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AthkarScreen({super.key}) {
    _audioPlayer.playerStateStream.listen((event) {
      debugPrint("Player state: $event");
      if (event.processingState == ProcessingState.completed) {
        controller.isPlaying.value = false;
      } else if (event.processingState == ProcessingState.ready) {
        controller.isPlaying.value = true;
      }
    });

    _audioPlayer.durationStream.listen((Duration? duration) {
      if (duration != null) {
        controller.duration.value = duration;
      }
    });

    _audioPlayer.positionStream.listen((Duration? position) {
      if (position != null) {
        controller.position.value = position;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Athkar screen building ${Get.arguments}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () {
              return controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16.0),
                        _buildLinearProgressBar(),
                        const SizedBox(height: 16.0),
                        Expanded(
                          flex: 3,
                          child: ListView(
                            primary: false,
                            shrinkWrap: false,
                            children: [
                              _buildThekerDetails(),
                              const SizedBox(height: 32.0),
                            ],
                          ),
                        ),
                        _buildMediaPlayer(),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: _buildCircularProgressIndicator(),
                              ),
                              const SizedBox(height: 32.0),
                              Expanded(
                                flex: 2,
                                child: _buildNextPreviousButtons(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: const SafeArea(
          child: CustomBottomNavigationBar(),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return CustomAppBar(
      showBackArrow: true,
      backgroundColor: AppColors.primaryColor,
      preferredSize: const Size.fromHeight(150.0),
      appBarChilds: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : _buildPageTitle(),
              ]);
        }),
      ),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildMediaPlayer() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: controller.isPlaying.value
                    ? IconButton(
                        iconSize: 48.0,
                        color: AppColors.primaryColor,
                        onPressed: () async {
                          controller.isPlaying.value = false;
                          await _audioPlayer.pause();
                        },
                        icon: const Icon(Icons.pause_circle),
                      )
                    : IconButton(
                        iconSize: 48.0,
                        color: AppColors.primaryColor,
                        onPressed: () async {
                          debugPrint("Playing audio");
                          controller.isPlaying.value = true;
                          String athkarBaseURL = dotenv.env['ATHKAR_BASE_URL']!;
                          String url =
                              "$athkarBaseURL/${controller.athkars[controller.currentAthkarIndex.value].audio!}";
                          await _audioPlayer.setUrl(url);
                          await _audioPlayer.play();
                        },
                        icon: const Icon(Icons.play_circle_fill_outlined),
                      ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Slider(
                value: controller.duration.value.inSeconds > 0
                    ? controller.position.value.inSeconds.toDouble()
                    : 0.0,
                onChanged: (value) async {
                  final Duration duration = Duration(seconds: value.toInt());
                  await _audioPlayer.seek(duration);

                  await _audioPlayer.play();
                },
                min: 0.0,
                max: controller.duration.value.inSeconds.toDouble(),
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey.shade300,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTime(controller.position.value),
                ),
                Text(
                  formatTime(
                      controller.duration.value - controller.position.value),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Widget _buildNextPreviousButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        controller.currentAthkarIndex.value == 0
            ? const SizedBox(width: 0.0)
            : Expanded(
                child: CustomButton(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  buttonText: "السابق",
                  buttonTextColor: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    await _audioPlayer.stop();

                    controller.isPlaying.value = false;
                    controller.position.value = Duration.zero;
                    controller.duration.value = Duration.zero;

                    controller
                        .athkars[controller.currentAthkarIndex.value].count!;
                    if (controller.currentAthkarIndex.value > 0) {
                      controller.currentAthkarIndex.value =
                          controller.currentAthkarIndex.value - 1;
                    }
                    controller.maxNumberofCounts.value = controller
                        .athkars[controller.currentAthkarIndex.value].count!;

                    controller.currentThekerCount.value =
                        controller.maxNumberofCounts.value;
                  },
                ),
              ),
        controller.currentAthkarIndex.value ==
                controller.totalNumberOfAthkar.value - 1
            ? const SizedBox(width: 0.0)
            : Expanded(
                child: CustomButton(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  buttonText: "التالي",
                  buttonTextColor: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    await _audioPlayer.stop();

                    controller.isPlaying.value = false;
                    controller.position.value = Duration.zero;
                    controller.duration.value = Duration.zero;

                    if (controller.currentAthkarIndex.value <
                        controller.totalNumberOfAthkar.value - 1) {
                      controller.currentAthkarIndex.value =
                          controller.currentAthkarIndex.value + 1;
                    }

                    controller.maxNumberofCounts.value = controller
                        .athkars[controller.currentAthkarIndex.value].count!;

                    controller.currentThekerCount.value =
                        controller.maxNumberofCounts.value;
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildCircularProgressIndicator() {
    return Obx(
      () {
        return InkWell(
          onTap: () {
            debugPrint(
                "Current theker count: ${controller.currentThekerCount.value}");
            if (controller.currentThekerCount.value > 0) {
              controller.currentThekerCount.value =
                  controller.currentThekerCount.value - 1;
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: CircularProgressIndicator(
                  value: 1 -
                      ((controller.currentThekerCount.value) /
                          (controller.maxNumberofCounts.value)),
                  backgroundColor: Colors.grey.shade300,
                  valueColor: controller.currentThekerCount.value > 0
                      ? const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor)
                      : const AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 8.0,
                ),
              ),
              controller.currentThekerCount.value > 0
                  ? Text(
                      (controller.currentThekerCount.value).toString(),
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  : const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48.0,
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLinearProgressBar() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: (controller.currentAthkarIndex.value + 1) /
                    (controller.totalNumberOfAthkar.value),
                color: AppColors.primaryColor,
                backgroundColor: Colors.grey.shade300,
                minHeight: 18.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32.0),
        Expanded(
          child: CustomGoogleTextWidget(
            text:
                '${controller.currentAthkarIndex.value + 1} / ${controller.totalNumberOfAthkar.value}',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }

  Widget _buildPageTitle() {
    return CustomGoogleTextWidget(
      text: controller.athkarCategoryName.value,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  Widget _buildThekerDetails() {
    return Obx(() {
      debugPrint("Athkar text: ${controller.athkars.first}");
      if (controller.athkars.isEmpty) {
        return const Center(
          child: Text('No athkar available',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade500,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: CustomGoogleTextWidget(
                text: (controller.athkars[controller.currentAthkarIndex.value]
                            .text ??
                        'No text available')
                    .replaceAll(
                        'بسم الله الرحمن الرحيم', 'بسم الله الرحمن الرحيم\n\n')
                    .replaceAll('.)', '.\n\n')
                    .replaceAll(".[", '.\n\n')
                    .replaceAll(".]", '.\n\n'),
                fontSize: 22.0,
                overflow: TextOverflow.fade,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    });
  }
}
