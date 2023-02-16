import 'package:flutter/material.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/widgets/up_text.dart';

class SearchByBodyWidget extends StatelessWidget {
  const SearchByBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Container(
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
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: UpConfig.of(context).theme.primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Icon(Icons.car_repair_rounded), UpText("Estate")],
          ),
        ),
        Container(
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
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: UpConfig.of(context).theme.primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Icon(Icons.car_repair_rounded), UpText("Saloon")],
          ),
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: UpConfig.of(context).theme.primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Icon(Icons.car_repair_rounded), UpText("Coupe")],
          ),
        ),
        Container(
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
        Container(
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
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: UpConfig.of(context).theme.primaryColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Icon(Icons.car_repair_rounded), UpText("Pickup")],
          ),
        ),
      ],
    );
  }
}
