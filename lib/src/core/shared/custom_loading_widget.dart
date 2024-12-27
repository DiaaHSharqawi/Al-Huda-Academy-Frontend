import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    required this.imagePath,
  });
  final double width;
  final double height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}
