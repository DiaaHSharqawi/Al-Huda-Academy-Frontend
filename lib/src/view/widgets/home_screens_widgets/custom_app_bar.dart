import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget appBarChilds;
  final Color backgroundColor;
  final String? appBarBackgroundImage;
  final bool? showBackArrow;

  const CustomAppBar(
      {super.key,
      required this.appBarChilds,
      required this.backgroundColor,
      this.appBarBackgroundImage,
      required super.preferredSize,
      required super.child,
      this.showBackArrow = false});

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180.0),
      child: AppBar(
        elevation: 0,
        automaticallyImplyLeading: showBackArrow!,
        leading: showBackArrow!
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigate back
                  },
                ),
              )
            : null,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 180.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: appBarBackgroundImage != null
                  ? DecorationImage(
                      image: AssetImage(appBarBackgroundImage!),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      opacity: 0.1,
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: appBarChilds,
          ),
        ),
      ),
    );
  }
}
