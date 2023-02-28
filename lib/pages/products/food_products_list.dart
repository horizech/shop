import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/enums/text_style.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_expansion_tile.dart';
// import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/widgets/up_orientational_column_row.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class FoodProducts extends StatefulWidget {
  final Map<String, String>? queryParams;
  const FoodProducts({
    this.queryParams,
    Key? key,
  }) : super(key: key);

  @override
  State<FoodProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<FoodProducts> {
  int? selectedKeywordId = 0;
  Map<String, List<int>> selectedVariationsValues = {};
  List<Product>? filteredProducts;
  List<Product>? products;
  List<String> categories = [
    "Chinese",
    "Desserts",
    "Drinks" "asdas",
    "sdaasd",
    "sdasd",
    "sdaasdasd",
    "Appetizer",
  ];
  double height = 100;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final ScrollController controller = ScrollController();
    return Container(
      decoration: BoxDecoration(
        color: UpConfig.of(context).theme.secondaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        drawer: const MenuDrawer(),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // CustomAppbar(
              //   scaffoldKey: scaffoldKey,
              // ),

              BlocConsumer<StoreCubit, StoreState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    // collections = [];
                    // if (collection != null) {
                    //   int parent = collection;
                    //   collections =
                    //       _getCollectionsByParent(state, parent, []);
                    // }
                    return Column(
                      children: [
                        Container(
                          color: Colors.pink[100],
                          height: 300,
                          child: Center(
                            child: UpOrientationalColumnRow(
                              widths: const [300, 0],
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/logo.png'),
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    UpText(
                                      "name",
                                      type: UpTextType.heading4,
                                    ),
                                    UpText("address"),
                                    UpText("NUMBER"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              UpText("Home / "),
                              UpText("Menu"),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UpOrientationalColumnRow(
                            widths: const [300, 0],
                            children: [
                              FoodCategoriesListWidget(
                                onChange: (value) {
                                  int index = categories.indexWhere(
                                      (element) => element == value);
                                  controller.animateTo(
                                    index * MediaQuery.of(context).size.height,
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                },
                              ),
                              // SizedBox(
                              //     child: VerticalDivider(color: Colors.red)),

                              const SizedBox(
                                width: 20,
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                controller: controller,
                                // itemExtent: itemSize,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: UpExpansionTile(
                                            initiallyExpanded: true,
                                            title: categories[index],
                                            expandedAlignment:
                                                Alignment.topLeft,
                                            childrenPadding:
                                                const EdgeInsets.all(8.0),
                                            children: const [
                                              UpText("sad"),
                                              UpText("sad"),
                                              UpText("sad"),
                                              UpText("sad"),
                                              UpText("sad"),
                                              UpText("sad"),
                                            ]),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: Colors.black,
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // Column(
                              //   children: [
                              //     StreamBuilder(
                              //       stream:
                              //           ServiceManager<VariationService>()
                              //               .variationStream$,
                              //       builder: (BuildContext context,
                              //           storedVariationsValues) {
                              //         return FutureBuilder<List<Product>>(
                              //           future:
                              //               ProductService.getProducts(
                              //                   collections,
                              //                   storedVariationsValues
                              //                           .data ??
                              //                       {},
                              //                   selectedKeywordId,
                              //                   ""),
                              //           builder: (BuildContext context,
                              //               AsyncSnapshot<List<Product>>
                              //                   snapshot) {
                              //             products = snapshot.data;
                              //             // filteredProducts ??= products;

                              //             if (snapshot.connectionState !=
                              //                 ConnectionState.done) {
                              //               return Padding(
                              //                 padding:
                              //                     const EdgeInsets.all(
                              //                         30.0),
                              //                 child: GridView.builder(
                              //                   gridDelegate:
                              //                       const SliverGridDelegateWithFixedCrossAxisCount(
                              //                     crossAxisCount: 2,
                              //                   ),
                              //                   itemCount: 3,
                              //                   shrinkWrap: true,
                              //                   itemBuilder:
                              //                       (context, index) {
                              //                     return Padding(
                              //                       padding:
                              //                           const EdgeInsets
                              //                               .all(0),
                              //                       child: SizedBox(
                              //                         height: 300,
                              //                         width: 300,
                              //                         child: Container(
                              //                             color: Colors
                              //                                 .grey[200]),
                              //                       ),
                              //                     );
                              //                   },

                              //                   // itemCount: 6,
                              //                 ),
                              //               );
                              //             }
                              //             return snapshot.hasData
                              //                 ? ProductsGrid(
                              //                     // products: filteredProducts!,
                              //                     collection: collection,
                              //                     products:
                              //                         snapshot.data!,
                              //                   )
                              //                 : const CircularProgressIndicator();
                              //           },
                              //         );
                              //       },
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCategoriesListWidget extends StatefulWidget {
  final Function? onChange;
  const FoodCategoriesListWidget({
    Key? key,
    this.onChange,
  }) : super(key: key);

  @override
  State<FoodCategoriesListWidget> createState() =>
      _FoodCategoriesListWidgetState();
}

class _FoodCategoriesListWidgetState extends State<FoodCategoriesListWidget> {
  List<String> categories = ["Appetizer", "Chinese", "Desserts", "Drinks"];
  List<bool> categoriesHovered = [];
  String currentSelected = "";

  @override
  void initState() {
    super.initState();

    for (var element in categories) {
      categoriesHovered.add(false);
    }
  }

  void _incrementEnter(int key) {
    setState(() {
      categoriesHovered[key] = true;
    });
  }

  void _incrementExit(int key) {
    setState(() {
      categoriesHovered[key] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...categories
              .asMap()
              .entries
              .map((e) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (event) => _incrementEnter(e.key),
                    // onHover: _updateLocation,
                    onExit: (event) => _incrementExit(e.key),

                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 3,
                                color: currentSelected == e.value
                                    ? Colors.orange
                                    : Colors.transparent)),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onChange != null) {
                            widget.onChange!(e.value);
                          }
                          setState(() {
                            currentSelected = e.value;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                            bottom: 4.0,
                            right: 8.0,
                          ),
                          child: UpText(
                            e.value,
                            style: UpStyle(
                              textColor: categoriesHovered[e.key]
                                  ? Colors.orange
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
