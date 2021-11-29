import 'package:flutter/material.dart';
import 'package:tftap/core/app_text_styles.dart';

class CenterContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TFTap',
            style: AppTextStyles.titleWhite30,
          ),
        ],
      ),
    );
  }
}
