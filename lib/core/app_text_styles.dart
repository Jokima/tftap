import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle bodyWhite20 = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyWhite = GoogleFonts.notoSans(
    color: AppColors.white,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle titleWhite30 = GoogleFonts.notoSans(
    color: AppColors.white,
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );
}
