import 'package:carousel_slider/carousel_slider.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class CustomCarouselSliderWidget extends StatefulWidget {
  final Function(int)? onPageChanged;
  final CarouselSliderController controller;
  const CustomCarouselSliderWidget({
    super.key,
    required this.onPageChanged,
    required this.controller,
  });

  @override
  State<CustomCarouselSliderWidget> createState() =>
      _CustomCarouselSliderWidgetState();
}

class _CustomCarouselSliderWidgetState
    extends State<CustomCarouselSliderWidget> {
  final List<CarouselItem> carouselItems = [
    CarouselItem(text: Labels.infoLabel_1),
    CarouselItem(text: Labels.infoLabel_2),
    CarouselItem(text: Labels.infoLabel_3),
  ];

  final List backgroundImages = [
    Images.firstInfoImage,
    Images.secondInfoImage,
    Images.thirdInfoImage,
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: size.width / 50,
            top: size.height / 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
                carouselItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  return AnimatedContainer(
                    width: _currentIndex == index ? 24 : 8,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: ShapeDecoration(
                      color:
                          _currentIndex == index
                              ? colorScheme.onTertiaryContainer
                              : colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color:
                              _currentIndex == index
                                  ? colorScheme.onTertiaryContainer
                                  : colorScheme.primaryContainer,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    duration: const Duration(milliseconds: 300),
                  );
                }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height / 1.87),
          child: CarouselSlider.builder(
            itemCount: carouselItems.length,
            carouselController: widget.controller,
            itemBuilder: (context, index, realIndex) {
              return Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                carouselItems[index].text,
              );
            },
            options: CarouselOptions(
              height: 170,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
                widget.onPageChanged!(index);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselItem {
  final String text;

  CarouselItem({required this.text});
}
