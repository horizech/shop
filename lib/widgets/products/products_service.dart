import 'package:apiraiser/apiraiser.dart';

import 'package:flutter/foundation.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/variations/variation_types.dart';

class ProductService {
  static Future<List<Product>> getProducts(
    List<int>? collections,
    Map<int, List<int>>? selectedVariationsValues,
    int? selectedKeywordId,
    String? name,
  ) async {
    Apiraiser.validateAuthentication();
    List<Product> products = [];

    try {
      Map<String, dynamic> jsonQuery = {
        "collections": "null",
        "name": "null",
        "filters": "null",
        "keywords": "null",
      };
      if (collections != null &&
          collections.isNotEmpty &&
          collections[0] != 0) {
        jsonQuery["collections"] = "ARRAY$collections";
      }

      debugPrint(jsonQuery["collections"]);
      if (name != null && name.isNotEmpty) {
        jsonQuery["name"] = "'$name'";
      }

//"ARRAY[${1,2,3}]";
      List<String> filters = [];

      if (selectedVariationsValues!.isNotEmpty) {
        if (selectedVariationsValues[VariationTypes.size.index] != null &&
            selectedVariationsValues[VariationTypes.size.index]!.isNotEmpty) {
          String sizes = "";
          sizes =
              selectedVariationsValues[VariationTypes.size.index]!.join(",");

          // jsonQuery["sizes"] = "ARRAY[$sizes]";
          filters.add('"Size": "{$sizes}"');
        }
        if (selectedVariationsValues[VariationTypes.color.index] != null &&
            selectedVariationsValues[VariationTypes.color.index]!.isNotEmpty) {
          String colors = "";
          colors =
              selectedVariationsValues[VariationTypes.color.index]!.join(",");

          // jsonQuery["colors"] = "ARRAY[$colors]";
          filters.add('"Color": "{$colors}"');
        }
      }
      if (filters.isNotEmpty) {
        // SELECT * FROM find_products(null, 'pla', '{"Color": "{8, 9, 10}"}'::JSONB, ARRAY[1]);
        jsonQuery["filters"] = "'{${filters.join(',')}}'::jsonb";
      }

      if (selectedKeywordId != null && selectedKeywordId > 0) {
        jsonQuery["keywords"] = "ARRAY[$selectedKeywordId]";
      }

      APIResult functionResult =
          await Apiraiser.function.excuteFunction(1, jsonQuery);
      if (functionResult.success &&
          (functionResult.data as List<dynamic>).isNotEmpty) {
        products = (functionResult.data as List<dynamic>)
            .map((p) => Product.fromJson(p as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    // if ((category ?? 0) > 0) {
    // conditions = [
    //   <String, dynamic>{
    //     'Name': "Category",
    //     'Condition': 0,
    //     'Value': category,
    //   }
    // ];

    // APIResult categoryProducts = await Apiraiser.table
    //     .getByConditions("CategoryProducts", conditions);

    //     if (categoryProducts.success) {
    //       productIds = (categoryProducts.data as List<dynamic>)
    //           .map((e) => ((e as Map<String, dynamic>)["Product"] as int))
    //           .toList();
    //     } else {
    //       return [];
    //     }
    //   } else {
    //     APIResult products = await Apiraiser.data.get("Products", limit);
    //     if (products.success) {
    //       productIds = (products.data as List<dynamic>)
    //           .map((e) => ((e as Map<String, dynamic>)["Id"] as int))
    //           .toList();
    //     } else {
    //       return [];
    //     }
    //   }

    //   conditions = [
    //     <String, dynamic>{
    //       'Name': "Product",
    //       'Condition': 3,
    //       'Value': productIds,
    //     }
    //   ];
    //   if (selectedKeywordId! > 0) {
    //     APIResult productKeywordresult =
    //         await Apiraiser.data.getByConditions("ProductKeyword", conditions);

    //     if (productKeywordresult.success) {
    //       List<ProductKeyword> productKeyword =
    //           (productKeywordresult.data as List<dynamic>)
    //               .map((k) => ProductKeyword.fromJson(k as Map<String, dynamic>))
    //               .toList();

    //       productIds = productKeyword
    //           .where((element) => element.keyword == selectedKeywordId)
    //           .map((e) => e.product)
    //           .toList();

    //       conditions = [
    //         {'Name': "Product", 'Condition': 3, 'Value': productIds}
    //       ];
    //     }
    //   }

    //   if (selectedVariationsValues != null &&
    //       selectedVariationsValues.values.isNotEmpty) {
    //     for (var element in VariationTypes.values) {
    //       if (selectedVariationsValues.containsKey(element.index) &&
    //           (selectedVariationsValues[element.index] ?? []).isNotEmpty) {
    //         conditions.add(<String, dynamic>{
    //           'Name': getVariationTypePascal(element),
    //           'Condition': 3,
    //           'Value': selectedVariationsValues[element.index],
    //         });
    //       }
    //     }
    //   }

    //   APIResult productVariationsResult =
    //       await Apiraiser.data.getByConditions("ProductVariations", conditions);
    //   if (productVariationsResult.success) {
    //     List<ProductVariation> productVariations =
    //         (productVariationsResult.data as List<dynamic>)
    //             .map((element) =>
    //                 ProductVariation.fromJson(element as Map<String, dynamic>))
    //             .toList();

    //     productIds = productVariations.map((e) => e.product).toSet().toList();

    //     conditions = [
    //       {'Name': "Id", 'Condition': 3, 'Value': productIds}
    //     ];

    //     APIResult productsResult =
    //         await Apiraiser.data.getByConditions("Products", conditions);

    //     List<Product> products = (productsResult.data as List<dynamic>)
    //         .map((p) => Product.fromJson(p as Map<String, dynamic>))
    //         .toList();

    //     for (int i = 0; i < products.length; i++) {
    //       products[i].variations = productVariations
    //           .where((element) => element.product == products[i].id)
    //           .toList();
    //     }

    //     return products;
    //   } else {
    //     return [];
    //   }
    // }
  }
}
