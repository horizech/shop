import 'package:apiraiser/apiraiser.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/models/product_options.dart';

class AddEditProductService {
  static Future<APIResult?> addProductOptionValues(
    Map<String, dynamic> data,
  ) async {
    APIResult result = await Apiraiser.data.insert("ProductOptionValues", data);

    if (result.success) {
      return result;
    } else {
      return null;
    }
  }

  static Future<APIResult?> addEditProduct(
    Map<String, dynamic> data,
    int? productId,
  ) async {
    APIResult result;
    if (productId != null) {
      result = await Apiraiser.data.update("Products", productId, data);
    } else {
      result = await Apiraiser.data.insert("Products", data);
    }

    if (result.success) {
      return result;
    } else {
      return null;
    }
  }

  static Future<ProductOption?> addProductOption(
    Map<String, dynamic> data,
  ) async {
    debugPrint(data.toString());
    APIResult result = await Apiraiser.data.insert("ProductOptions", data);

    if (result.success) {
      ProductOption? productOption = await getProductOption(data["Name"]);
      return productOption;
    } else {
      return null;
    }
  }

  static Future<ProductOption?> getProductOption(String name) async {
    List<QuerySearchItem> conditions = [
      QuerySearchItem(
          name: "Name", condition: ColumnCondition.equal, value: name)
    ];
    APIResult result =
        await Apiraiser.data.getByConditions("ProductOptions", conditions);

    if (result.success) {
      ProductOption productOption = (result.data as List<dynamic>)
          .map((p) => ProductOption.fromJson(p as Map<String, dynamic>))
          .first;
      return productOption;
    } else {
      return null;
    }
  }
}
