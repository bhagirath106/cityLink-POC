import 'package:carousel_slider/carousel_controller.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/app_info_screen/widget/carousel_slider_widget.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:cgc_project/widgets/noaccount.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  int pageNumber = 0;
  List<String> images = [
    Images.firstInfoImage,
    Images.secondInfoImage,
    Images.thirdInfoImage,
  ];

  CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            controller.previousPage();
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            controller.nextPage();
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        pageNumber == 1
                            ? size.height / 40
                            : pageNumber == 2
                            ? size.height / 30
                            : size.height / 8.0,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetImage(images[pageNumber]),
                      key: ValueKey<int>(pageNumber),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomCarouselSliderWidget(
                          onPageChanged: (index) {
                            setState(() {
                              pageNumber = index;
                            });
                          },
                          controller: controller,
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: size.width / 25,
                  right: size.width / 23,
                  bottom: size.height / 20,
                  child: Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        labels: Labels.login,
                      ),
                      NoAccount(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
