import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/drawer.dart';
import 'package:shop/widgets/error/error.dart';
import 'package:shop/widgets/filters/filter.dart';
import 'package:shop/widgets/header/header.dart';
import 'package:shop/widgets/keywords/keywords.dart';
import 'package:shop/widgets/orientation_switcher.dart';
import 'package:shop/widgets/products/products_list.dart';
import 'package:shop/widgets/products/products_service.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class Products extends StatefulWidget {
  final Map<String, String>? queryParams;
  const Products({
    this.queryParams,
    Key? key,
  }) : super(key: key);

  @override
  State<Products> createState() => _AllProductsState();
}

class _AllProductsState extends State<Products> {
  int? selectedKeywordId = 0;
  Map<int, List<int>> selectedVariationsValues = {};
  List<Product>? filteredProducts;
  List<Product>? products;

  change(int? id, Map<int, List<int>>? s) {
    setState(() {
      selectedKeywordId = id;
      selectedVariationsValues = s ?? {};
      // filteredProducts!= filteredProducts(
      //     products, selectedVariationsValues, selectedKeywordId);
    });
  }

  List<int> _getCollectionsByParent(
    StoreState state,
    int parent,
    List<int> collections,
  ) {
    collections.add(parent);
    if (state.collections != null &&
        state.collections!.any(
          (element) => element.parent == parent,
        )) {
      state.collections!
          .where((element) => element.parent == parent)
          .forEach((child) {
        collections = _getCollectionsByParent(state, child.id, collections);
      });
    }

    return collections;
  }

  @override
  Widget build(BuildContext context) {
    List<int> collections = [];
    bool isCollectionFilter = false;
    int? collection;
    widget.queryParams;
    if (widget.queryParams!['collection'] != null &&
        widget.queryParams!['collection']!.isNotEmpty) {
      collection = int.parse(widget.queryParams!['collection'] ?? "");
      isCollectionFilter = true;
    } else {
      if (widget.queryParams != null && widget.queryParams!.isNotEmpty) {
        isCollectionFilter = false;
      } else {
        isCollectionFilter = true;
      }
    }
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: CustomAppbar(
        scaffoldKey: scaffoldKey,
        collection: collection,
      ),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      body: isCollectionFilter
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: BlocConsumer<StoreCubit, StoreState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    collections = [];
                    if (collection != null) {
                      int parent = collection;
                      collections = _getCollectionsByParent(state, parent, []);
                    }
                    return Column(
                      children: [
                        const HeaderWidget(),
                        OrientationSwitcher(
                          widths: const [200, -1],
                          children: [
                            Center(
                              child: Container(
                                // height: MediaQuery.of(context).size.height,
                                color: Colors.grey[100],
                                child: FilterPage(
                                  collection: collection,
                                  change: (v) => change(0, v),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Keywords(
                                    categoryId: collection,
                                    onChange: (k) => change(k, {}),
                                    selectedKeywordId: selectedKeywordId,
                                  ),
                                ),
                                FutureBuilder<List<Product>>(
                                  future: ProductService.getProducts(
                                      collections,
                                      selectedVariationsValues,
                                      selectedKeywordId,
                                      ""),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Product>> snapshot) {
                                    products = snapshot.data;
                                    // filteredProducts ??= products;

                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 150,
                                                width: 1000,
                                                child: Container(
                                                    color: Colors.grey[200]),
                                              ),
                                            );
                                          },
                                          itemCount: 6,
                                        ),
                                      );
                                    }
                                    return snapshot.hasData
                                        ? ProductsList(
                                            // products: filteredProducts!,
                                            collection: collection,
                                            products: snapshot.data!,
                                          )
                                        : const CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            )
          : const NotFoundErrorWidget(),
    );
  }
}




// List<Product>? filterProducts(List<Product>? products,
//     Map<int, List<String>>? selectedVariationsValues, int? selectedKeywordId) {
//     BlocConsumer<ApiraiserAuthenticationCubit,
//                 ApiraiserAuthenticationState>(
//               listener: (context, state) {
//                 if (state.isSuccessful) {
//                 } else if (state.isError) {}
//               },
//               builder: (context, state) => FutureBuilder<List<Product>>(
//                 future: ProductService.getProducts(, -1),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<List<Product>> snapshot) {
//                     },),);
//     return null;}

// List<Product>? filterProducts(List<Product>? products,
//     Map<int, List<String>>? selectedVariationsValues, int? selectedKeywordId) {
//   try {
//     List<Product>? filteredProducts = [...products!];
//     if ((selectedKeywordId ?? -1) > 0) {
//       filteredProducts = filteredProducts
//           .where((product) => product.keywords.contains(selectedKeywordId))
//           .toList();
//       return filteredProducts;
//     }

//     if (selectedVariationsValues != null &&
//         selectedVariationsValues.isNotEmpty) {
//       filteredProducts = filteredProducts.where((product) {
//         Map<int, bool> matches = {};
//         for (var v in product.variations.keys) {
//           matches[v] = false;
//         }

//         for (var entry in product.variations.entries) {
//           if (selectedVariationsValues.containsKey(entry.key) &&
//               selectedVariationsValues[entry.key]!.isNotEmpty) {
//             for (var selectedVariation
//                 in selectedVariationsValues[entry.key]!) {
//               if (entry.value.contains(selectedVariation)) {
//                 matches[entry.key] = true;
//               }
//             }
//           } else {
//             matches[entry.key] = true;
//           }
//         }
//         return !matches.values.any((element) => element == false);
//       }).toList();

//       return filteredProducts;
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//     rethrow;
//   }
//   return null;
// }

 
// return BlocConsumer<ApiraiserAuthenticationCubit, ApiraiserAuthenticationState>(
  //   listener: (context, state) {
  //     if (state.isSuccessful) {
  //     } else if (state.isError) {}
  //   },
  //   builder: (context, state) => FutureBuilder<List<Product>>(
  //     future: ProductService.getProducts(widget.collection, widget.limit),
  //     builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
  //       debugPrint(snapshot.hasData.toString());
  //       try {
  //         List<Product>? products = snapshot.data;
  //         if ((products ?? []).isEmpty) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if ((widget.selectedKeywordId ?? -1) > 0) {
  //           products = products!
  //               .where((product) =>
  //                   product.keywords.contains(widget.selectedKeywordId))
  //               .toList();
  //         }

  //         if (widget.selectedVariationsValues != null &&
  //             widget.selectedVariationsValues!.isNotEmpty) {
  //           debugPrint("sadsda");

  //           products = products!.where((product) {
  //             Map<int, bool> matches = {};
  //             for (var v in product.variations.keys) {
  //               matches[v] = false;
  //             }

  //             for (var entry in product.variations.entries) {
  //               if (widget.selectedVariationsValues!.containsKey(entry.key) &&
  //                   widget.selectedVariationsValues![entry.key]!.isNotEmpty) {
  //                 for (var selectedVariation
  //                     in widget.selectedVariationsValues![entry.key]!) {
  //                   if (entry.value.contains(selectedVariation)) {
  //                     matches[entry.key] = true;
  //                   }
  //                 }
  //               } else {
  //                 matches[entry.key] = true;
  //               }
  //             }
  //             return !matches.values.any((element) => element == false);
  //           }).toList();

  //           debugPrint(products.length.toString());
  //         }

  //         return (widget.limit == -1
  //             ? SingleChildScrollView(
  //                 scrollDirection: Axis.vertical,
  //                 child: OrientationSwitcher(
  //                   widths: const [200, -1],
  //                   children: [
  //                     Align(
  //                       alignment: Alignment.topLeft,
  //                       child: Container(
  //                         color: Colors.amber,
  //                         child: FilterPage(
  //                           collection: widget.collection,
  //                         ),
  //                       ),
  //                     ),
  //                     Column(
  //                       children: [
  //                         Keywords(products: snapshot.data!),
  //                         _allProductGrids(context, products!),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             : _limitedProductsGrids(context, snapshot.data!));
  //       } catch (e) {
  //         debugPrint(e.toString());
  //         rethrow;
  //       }
  //     },
  //   ),
  // );