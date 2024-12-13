import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget appBarChilds;
  final Color backgroundColor;
  final String? appBarBackgroundImage;
  final bool? showBackArrow;
  final Color? arrowColor;
  final double? arrowMargin;

  const CustomAppBar({
    super.key,
    required this.appBarChilds,
    required this.backgroundColor,
    this.appBarBackgroundImage,
    super.preferredSize = const Size.fromHeight(180.0),
    required super.child,
    this.showBackArrow = false,
    this.arrowColor = Colors.white,
    this.arrowMargin = 10,
  });

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        elevation: 0,
        automaticallyImplyLeading: showBackArrow!,
        leading: showBackArrow!
            ? Container(
                margin: EdgeInsets.all(arrowMargin!),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: arrowColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Navigate back
                    },
                  ),
                ),
              )
            : null,
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: appBarBackgroundImage != null
                  ? DecorationImage(
                      image: AssetImage(
                        appBarBackgroundImage!,
                      ),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center,
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
