import 'package:flutter/material.dart';
import 'package:tftap/core/app_gradients.dart';
import 'package:tftap/core/app_text_styles.dart';
import 'package:tftap/home/home_page.dart';
import 'package:tftap/splash/widgets/opacity_card_widget.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(gradient: AppGradients.linear),
            ),
            Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OpacityCardWidget(),
                      OpacityCardWidget(),
                      OpacityCardWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OpacityCardWidget(),
                      Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TFTap',
                                style: AppTextStyles.titleWhite30,
                              ),
                            ],
                          )),
                      OpacityCardWidget(),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OpacityCardWidget(),
                      OpacityCardWidget(),
                      OpacityCardWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
