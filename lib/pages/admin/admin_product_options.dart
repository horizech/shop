import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/enums/up_button_type.dart';
import 'package:flutter_up/models/up_label_value.dart';
import 'package:flutter_up/models/up_row.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:flutter_up/widgets/up_table.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/dialogs/add_product_option_dialog.dart';
import 'package:shop/dialogs/add_edit_product_option_value_dialog.dart';
import 'package:shop/dialogs/delete_product_option_dialog.dart';
import 'package:shop/dialogs/delete_product_option_value_dialog.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/product_option_value.dart';
import 'package:shop/models/product_options.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class AdminProductOptionsPage extends StatefulWidget {
  const AdminProductOptionsPage({Key? key}) : super(key: key);

  @override
  State<AdminProductOptionsPage> createState() =>
      _AdminProductOptionsPageState();
}

class _AdminProductOptionsPageState extends State<AdminProductOptionsPage> {
  String currentCollection = "", currentProductOption = "";
  List<ProductOption> productOptions = [];
  List<ProductOptionValue> productOptionValues = [];

  List<UpLabelValuePair> collectionDropdown = [];
  List<UpLabelValuePair> productOptionDropdown = [];

  List<Collection> collections = [];
  //  product option add dialog
  _productOptionAddDialog(String currentProductOption) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddProductOptionDialog(
          productOptions: productOptions,
          currentCollection: currentCollection.isNotEmpty
              ? int.parse(currentCollection)
              : null,
        );
      },
    );
  }

  _productOptionValueAddDialog(ProductOption productOption) {
    if (currentCollection.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddEditProductOptionValueDialog(
            productOption: productOption,
            currentCollection: int.parse(currentCollection),
          );
        },
      );
    }
  }

  _deleteProductOptionValueDialog(int productOptionValueId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteProductOptionValueDialog(
          productOptionValueId: productOptionValueId,
        );
      },
    );
  }

  _deleteProductOptionDialog(int productOptionId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteProductOptionDialog(
          productOptionId: productOptionId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.productOptions != null &&
              state.productOptions!.isNotEmpty) {
            productOptions = state.productOptions!.toList();
          }
          if (state.collections != null) {
            collections = state.collections!.toList();
          }
          if (collectionDropdown.isEmpty) {
            collectionDropdown.add(
              UpLabelValuePair(label: "All", value: "-1"),
            );
            if (collections.isNotEmpty) {
              for (var c in collections) {
                collectionDropdown
                    .add(UpLabelValuePair(label: c.name, value: "${c.id}"));
              }
            }
          }
          if (productOptionDropdown.isEmpty) {
            productOptionDropdown.add(
              UpLabelValuePair(label: "All", value: "-1"),
            );
            if (productOptions.isNotEmpty) {
              for (var p in productOptions) {
                productOptionDropdown
                    .add(UpLabelValuePair(label: p.name, value: "${p.id}"));
              }
            }
          }

          if (currentProductOption.isNotEmpty &&
              currentCollection.isNotEmpty &&
              state.productOptionValues != null &&
              state.productOptionValues!.isNotEmpty) {
            if (state.collections != null) {
              productOptionValues = state.productOptionValues!
                  .where((element) =>
                      element.productOption ==
                          int.parse(currentProductOption) &&
                      element.collection == int.parse(currentCollection))
                  .toList();
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: UpDropDown(
                            label: "Product Option",
                            value: currentProductOption,
                            itemList: productOptionDropdown,
                            onChanged: (value) {
                              currentProductOption = value.toString();

                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      UpButton(
                        onPressed: () {
                          _productOptionAddDialog(currentProductOption);
                        },
                        type: UpButtonType.icon,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                currentProductOption.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: UpTable(
                          columns: const [
                            "Id",
                            "Name",
                            "Actions",
                          ],
                          rows: [
                            ...productOptions
                                .where((element) =>
                                    element.id ==
                                    int.parse(currentProductOption))
                                .map(
                                  (e) => UpRow(
                                    [
                                      SizedBox(
                                        child: UpText(
                                          e.id.toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        child: UpText(
                                          e.name.toString(),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Icon(Icons.edit)),
                                          SizedBox(
                                            child: GestureDetector(
                                              onTap: _deleteProductOptionDialog(
                                                  e.id!),
                                              child: const Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const UpTable(
                          columns: [
                            "Id",
                            "Name",
                            "Actions",
                          ],
                          rows: [],
                        ),
                      ),
                Visibility(
                  visible: currentProductOption.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: UpDropDown(
                        label: "Collection",
                        value: currentCollection,
                        itemList: collectionDropdown,
                        onChanged: (value) {
                          currentCollection = value.toString();

                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: currentCollection.isNotEmpty &&
                      currentProductOption.isNotEmpty,
                  child: Row(
                    children: [
                      const UpText("Product Option Value"),
                      UpButton(
                        onPressed: () {
                          _productOptionValueAddDialog(productOptions
                              .where((element) =>
                                  element.id == int.parse(currentProductOption))
                              .first);
                        },
                        type: UpButtonType.icon,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: productOptionValues.isNotEmpty,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: UpTable(
                      columns: const [
                        "Id",
                        "Name",
                        "Actions",
                      ],
                      rows: [
                        ...productOptionValues.map(
                          (p) => UpRow(
                            [
                              SizedBox(
                                child: UpText(
                                  p.id.toString(),
                                ),
                              ),
                              SizedBox(
                                child: UpText(
                                  p.name.toString(),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(child: Icon(Icons.edit)),
                                  SizedBox(
                                    child: GestureDetector(
                                      onTap: _deleteProductOptionValueDialog(
                                          p.id!),
                                      child: const Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
