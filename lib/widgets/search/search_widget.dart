import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/up_app.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: UpConfig.of(context).theme.primaryColor, width: 4),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: UpConfig.of(context).theme.primaryColor,
                ),
                Text(
                  "Make/Model Seach",
                  // style: UpConfig.of(context).theme.primaryColor,
                  style: TextStyle(
                    color: UpConfig.of(context).theme.primaryColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
            child: UpDropDown(
              // value: value,
              itemList: const [],
              label: "Make",
              onChanged: ((value) {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
            child: UpDropDown(
              // value: value,
              itemList: const [],
              label: "Model",
              onChanged: ((value) {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: UpButton(
              onPressed: () {},
              style: UpStyle(buttonWidth: 100),
              text: "Search",
            ),
          )
        ],
      ),
    );
  }
}
