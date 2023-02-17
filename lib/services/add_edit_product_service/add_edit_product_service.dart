import 'package:apiraiser/apiraiser.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_options.dart';
import 'package:shop/models/product_variation.dart';

class AddEditProductService {
  static Future<APIResult?> addEditProductOptionValues({
    int? productOptionValueId,
    required Map<String, dynamic> data,
  }) async {
    APIResult? result;
    if (productOptionValueId != null) {
      result = await Apiraiser.data
          .update("ProductOptionValues", productOptionValueId, data);
    } else {
      result = await Apiraiser.data.insert("ProductOptionValues", data);
    }

    if (result.success) {
      return result;
    } else {
      return null;
    }
  }

  static Future<APIResult?> deleteProductOption(int productOptionId) async {
    APIResult result =
        await Apiraiser.data.delete("ProductOptions", productOptionId);

    if (result.success) {
      return result;
    } else {
      return null;
    }
  }

  static Future<APIResult?> deleteProductOptionValue(
      int productOptionValueId) async {
    APIResult result = await Apiraiser.data
        .delete("ProductOptionValues", productOptionValueId);

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

  static Future<APIResult?> addEditProductVariation(
    Map<String, dynamic> data,
    int? productVariationId,
  ) async {
    APIResult result;
    if (productVariationId != null) {
      result = await Apiraiser.data
          .update("ProductVariations", productVariationId, data);
    } else {
      result = await Apiraiser.data.insert("ProductVariations", data);
    }

    if (result.success) {
      return result;
    } else {
      return null;
    }
  }

  static Future<ProductOption?> addEditProductOption(
      {required Map<String, dynamic> data, int? productOptionId}) async {
    APIResult? result;
    if (productOptionId != null) {
      result =
          await Apiraiser.data.update("ProductOptions", productOptionId, data);
    } else {
      result = await Apiraiser.data.insert("ProductOptions", data);
    }

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

  static Future<ProductVariation?> getProductVariationById(
      int productVariationId) async {
    List<QuerySearchItem> conditions = [
      QuerySearchItem(
          name: "Id",
          condition: ColumnCondition.equal,
          value: productVariationId)
    ];
    APIResult result =
        await Apiraiser.data.getByConditions("ProductVariations", conditions);

    if (result.success) {
      ProductVariation productVariation = (result.data as List<dynamic>)
          .map((p) => ProductVariation.fromJson(p as Map<String, dynamic>))
          .first;
      return productVariation;
    } else {
      return null;
    }
  }

  static Future<Product?> getProductById(int productId) async {
    List<QuerySearchItem> conditions = [
      QuerySearchItem(
          name: "Id", condition: ColumnCondition.equal, value: productId)
    ];
    APIResult result =
        await Apiraiser.data.getByConditions("Products", conditions);

    if (result.success) {
      Product product = (result.data as List<dynamic>)
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .first;
      return product;
    } else {
      return null;
    }
  }
}
