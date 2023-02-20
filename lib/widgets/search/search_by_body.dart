import 'package:apiraiser/apiraiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/locator.dart';
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
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.car_repair_rounded),
                  UpText("Hatchback")
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
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.car_repair_rounded),
                  UpText("Estate")
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Icon(Icons.car_repair_rounded), UpText("SUV")],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.car_repair_rounded),
                  UpText("Saloon")
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.car_repair_rounded),
                  UpText("Coupe")
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.car_repair_rounded),
                  UpText("Convertible")
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: UpConfig.of(context).theme.primaryColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Icon(Icons.car_repair_rounded), UpText("MPV")],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
