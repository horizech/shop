import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/header/header.dart';
import 'package:shop/widgets/search/search_by_body.dart';
import 'package:shop/widgets/search/search_widget.dart';
import 'package:shop/widgets/slider/parent_category_slider.dart';
import 'package:shop/widgets/store/store_cubit.dart';
import 'package:shop/widgets/products/product_grid_item.dart';
import 'package:video_player/video_player.dart';

class SimpleHomePage extends StatefulWidget {
  const SimpleHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SimpleHomePage> createState() => _SimpleHomePageState();
}

class _SimpleHomePageState extends State<SimpleHomePage> {
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/car_vid.mp4')
  //     ..initialize().then((_) {
  //       _controller.play();
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       // setState(() {});
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<Collection> root = [];
    return Container(
      decoration: BoxDecoration(
        color: UpConfig.of(context).theme.secondaryColor,
        //     image: DecorationImage(
        //   image: AssetImage("assets/bg.jpg"),
        //   fit: BoxFit.fill,
        // )
      ),
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
            // SizedBox.expand(
            //   child: FittedBox(
            //     fit: BoxFit.cover,
            //     child: SizedBox(
            //       width: _controller.value.size.width,
            //       height: _controller.value.size.height,
            //       child: VideoPlayer(_controller),
            //     ),
            //   ),
            // ),
            CustomAppbar(
              scaffoldKey: scaffoldKey,
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(),
                    // const HeaderWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      UpConfig.of(context).theme.primaryColor,
                                  width: 4),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12, left: 8),
                                  child: UpText("Body Type"),
                                ),
                                SearchByBodyWidget(),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 250,
                        width: 400,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const SearchWidget(),
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
