import 'dart:typed_data';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_circualar_progress.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_icon.dart';
import 'package:flutter_up/widgets/up_orientational_column_row.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/keyword.dart';
import 'package:shop/models/media.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_option_value.dart';
import 'package:shop/models/product_options.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/error/error.dart';
import 'package:shop/widgets/media/media_service.dart';
import 'package:shop/services/product_detail_service.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class ProductAutomobilePage extends StatelessWidget {
  final Map<String, String>? queryParams;
  const ProductAutomobilePage({Key? key, this.queryParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? productId;
    if (queryParams != null &&
        queryParams!.isNotEmpty &&
        queryParams!['productId'] != null &&
        queryParams!['productId']!.isNotEmpty) {
      productId = int.parse(queryParams!['productId']!);
    }
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const MenuDrawer(),
      appBar: CustomAppbar(
        scaffoldKey: scaffoldKey,
      ),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      body: productId != null
          ? FutureBuilder<Product?>(
              future: ProductDetailService.getProductById(productId),
              builder:
                  (BuildContext context, AsyncSnapshot<Product?> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const UpCircularProgress(
                    width: 30,
                    height: 30,
                  );
                }
                if (snapshot.connectionState != ConnectionState.done) {
                  return const UpCircularProgress(
                    width: 30,
                    height: 30,
                  );
                }

                return snapshot.hasData && snapshot.data != null
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProductDetailedInfo(
                              product: snapshot.data!,
                            ),
                          ],
                        ),
                      )
                    : const NotFoundErrorWidget();
              },
            )
          : const NotFoundErrorWidget(),
    );
  }
}

class ProductDetailedInfo extends StatefulWidget {
  final Product product;
  final int? collection;

  const ProductDetailedInfo({
    Key? key,
    required this.product,
    this.collection,
  }) : super(key: key);

  @override
  State<ProductDetailedInfo> createState() => _ProductDetailedInfoState();
}

class _ProductDetailedInfoState extends State<ProductDetailedInfo> {
  List<Keyword> keywords = [];
  List<int> mediaList = [];
  List<ProductOption> productOptions = [];
  List<ProductOptionValue> productOptionValues = [];

  @override
  Widget build(BuildContext context) {
    try {
      return BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.mediaGroups != null && state.mediaGroups!.isNotEmpty) {
            mediaList = state.mediaGroups!
                .where((element) => element.id == widget.product.gallery)
                .first
                .mediaList;
          }
          if (state.keywords != null && state.keywords!.isNotEmpty) {
            for (var keyword in widget.product.keywords!) {
              keywords.add(
                state.keywords!.where((element) => element.id == keyword).first,
              );
            }
          }
          if (state.productOptions != null &&
              state.productOptions!.isNotEmpty) {
            productOptions = state.productOptions!.toList();
          }
          if (state.productOptionValues != null &&
              state.productOptionValues!.isNotEmpty) {
            productOptionValues = state.productOptionValues!.toList();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpOrientationalColumnRow(
                    children: [
                      Visibility(
                        visible: mediaList.isNotEmpty,
                        child: GetMedia(
                          mediaList: mediaList,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UpText(
                            widget.product.name,
                            style: UpStyle(
                                textSize: 25, textWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          UpText(
                            "£${widget.product.price.toString()}",
                            style: UpStyle(
                                textSize: 20,
                                textWeight: FontWeight.w900,
                                textColor: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DottedLine(),
                          ),
                          Visibility(
                            visible: keywords.isNotEmpty,
                            child: Wrap(
                                children: keywords
                                    .map((e) => Wrap(
                                          children: [
                                            UpIcon(
                                              icon: Icons.check,
                                              style: UpStyle(iconSize: 16),
                                            ),
                                            UpText(
                                              e.name,
                                              style: UpStyle(textSize: 16),
                                            )
                                          ],
                                        ))
                                    .toList()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Visibility(
                                visible: widget.product.description != null &&
                                    widget.product.description!.isNotEmpty,
                                child: UpText(
                                  widget.product.description ?? "",
                                  style: UpStyle(textSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: UpButton(
                              onPressed: () {},
                              style: UpStyle(
                                isRounded: true,
                                borderRadius: 4,
                              ),
                              text: "Contact Us",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _ProductDetail(
                              product: widget.product,
                              productOptions: productOptions,
                              productOptionValues: productOptionValues,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

class _ProductDetail extends StatefulWidget {
  final Product product;
  final List<ProductOption>? productOptions;
  final List<ProductOptionValue>? productOptionValues;
  const _ProductDetail(
      {Key? key,
      required this.product,
      this.productOptionValues,
      this.productOptions})
      : super(key: key);

  @override
  State<_ProductDetail> createState() => __ProductDetail();
}

class __ProductDetail extends State<_ProductDetail> {
  int view = 1;

  Widget getDetailRow(String key) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: widget.product.options != null &&
            key.isNotEmpty &&
            widget.product.options![key] != null &&
            widget.productOptions != null &&
            widget.productOptions!.isNotEmpty &&
            widget.productOptionValues != null &&
            widget.productOptionValues!.isNotEmpty,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: UpText(
                widget.productOptions!
                    .where((element) => element.name == key)
                    .first
                    .name
                    .toString(),
                style: UpStyle(
                  textWeight: FontWeight.bold,
                  textSize: 14,
                ),
              ),
            ),
            SizedBox(
              child: UpText(
                  widget.productOptionValues!
                      .where((element) =>
                          element.id == widget.product.options![key])
                      .first
                      .name
                      .toString(),
                  style: UpStyle(
                    textSize: 14,
                    // textColor: UpConfig.of(context).theme.primaryColor[400]),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget financeView() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        child: UpText(
          "Finance",
        ),
      ),
    );
  }

  Widget performanceView() {
    return widget.product.meta!["Performance"] != null
        ? SizedBox(
            child: Visibility(
              visible:
                  (widget.product.meta!["Performance"] as Map<String, dynamic>)
                      .isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ((widget.product.meta!["Performance"]
                        as Map<String, dynamic>)
                    .keys
                    .map((key) => SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                            visible: automobilePerformance.containsKey(key),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: UpText(
                                    automobilePerformance[key].toString(),
                                    style: UpStyle(
                                      textWeight: FontWeight.bold,
                                      textSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: UpText(
                                    (widget.product.meta!["Performance"]
                                            as Map<String, dynamic>)[key]
                                        .toString(),
                                    style: UpStyle(
                                      textSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )))
                    .toList()),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget featuresView() {
    return widget.product.meta!["Features"] != null
        ? SizedBox(
            child: Visibility(
              visible:
                  (widget.product.meta!["Features"] as Map<String, dynamic>)
                      .isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    ((widget.product.meta!["Features"] as Map<String, dynamic>)
                        .keys
                        .map((key) => SizedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: automobileFeatures.containsKey(key),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: UpText(
                                        automobileFeatures[key].toString(),
                                        style: UpStyle(
                                          textWeight: FontWeight.bold,
                                          textSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        child: UpIcon(
                                      icon: (widget.product.meta!["Features"]
                                              as Map<String, dynamic>)[key]
                                          ? Icons.check
                                          : Icons.cancel,
                                      style: UpStyle(
                                        iconSize: 20,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )))
                        .toList()),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget detailView() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.product.options!.keys
            .map((key) => SizedBox(
                  child: getDetailRow(key),
                ))
            .toList(),
      ),
    );
  }

  Widget getView() {
    if (view == 2) {
      return financeView();
    } else if (view == 3) {
      return performanceView();
    } else if (view == 4) {
      return featuresView();
    } else {
      return detailView();
    }
  }

  onViewChange(int id) {
    setState(() {
      view = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  onViewChange(1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UpText(
                    "Detail",
                    style: UpStyle(
                      textWeight:
                          view == 1 ? FontWeight.bold : FontWeight.normal,
                      textSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  onViewChange(4);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UpText(
                    "Features",
                    style: UpStyle(
                      textWeight:
                          view == 4 ? FontWeight.bold : FontWeight.normal,
                      textSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  onViewChange(3);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UpText(
                    "Performance",
                    style: UpStyle(
                      textWeight:
                          view == 3 ? FontWeight.bold : FontWeight.normal,
                      textSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  onViewChange(2);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UpText(
                    "Finance",
                    style: UpStyle(
                      textWeight:
                          view == 2 ? FontWeight.bold : FontWeight.normal,
                      textSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          child: getView(),
        )
      ],
    );
  }
}

Widget ourServices(BuildContext context) {
  return Wrap(spacing: 10.0, children: [
    Container(
      color: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fire_truck, size: 40),
              UpText("Shipping Charges",
                  style: UpStyle(textSize: 25, textWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 0, bottom: 10),
            child: UpText(
              "Flat Rs. 200 on all orders ",
              style: UpStyle(textSize: 20),
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.hourglass_bottom, size: 40),
              UpText(
                "Support 24/7",
                // style: Theme.of(context).textTheme.headline1)
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 0, bottom: 10),
            child: UpText(
              "Contact us 24/7 hours",
              // style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.pin_drop, size: 40),
              UpText(
                "Track Your Order",
              ), // style: Theme.of(context).textTheme.headline1),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 0, bottom: 10),
            child: UpText(
              "track your order for quick updates",
              // style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
      ),
    )
  ]);
}

class GetMedia extends StatelessWidget {
  final List<int> mediaList;
  const GetMedia({Key? key, required this.mediaList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Media>>(
      future: MediaService.getMediaByList(mediaList),
      builder: (BuildContext context, AsyncSnapshot<List<Media>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            height: 500,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    )
                  ]),
            ),
          );
        }
        return snapshot.hasData
            ? ProductImages(
                mediaList: snapshot.data!,
              )
            : const CircularProgressIndicator();
      },
    );
  }
}

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.mediaList,
  }) : super(key: key);

  final List<Media> mediaList;

  @override
  ProductImagesState createState() => ProductImagesState();
}

class ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          SizedBox(
            width: 400,
            child: AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: widget.mediaList[selectedImage].id.toString(),
                child: widget.mediaList[selectedImage].img != null &&
                        widget.mediaList[selectedImage].img!.isNotEmpty
                    ? Image.memory(
                        Uint8List.fromList(
                            widget.mediaList[selectedImage].img!),
                        gaplessPlayback: true,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: "assets/loading.gif",
                        image: widget.mediaList[selectedImage].url!,
                      ),
              ),
            ),
          ),
          // SizedBox(height: getProportionateScreenWidth(20)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(widget.mediaList.length,
                    (index) => buildSmallProductPreview(index)),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    const kPrimaryColor = Color(0xFFFF8F00);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        // duration: const Duration(seconds: 2),
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: widget.mediaList[selectedImage].img != null &&
                widget.mediaList[selectedImage].img!.isNotEmpty
            ? Image.memory(
                Uint8List.fromList(widget.mediaList[index].img!),
                gaplessPlayback: true,
              )
            : FadeInImage.assetNetwork(
                placeholder: "assets/loading.gif",
                image: widget.mediaList[index].url!,
              ),
      ),
    );
  }
}
