import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final int? id;
  final DateTime? createdOn;
  final int? createdBy;
  final DateTime? lastUpdatedOn;
  final int? lastUpdatedBy;
  final String name;
  final String? description;
  final double? price;
  final bool isVariedProduct;
  final int thumbnail;
  final int gallery;
  final int collection;
  final List<int>? keywords;
  final double? discounPrice;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final String sku;
  final Map<String, int>? options;

  // final int? media;

  const Product({
    this.id,
    this.createdOn,
    this.createdBy,
    this.lastUpdatedOn,
    this.lastUpdatedBy,
    required this.name,
    this.description,
    this.price,
    this.isVariedProduct = false,
    required this.collection,
    required this.thumbnail,
    required this.keywords,
    required this.gallery,
    this.discounPrice,
    this.discountStartDate,
    this.discountEndDate,
    required this.sku,
    this.options,
  });

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
        id: json['Id'] as int,
        createdOn: json['CreatedOn'] != null
            ? (json['CreatedOn'] is String)
                ? DateTime.parse(json['CreatedOn'] as String)
                : json['CreatedOn']
            : null,
        createdBy: json['CreatedBy'] as int?,
        lastUpdatedOn: json['LastUpdatedOn'] != null
            ? (json['LastUpdatedOn'] is String)
                ? DateTime.parse(json['LastUpdatedOn'] as String)
                : json['LastUpdatedOn']
            : null,
        lastUpdatedBy: json['LastUpdatedBy'] as int?,
        name: json['Name'] as String,
        description: json['Description'] as String?,

        // // json['Image'] as String,
        // // json['Image'] != null
        // //     ? (json['Image'] as List<dynamic>).map((e) => e as int).toList()
        // //     : null,
        price: json['Price'] as double?,
        isVariedProduct: json['IsVariedProduct'] as bool,
        collection: json['Collection'] as int,
        thumbnail: json['Thumbnail'] as int,

        keywords: json['Keywords'] != null
            ? (json['Keywords'] as List<dynamic>)
                .map((e) => convertToInt(e))
                .toList()
            // ? (json['Variations'] as List<int>)
            : [],
        gallery: json['Gallery'] as int,

        discounPrice: json['DiscountPrice'] as double?,
        discountStartDate: json['DiscountStartDate'] != null
            ? (json['DiscountStartDate'] is String)
                ? DateTime.parse(json['DiscountStartDate'] as String)
                : json['DiscountStartDate']
            : null,
        discountEndDate: json['DiscountEndDate'] != null
            ? (json['DiscountEndDate'] is String)
                ? DateTime.parse(json['DiscountEndDate'] as String)
                : json['DiscountEndDate']
            : null,
        sku: json['SKU'] as String,
        options: json['Options'] != null &&
                (json['Options'] as String).isNotEmpty
            ? (jsonDecode(json['Options'] as String) as Map<String, dynamic>)
                .cast<String, int>()
            : {},

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
    Map<String, dynamic> optionsMap = {};
    if (instance.options != null && instance.options!.isNotEmpty) {
      for (var entry in instance.options!.entries) {
        optionsMap[entry.key] = entry.value;
      }
    }

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
      'DiscountStartDate': instance.discountStartDate != null
          ? instance.discountStartDate!.toIso8601String()
          : null,
      'DiscountEndDate': instance.discountEndDate != null
          ? instance.discountEndDate!.toIso8601String()
          : null,
      'SKU': instance.sku,
      'Options': jsonEncode(optionsMap),

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
