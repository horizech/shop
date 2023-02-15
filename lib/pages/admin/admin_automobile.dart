import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/models/up_label_value.dart';
import 'package:flutter_up/models/up_row.dart';
import 'package:flutter_up/widgets/up_circualar_progress.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:flutter_up/widgets/up_table.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/products/products_service.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class AdminAutoMobilePage extends StatefulWidget {
  const AdminAutoMobilePage({Key? key}) : super(key: key);

  @override
  State<AdminAutoMobilePage> createState() => _AdminAutoMobilePageState();
}

class _AdminAutoMobilePageState extends State<AdminAutoMobilePage> {
  List<int>? selectedCollection;
  String currentCollection = "";
  List<UpLabelValuePair> collectionDropdown = [];
  List<Collection> collections = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, state) {},
          builder: (context, state) {
            collections = state.collections!.toList();
            if (collectionDropdown.isEmpty) {
              collectionDropdown.add(UpLabelValuePair(label: "All", value: ""));
              if (collections.isNotEmpty) {
                for (var c in collections) {
                  collectionDropdown
                      .add(UpLabelValuePair(label: c.name, value: "${c.id}"));
                }
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 200,
                      child: UpDropDown(
                        label: "Collection",
                        value: currentCollection,
                        itemList: collectionDropdown,
                        onChanged: (value) {
                          currentCollection = value.toString();

                          if (value != null) {
                            selectedCollection = [int.parse(value)];
                          } else {
                            selectedCollection = null;
                          }
                          setState(() {});
                        },
                      )),
                ),
                FutureBuilder<List<Product>>(
                  future: ProductService.getProducts(
                      selectedCollection, {}, null, ""),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    return snapshot.hasData && snapshot.data != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: UpTable(
                              columns: const [
                                "Id",
                                "Name",
                                "Price",
                                'IsVariedProduct'
                              ],
                              rows: [
                                ...snapshot.data!.map(
                                  (e) => UpRow(
                                    [
                                      SizedBox(child: UpText(e.id.toString())),
                                      SizedBox(
                                          child: UpText(e.name.toString())),
                                      SizedBox(
                                          child: UpText(e.price.toString())),
                                      SizedBox(
                                          child: UpText(
                                              e.isVariedProduct.toString())),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: UpCircularProgress(),
                          );
                  },
                ),
              ],
            );
          }),
    );
  }
}
