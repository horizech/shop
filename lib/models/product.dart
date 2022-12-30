import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final int id;
  final DateTime? createdOn;
  final int? createdBy;
  final DateTime? lastUpdatedOn;
  final int? lastUpdatedBy;
  final String name;
  final String? description;
  final double? price;
  final bool isVariedProduct;
  final int? thumbnail;
  final int? gallery;
  final int collection;
  final List<int> keywords;
  final double? discounPrice;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final String? sku;

  // final int? media;

  const Product(
    this.id,
    this.createdOn,
    this.createdBy,
    this.lastUpdatedOn,
    this.lastUpdatedBy,
    this.name,
    this.description,
    this.price,
    this.isVariedProduct,
    this.collection,
    this.thumbnail,
    this.keywords,
    this.gallery,
    this.discounPrice,
    this.discountStartDate,
    this.discountEndDate,
    this.sku,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      // Map<int, List<String>> variations = {};
      // try {
      //   dynamic variationsIn = json['Variations'] as dynamic;
      //   if (variationsIn != null && (variationsIn as String).isNotEmpty) {
      //     Map<String, dynamic> vJson = jsonDecode(variationsIn);
      //     if (vJson.isNotEmpty) {
      //       for (var element in vJson.entries) {
      //         variations[int.parse(element.key)] = (element.value as String)
      //             .split(",")
      //             .map((e) => e.trim())
      //             .toList();
      //       }
      //     }
      //   }
      // } catch (e) {
      //   variations = {};
      // }

      Product product = Product(
        json['Id'] as int,
        json['CreatedOn'] != null
            ? (json['CreatedOn'] is String)
                ? DateTime.parse(json['CreatedOn'] as String)
                : json['CreatedOn']
            : null,
        json['CreatedBy'] as int?,
        json['LastUpdatedOn'] != null
            ? (json['LastUpdatedOn'] is String)
                ? DateTime.parse(json['LastUpdatedOn'] as String)
                : json['LastUpdatedOn']
            : null,
        json['LastUpdatedBy'] as int?,
        json['Name'] as String,
        json['Description'] as String?,

        // // json['Image'] as String,
        // // json['Image'] != null
        // //     ? (json['Image'] as List<dynamic>).map((e) => e as int).toList()
        // //     : null,
        json['Price'] as double?,
        json['IsVariedProduct'] as bool,
        json['Collection'] as int,
        json['Thumbnail'] as int?,

        // variations,
        // // json['Variations'] != null
        // //     ? (json['Variations'] as dynamic)
        // //         .map((e) => convertToInt(e))
        // //         .toList()
        // //     // ? (json['Variations'] as List<int>)
        // //     : [],
        json['Keywords'] != null
            ? (json['Keywords'] as List<dynamic>)
                .map((e) => convertToInt(e))
                .toList()
            // ? (json['Variations'] as List<int>)
            : [],
        json['Gallery'] as int?,

        json['DiscountPrice'] as double?,
        json['DiscountStartDate'] != null
            ? (json['DiscountStartDate'] is String)
                ? DateTime.parse(json['DiscountStartDate'] as String)
                : json['DiscountStartDate']
            : null,
        json['DiscountEndDate'] != null
            ? (json['DiscountEndDate'] is String)
                ? DateTime.parse(json['DiscountEndDate'] as String)
                : json['DiscountEndDate']
            : null,
        json['SKU'] as String?,

        // json['Media'] as int?,
      );
      // const []);
      return product;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static int convertToInt(dynamic a) {
    return int.parse(a.toString());
  }

  static Map<String, dynamic> toJson(Product instance) {
    // Map<String, dynamic> variationsMap = {};
    // if (instance.variations.isNotEmpty) {
    //   for (var entry in instance.variations.entries) {
    //     variationsMap["${entry.key}"] = entry.value.join(",");
    //   }
    // }

    return <String, dynamic>{
      'Id': instance.id,
      'CreatedOn': instance.createdOn,
      'CreatedBy': instance.createdBy,
      'LastUpdatedOn': instance.lastUpdatedOn,
      'LastUpdatedBy': instance.lastUpdatedBy,
      'Name': instance.name,
      'Description': instance.description,
      'Price': instance.price,
      'IsVariedProduct': instance.isVariedProduct,
      'Collection': instance.collection,

      'Thumbnail': instance.thumbnail,

      // 'SKU': instance.sKU,
      // // 'Image': instance.img,

      'Keyword': instance.keywords,
      'Gallery': instance.gallery,
      'DiscountPrice': instance.discounPrice,
      'DiscountStartDate': instance.discountStartDate,
      'DiscountEndDate': instance.discountEndDate,
      'SKU': instance.sku,

      // 'Variations': jsonEncode(variationsMap),
      // 'Media': instance.media
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdOn,
        createdBy,
        lastUpdatedOn,
        lastUpdatedBy,
        name,
        description,
        price,
        thumbnail,
      ];

  // static List<Product> product = [
  //   const Product(
  //       1,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "Black baby shirt",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p03",
  //       "img3.jpg",
  //       1000),
  //   const Product(
  //       2,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "baby black jacket",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p04",
  //       "img5.jpg",
  //       900),
  //   const Product(
  //       3,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "tshirt for boys",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p05",
  //       "img6.jpg",
  //       300),
  //   const Product(
  //       4,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "watch",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p06",
  //       "img 10.jpg",
  //       1000),
  //   const Product(
  //       6,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "shirt",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p01",
  //       "img1.jpg",
  //       2000),
  //   const Product(
  //       5,
  //       null,
  //       null,
  //       null,
  //       null,
  //       "trouser",
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nulla suscipit, pellentesque libero eget, maximus tortor..",
  //       "p02",
  //       "img2.jpg",
  //       2000),
  // ];
}
