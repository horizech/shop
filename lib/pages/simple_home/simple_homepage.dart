import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/header/header.dart';
import 'package:shop/widgets/slider/parent_category_slider.dart';
import 'package:shop/widgets/store/store_cubit.dart';
import 'package:shop/widgets/products/product_grid_item.dart';

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<Collection> root = [];
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/bg.jpg"),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        drawer: const MenuDrawer(),
        // appBar: CustomAppbar(
        //   scaffoldKey: scaffoldKey,
        // ),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        body: Column(
          children: [
            CustomAppbar(
              scaffoldKey: scaffoldKey,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const HeaderWidget(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 250,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "Make/Model Seach",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 4),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 52, vertical: 4),
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
                      ),
                    ),
                    SizedBox(
                      child: BlocConsumer<StoreCubit, StoreState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          root = state.collections!
                              .where(
                                  ((e) => e.parent == null && e.media != null))
                              .toList();

                          return ParentCollectionSlider(
                            root: root,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
