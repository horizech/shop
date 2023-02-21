import 'package:flutter/material.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/locator.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/constants.dart';
import 'package:flutter_up/services/up_navigation.dart';
import 'package:shop/services/variation.dart';

class SearchByBodyWidget extends StatelessWidget {
  const SearchByBodyWidget({super.key});

  gotoBodyType(id) {
    Map<String, List<int>> selectedVariationsValues = {
      "Body Type": [id]
    };
    ServiceManager<VariationService>().setVariation(selectedVariationsValues);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        GestureDetector(
          onTap: () {
            gotoBodyType(164);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "Hatchback",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            gotoBodyType(165);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "Estate",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            gotoBodyType(166);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "SUV",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            gotoBodyType(167);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "Saloon",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            gotoBodyType(168);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "Coupe",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            gotoBodyType(169);
            ServiceManager<UpNavigationService>()
                .navigateToNamed(Routes.products, queryParams: {
              "collection": '9',
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: UpConfig.of(context).theme.secondaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.car_repair_rounded),
                  const SizedBox(height: 6),
                  UpText(
                    "Convertible",
                    style: UpStyle(textSize: 16, textWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
