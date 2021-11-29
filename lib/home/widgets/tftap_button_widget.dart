import 'package:flutter/material.dart';
import 'package:tftap/core/app_colors.dart';
import 'package:tftap/core/app_text_styles.dart';

class TftapButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Color color;

  TftapButtonWidget({
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: AppTextStyles.bodyWhite.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
