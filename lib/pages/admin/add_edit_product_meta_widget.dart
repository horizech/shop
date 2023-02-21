import 'package:flutter/material.dart';
import 'package:flutter_up/widgets/up_checkbox.dart';
import 'package:flutter_up/widgets/up_textfield.dart';
import 'package:shop/constants.dart';

class AddEditProductMetaWidget extends StatelessWidget {
  AddEditProductMetaWidget({
    Key? key,
  }) : super(key: key);

  Map<String, int> newOptions = {};

  @override
  Widget build(BuildContext context) {
    performance(String key, String value) {}
    features(String key, String value) {}
    return Wrap(
      children: [
        ...automobilePerformance.keys.map(
          (key) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: UpTextField(
                label: automobilePerformance[key],
                onChanged: ((value) => {
                      performance(key, value ?? ""),
                    }),
              ),
            ),
          ),
        ),
        ...automobileFeatures.keys.map(
          (key) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: UpCheckbox(
              label: automobileFeatures[key],
              onChange: ((value) => {
                    features(key, value ?? ""),
                  }),
            ),
          ),
        )
      ],
    );
  }
}
