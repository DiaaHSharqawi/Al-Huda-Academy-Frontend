import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomCard extends StatelessWidget {
  final double paddingListTile;
  final double marginListTile;
  final double elevation;
  final Widget? avatarCard;
  final Color gFListTileColor;
  final String cardText;
  final Color cardTextColor;
  final double cardTextSize;
  final Color cardInnerBoxShadowColor;
  final Widget? icon;
  final VoidCallback? onTap;
  final Color cardColor;

  const CustomCard({
    super.key,
    this.paddingListTile = 16.0,
    this.marginListTile = 24.0,
    this.elevation = 5.0,
    required this.gFListTileColor,
    required this.cardText,
    required this.cardTextSize,
    required this.cardInnerBoxShadowColor,
    required this.cardTextColor,
    this.cardColor = Colors.white,
    this.avatarCard,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        padding: EdgeInsets.all(paddingListTile),
        margin: EdgeInsets.all(marginListTile),
        avatar: avatarCard,
        radius: 8.0,
        color: gFListTileColor,
        title: Center(
          child: CustomGoogleTextWidget(
            text: cardText,
            fontSize: cardTextSize,
            fontWeight: FontWeight.bold,
            color: cardTextColor,
            textAlign: TextAlign.center,
          ),
        ),
        icon: SizedBox(
          width: 40.0,
          child: icon,
        ),
        onTap: onTap,
        shadow: BoxShadow(
          color: cardInnerBoxShadowColor,
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: const Offset(0.0, 0.0),
          blurStyle: BlurStyle.inner,
        ),
      ),
    );
  }
}
