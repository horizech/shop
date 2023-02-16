import 'package:apiraiser/apiraiser.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/enums/text_style.dart';
import 'package:flutter_up/enums/up_button_type.dart';
import 'package:flutter_up/helpers/up_datetime_helper.dart';
import 'package:flutter_up/helpers/up_toast.dart';
import 'package:flutter_up/models/up_label_value.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_checkbox.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:flutter_up/widgets/up_textfield.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_detail.dart';
import 'package:shop/models/product_option_value.dart';
import 'package:shop/models/product_options.dart';
import 'package:shop/services/add_edit_product_service/add_edit_product_service.dart';
import 'package:shop/widgets/products/product_detail_service.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class AddEditAutoMobileProduct extends StatefulWidget {
  final Map<String, String>? queryParams;

  const AddEditAutoMobileProduct({Key? key, this.queryParams})
      : super(key: key);

  @override
  State<AddEditAutoMobileProduct> createState() =>
      _AddEditAutoMobileProductState();
}

class _AddEditAutoMobileProductState extends State<AddEditAutoMobileProduct> {
  ProductDetail? productDetail;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _discountPriceController =
      TextEditingController();
  final TextEditingController _discountStartController =
      TextEditingController();
  final TextEditingController _discountEndController = TextEditingController();
  int? gallery;
  int? thumbnail;
  List<int> keywords = [];

  List<ProductOption> productOptions = [];
  List<ProductOptionValue> productOptionsValue = [];
  List<Collection> collections = [];
  String currentCollection = "";
  List<UpLabelValuePair> collectionDropdown = [];
  int? productId;
  bool isVariedProduct = false;
  Map<String, int> options = {};

  Future<DateTime> _getPicker() async {
    DateTime? pickedDate = await UpDateTimeHelper.upDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    TimeOfDay? pickedTime = await UpDateTimeHelper.upTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedDate != null) {
      if (pickedTime != null) {
        pickedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return pickedDate ?? DateTime.now();
  }

  _discountStartDate() async {
    DateTime date = await _getPicker();
    setState(() {
      _discountStartController.text = date.toString();
    });
  }

  _discountEndDate() async {
    DateTime date = await _getPicker();

    setState(() {
      _discountEndController.text = date.toString();
    });
  }

// in case of edit
  getProductDetail() async {
    if (productId != null) {
      productDetail =
          await ProductDetailService.getProductDetail(productId ?? 0);
      if (productDetail != null && productDetail!.product != null) {
        setState(() {
          _nameController.text = productDetail!.product!.name;
          _descriptionController.text =
              productDetail!.product!.description ?? "";
          isVariedProduct = productDetail!.product!.isVariedProduct;
          _priceController.text = productDetail!.product!.price.toString();
          _skuController.text = productDetail!.product!.sku.toString();

          currentCollection = "${productDetail!.product!.collection}";
          _discountPriceController.text =
              productDetail!.product!.discounPrice != null
                  ? productDetail!.product!.discounPrice.toString()
                  : "";
          _discountStartController.text =
              productDetail!.product!.discountStartDate != null
                  ? productDetail!.product!.discountStartDate.toString()
                  : "";
          _discountEndController.text =
              productDetail!.product!.discountEndDate != null
                  ? productDetail!.product!.discountEndDate.toString()
                  : "";
          gallery = productDetail!.product!.gallery;
          thumbnail = productDetail!.product!.thumbnail;
          keywords = productDetail!.product!.keywords ?? [];
          options = productDetail!.product!.options ?? {};
        });
      }
    }
  }

  //  product option value add dialog
  _productOptionValueAddDialog(ProductOption productOption) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: UpText(
              "Add Product Option Value",
            ),
          ),
          actionsPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UpText(
                      productOption.name,
                      type: UpTextType.heading4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UpTextField(
                      controller: controller,
                      label: 'Product Option Value',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: SizedBox(
                width: 100,
                child: UpButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: SizedBox(
                width: 100,
                child: UpButton(
                  text: "Add",
                  onPressed: () async {
                    ProductOptionValue newProductOptionValue =
                        ProductOptionValue(
                      name: controller.text,
                      productOption: productOption.id!,
                      collection: int.parse(currentCollection),
                    );
                    APIResult? result =
                        await AddEditProductService.addProductOptionValues(
                      newProductOptionValue.toJson(newProductOptionValue),
                    );
                    if (result != null) {
                      if (result.success) {
                        showUpToast(
                          context: context,
                          text: "Product Option Value Added Successfully",
                        );
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      } else {
                        showUpToast(
                          context: context,
                          text: result.message ?? "",
                        );
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      }
                    } else {
                      showUpToast(
                        context: context,
                        text: "An Error Occurred",
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //  product option add dialog
  _productOptionAddDialog() {
    TextEditingController productOptioncontroller = TextEditingController();
    TextEditingController productOptionValuecontroller =
        TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: UpText(
              "Add Product Option",
            ),
          ),
          actionsPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UpTextField(
                      controller: productOptioncontroller,
                      label: 'Product Option',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UpTextField(
                      controller: productOptionValuecontroller,
                      label: 'Product Option Value',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: SizedBox(
                width: 100,
                child: UpButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: SizedBox(
                width: 100,
                child: UpButton(
                    text: "Add",
                    onPressed: () async {
                      if (!productOptions.any(
                        (element) =>
                            element.name.toLowerCase() ==
                            productOptioncontroller.text.toLowerCase(),
                      )) {
                        ProductOption newProductOption = ProductOption(
                          name: productOptioncontroller.text,
                        );
                        ProductOption? productOption =
                            await AddEditProductService.addProductOption(
                          newProductOption.toJson(newProductOption),
                        );
                        if (productOption != null) {
                          ProductOptionValue newProductOptionValue =
                              ProductOptionValue(
                            name: productOptionValuecontroller.text,
                            productOption: productOption.id!,
                            collection: int.parse(currentCollection),
                          );
                          APIResult? result = await AddEditProductService
                              .addProductOptionValues(
                            newProductOptionValue.toJson(newProductOptionValue),
                          );
                          if (result != null && result.success) {
                            showUpToast(
                              context: context,
                              text: "Product Option Added Successfully",
                            );
                            //  context.read<StoreCubit>().getStore();
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            Navigator.pop(context);
                            showUpToast(
                              context: context,
                              text: "An Error Occurred",
                            );
                          }
                        } else {
                          showUpToast(
                            context: context,
                            text: "An error occurred",
                          );
                        }
                      } else {
                        showUpToast(
                          context: context,
                          text: "Product Option Already Exits",
                        );
                        Navigator.pop(context);
                      }
                    }),
              ),
            ),
          ],
        );
      },
    );
  }

  addEditProduct() async {
    Product product = Product(
      name: _nameController.text,
      id: productId,
      collection: int.parse(currentCollection),
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
      sku: _skuController.text,
      isVariedProduct: isVariedProduct,
      gallery: gallery ?? 4,
      keywords: keywords,
      thumbnail: thumbnail ?? 4,
      options: options,
      discountStartDate: _discountStartController.text.isNotEmpty
          ? DateTime.parse(_discountStartController.text)
          : null,
      discountEndDate: _discountEndController.text.isNotEmpty
          ? DateTime.parse(_discountEndController.text)
          : null,
      discounPrice: _discountPriceController.text.isNotEmpty
          ? double.parse(_discountPriceController.text)
          : null,
    );

    APIResult? result = await AddEditProductService.addEditProduct(
        Product.toJson(product), productId);
    if (result != null) {
      showUpToast(
        context: context,
        text: result.message ?? "",
      );
    } else {
      showUpToast(
        context: context,
        text: "An error occurred",
      );
    }
  }

  onOptionChange(String key, String value) {
    options[key] = int.parse(value);
  }

  _uploadThumbnail(BuildContext context) async {
    FilePickerCross? result = await FilePickerCross.importFromStorage();
  }

  @override
  void initState() {
    super.initState();
    if (widget.queryParams != null &&
        widget.queryParams!.isNotEmpty &&
        widget.queryParams!['productId'] != null &&
        widget.queryParams!['productId']!.isNotEmpty) {
      productId = int.parse(widget.queryParams!['productId']!);

      if (productId != null) {
        getProductDetail();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocConsumer<StoreCubit, StoreState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.collections != null) {
                collections = state.collections!.toList();
              }
              if (state.productOptions != null &&
                  state.productOptions!.isNotEmpty) {
                productOptions = state.productOptions!.toList();
              }
              if (state.productOptionValues != null &&
                  state.productOptionValues!.isNotEmpty &&
                  currentCollection.isNotEmpty) {
                productOptionsValue = state.productOptionValues!
                    .where(
                      (c) => c.collection == int.parse(currentCollection),
                    )
                    .toList();
              }

              if (collectionDropdown.isEmpty) {
                if (collections.isNotEmpty) {
                  for (var c in collections) {
                    collectionDropdown
                        .add(UpLabelValuePair(label: c.name, value: "${c.id}"));
                  }
                }
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      // name
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                          controller: _nameController,
                          label: "Name",
                        ),
                      ),
                      // description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                          controller: _descriptionController,
                          label: "Description",
                          maxLines: 4,
                        ),
                      ),
                      // price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          label: "Price",
                        ),
                      ),
                      // sku
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                          controller: _skuController,
                          label: "Sku",
                        ),
                      ),
                      // discount price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                          controller: _discountPriceController,
                          label: "Discound Price",
                        ),
                      ),
                      // discount start date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                            controller: _discountStartController,
                            prefixIcon: const Icon(Icons.calendar_today),
                            label: "Discound Start Date",
                            onTap: () {
                              _discountStartDate();
                            }),
                      ),
                      // discount end date
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpTextField(
                            controller: _discountEndController,
                            prefixIcon: const Icon(Icons.calendar_today),
                            label: "Discound End Date",
                            onTap: () {
                              _discountEndDate();
                            }),
                      ),
                      // is varried checkbox
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpCheckbox(
                          initialValue: isVariedProduct,
                          label: "Is Varied",
                          onChange: (newCheck) => {
                            isVariedProduct = newCheck,
                            setState(() {}),
                          },
                        ),
                      ),
                      // options value
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: currentCollection.isNotEmpty &&
                              isVariedProduct == false,
                          child: Column(
                            children: [
                              //product option

                              Row(
                                children: [
                                  const UpText("Prodcut Option"),
                                  UpButton(
                                    onPressed: () {
                                      _productOptionAddDialog();
                                    },
                                    type: UpButtonType.icon,
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                              // product option values
                              Wrap(
                                  children: productOptions.map(
                                (element) {
                                  if (productOptionsValue.any(
                                      (v) => v.productOption == element.id)) {
                                    return Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        ProductOptionDropdownWidget(
                                          productOption: element,
                                          productOptionValues:
                                              productOptionsValue,
                                          change: (value) => onOptionChange(
                                            element.name,
                                            value,
                                          ),
                                          initialValue: options[element.name] !=
                                                  null
                                              ? options[element.name].toString()
                                              : null,
                                        ),
                                        UpButton(
                                          onPressed: () {
                                            _productOptionValueAddDialog(
                                                element);
                                          },
                                          type: UpButtonType.icon,
                                          child: const Icon(Icons.add),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ).toList()),
                            ],
                          ),
                        ),
                      ),
                      // thumbnail
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: UpButton(
                            onPressed: () => _uploadThumbnail(context),
                            text: 'Upload thumbnail',
                          ),
                        ),
                      ),
                      // add edit button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UpButton(
                            text: productId != null
                                ? "Edit Product"
                                : "Add Product",
                            onPressed: () {
                              addEditProduct();
                            }),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ProductOptionDropdownWidget extends StatefulWidget {
  final List<ProductOptionValue>? productOptionValues;
  final ProductOption productOption;
  final Function? change;
  final String? initialValue;

  const ProductOptionDropdownWidget({
    Key? key,
    this.productOptionValues,
    required this.productOption,
    this.initialValue,
    this.change,
  }) : super(key: key);

  @override
  State<ProductOptionDropdownWidget> createState() =>
      _ProductOptionDropdownWidgetState();
}

class _ProductOptionDropdownWidgetState
    extends State<ProductOptionDropdownWidget> {
  Map<String, List<int>?>? selectedVariations = {};
  List<int> selectedValues = [];
  List<bool> checkboxesValues = [];
  int totalLength = 0;
  String currentOption = "";
  List<UpLabelValuePair> productOptionDropdown = [];

  @override
  void initState() {
    super.initState();
    widget.productOptionValues!
        .where((e) => e.productOption == widget.productOption.id)
        .forEach((element) {
      productOptionDropdown
          .add(UpLabelValuePair(label: element.name, value: "${element.id}"));
    });

    // in case of edit options not null
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      currentOption = widget.initialValue ?? productOptionDropdown.first.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: productOptionDropdown.isNotEmpty,
        child: SizedBox(
          width: 200,
          child: UpDropDown(
            onChanged: ((value) => {
                  widget.change!(value),
                  // setState(() {}),
                }),
            value: currentOption,
            label: widget.productOption.name,
            itemList: productOptionDropdown,
          ),
        ),
      ),
    );
  }
}
