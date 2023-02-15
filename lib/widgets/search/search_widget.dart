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
      decoration:
          BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.search,
                  color: Color.fromRGBO(200, 16, 46, 1.0),
                ),
                Text(
                  "Make/Model Seach",
                  // style: UpConfig.of(context).theme.primaryColor,
                  style: TextStyle(color: Color.fromRGBO(200, 16, 46, 1.0)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
            child: UpDropDown(
              // value: value,
              style: UpStyle(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  dropdownLabelColor: Colors.white,
                  dropdownBorderColor: Colors.white),
              itemList: [],
              label: "Make",
              onChanged: ((value) {}),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
            child: UpDropDown(
              // value: value,
              itemList: [],
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