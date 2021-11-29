import 'package:flutter/material.dart';
import 'package:tftap/core/app_colors.dart';
import 'package:tftap/core/app_images.dart';
import 'package:tftap/core/app_text_styles.dart';

class ActionsCardWidget extends StatelessWidget {
  final String status;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  ActionsCardWidget(
      {this.status = 'default',
      this.name = '',
      required this.onTap,
      required this.onLongPress})
      : assert(['default', 'able', 'unable', 'out'].contains(status));

  var config = {
    'default': AppImages.user,
    'able': AppImages.check,
    'unable': AppImages.error,
    'out': AppImages.out,
  };

  String get image => config[status]!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onDoubleTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: AppColors.gold,
                width: 3,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (name != '')
                      Text(
                        name,
                        style: AppTextStyles.bodyWhite,
                        textAlign: TextAlign.center,
                      ),
                    Image.asset(
                      image,
                      height: 70,
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
}
